
---
title: Multi-Cluster Example
linktitle: Multi-Cluster Example
type: docs
description: An example how to build a multi-cluster environment using GKE/GSM/DNS
weight: 101
---
 
This is an example on how to build a multi-cluster environment having two separate cluster repos (i.e. 'dev' and 'prod'). The steps will include building a GKE/GSM/DSN environment from scratch for both environments, and deploying projects to staging and the remote production. It will use DNS (`jx3rocks.com`), TLS, Let's Encrypt certificates. This example is intended for an audience already familiar with Jenkins X operability and focuses on an example of actual commands used to build a multi-cluster environment. Additional information regarding using Google as the provider for this example can be found under [Google Cloud Platform Prequisites](/v3/admin/guides/tls_dns/#prerequisites).

### Generate the Infra and Cluster Repos for Dev and Prod
Using a command-line based approach, the example employs a process modeled after the doc [Setup Jenkins X on Google Cloud with GKE](/v3/admin/platforms/google), and will use Google Secret Manger. It requires the installation of [Git](https://git-scm.com/downloads) and [Hub](https://hub.github.com/) command line tools. 

The following are the values used for the creation of the Infra and Cluster repos for both the Dev and Prod environments:
```
Repo Source:		jx3-gitops-repositories
Prod Infra Repo:	jx3-terraform-gke.prd
Prod Cluster Repo:	jx3-gke-gsm.prd
Dev Infra Repo:		jx3-terraform-gke.dev
Dev Cluster Repo:	jx3-gke-gsm.dev
Git Organization:	$JX3ORG
JX3 Root Directory:	$JX3HOME
```
Building `PROD INFRA` repo: `https://github.com/${JX3ORG}/jx3-terraform-gke.prd` 
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-terraform-gke.git jx3-terraform-gke.prd
cd  jx3-terraform-gke.prd
git remote set-url origin https://github.com/${JX3ORG}/jx3-terraform-gke.prd.git
hub create -p ${JX3ORG}/jx3-terraform-gke.prd
git commit -a -m "chore: Initial"
git push -u origin master
```
Building `PROD CLUSTER` repo: `https://github.com/${JX3ORG}/jx3-gke-gsm.prd`
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-gke-gsm.git jx3-gke-gsm.prd
cd jx3-gke-gsm.prd
git remote set-url origin https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git
hub create -p ${JX3ORG}/jx3-gke-gsm.prd
git commit -a -m "chore: Initial"
git push -u origin master
```
Building `DEV INFRA` repo: `https://github.com/${JX3ORG}/jx3-terraform-gke.dev` 
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-terraform-gke.git jx3-terraform-gke.dev
cd  jx3-terraform-gke.dev
git remote set-url origin https://github.com/${JX3ORG}/jx3-terraform-gke.dev.git
hub create -p ${JX3ORG}/jx3-terraform-gke.dev
git commit -a -m "chore: Initial"
git push -u origin master
```
Buidling `DEV CLUSTER` repo: `https://github.com/${JX3ORG}/jx3-gke-gsm.prd`
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-gke-gsm.git jx3-gke-gsm.prd
cd jx3-gke-gsm.prd
git remote set-url origin https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git
hub create -p ${JX3ORG}/jx3-gke-gsm.prd
git commit -a -m "chore: Initial"
git push -u origin master
```
### Initialize the Prod cluster repo
Prior to building the prod infra repo, prepare the production cluster repo for use by removing unecessary components.
```bash
cd ${JX3HOME}/jx3-gke-gsm.prd
sed -i '/- key: production/d' jx-requirements.yml 
sed -i 's/-jx././g' jx-requirements.yml 
git commit -a -m "chore: prod cluster repo init"
git push
```
### Build the prod infra with Terraform
The following TF_VAR environment variables are set prior to running Terraform commands:
```
TF_VAR_gcp_project=<prod google project>
TF_VAR_apex_domain_gcp_project=<dns google project>
TF_VAR_jx_bot_username=<git username>
TF_VAR_jx_bot_token=<git token>
TF_VAR_tls_email=mymail@jx3rocks.com

TF_VAR_apex_domain=jx3rocks.com
TF_VAR_subdomain=prd

TF_VAR_gsm=true
TF_VAR_cluster_name=jx3prd
TF_VAR_cluster_location=us-east4-c
TF_VAR_jx_git_url=https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git
TF_VAR_lets_encrypt_production=true
TF_VAR_force_destroy=true
```
Additional details on Terraform settings can be found under [Google Terraform Quickstart Template](https://github.com/jx3-gitops-repositories/jx3-terraform-gke/blob/master/README.md)

Commands to build infrastructure: 
```bash
cd ${JX3HOME}/jx3-terraform-gke.prd
bin/create.sh                # Performs terraform init, plan and apply
```
Validate the prod certificate is active and health checks pass:
```bash
gcloud container clusters get-credentials jx3prd --zone us-east4-c --project <prod gcp project>
export PROD_CONTEXT=`kubectl config current-context`
jx ns jx
# Wait until the following status are all "green"
jx health status --all-namespaces -w

NAME                          NAMESPACE                     STATUS    ERROR MESSAGE
certmanager-tls               kuberhealthy                  OK                   
daemonset                     kuberhealthy                  OK                   
deployment                    kuberhealthy                  OK                   
dns-status-internal           kuberhealthy                  OK                   
jx-bot-token                  jx                            OK                   
jx-install                    jx-git-operator               OK                   
jx-pod-status                 kuberhealthy                  OK                   
jx-secrets                    kuberhealthy                  OK                   
jx-webhook                    jx                            OK                   
jx-webhook-events             jx                            OK                   
network-connection-check      kuberhealthy                  OK   
```
### Initialize the Dev cluster repo
Prepare the dev cluster repo for use by removing unecessary components.
```bash
cd ${JX3HOME}/jx3-gke-gsm.dev
sed -i '/- key: production/d' jx-requirements.yml 
sed -i 's/-jx././g' jx-requirements.yml 
git commit -a -m "chore: dev cluster repo init"
git push
```
### Build the dev infra with Terraform
The following TF_VAR environment variables are set prior to running Terraform commands:
```
TF_VAR_gcp_project=<dev google project>
TF_VAR_apex_domain_gcp_project=<dns google project>
TF_VAR_jx_bot_username=<git username>
TF_VAR_jx_bot_token=<git token>
TF_VAR_tls_email=mymail@jx3rocks.com

TF_VAR_apex_domain=jx3rocks.com
TF_VAR_subdomain=dev

TF_VAR_gsm=true
TF_VAR_cluster_name=jx3dev
TF_VAR_cluster_location=us-east1-b
TF_VAR_jx_git_url=https://github.com/${JX3ORG}/jx3-gke-gsm.dev.git
TF_VAR_lets_encrypt_production=true
TF_VAR_force_destroy=true
```
Additional details on Terraform settings can be found under [Google Terraform Quickstart Template](https://github.com/jx3-gitops-repositories/jx3-terraform-gke/blob/master/README.md)

Commands to build intrastructure: 
```bash
cd ${JX3HOME}/jx3-terraform-gke.dev
bin/create.sh                # Performs terraform init, plan and apply
```
To validate the prod certificate is active and health checks pass:
```bash
gcloud container clusters get-credentials jx3dev --zone us-east1-b --project <dev gcp project>
export DEV_CONTEXT=`kubectl config current-context`
jx ns jx
# Wait until the following status are all "green"
jx health status --all-namespaces -w

NAME                          NAMESPACE                     STATUS                        ERROR MESSAGE
certmanager-tls               kuberhealthy                  OK                   
daemonset                     kuberhealthy                  OK                   
deployment                    kuberhealthy                  OK                   
dns-status-internal           kuberhealthy                  OK                   
jx-bot-token                  jx                            OK                   
jx-install                    jx-git-operator               OK                   
jx-pod-status                 kuberhealthy                  OK                   
jx-secrets                    kuberhealthy                  OK                   
jx-webhook                    jx                            OK                   
jx-webhook-events             jx                            OK                   
network-connection-check      kuberhealthy                  OK   
```
### Import Remote Prod Repo
```bash
# Make sure you're in the dev cluster
kubectl config use-context $DEV_CONTEXT
jx ns jx
jx project import --url https://github.com/jx3rocks/jx3-gke-gsm.prd.git 
```
```
we are now going to create a Pull Request on the development cluster git repository to setup CI/CD via GitOps

created file /tmp/jx-git-643546451/.jx/gitops/source-config.yaml
Created Pull Request: https://github.com/jx3rocks/jx3-gke-gsm.dev/pull/1

we now need to wait for the Pull Request to merge so that CI/CD can be setup via GitOps

Waiting up to 20m0s for the pull request https://github.com/jx3rocks/jx3-gke-gsm.dev/pull/1 to merge with poll period 20s....
Pull Request https://github.com/jx3rocks/jx3-gke-gsm.dev/pull/1 was merged at sha 92e226e6e52cc96c1a84ba8dc455900d41cfe09d after waiting 2m1.698196955s

waiting up to 20m0s for a trigger to be added to the lighthouse configuration in ConfigMap config in namespace jx for repository: jx3rocks/jx3-gke-gsm-prd
you can watch the boot job to update the configuration via: jx admin log
for more information on how this works see: https://jenkins-x.io/docs/v3/about/how-it-works/#importing--creating-quickstarts


WARNING: It looks like the boot job failed to setup this project.
You can view the log via: jx admin log
error: failed to wait for repository to be setup in lighthouse: failed to find trigger in the lighthouse configuration in ConfigMap config in namespace jx for repository: jx3rocks/jx3-gke-gsm-prd within 20m0s
error: failed to wait for the pipeline to be setup jx3rocks/jx3-gke-gsm-prd: failed to run 'jx pipeline wait --owner jx3rocks --repo jx3-gke-gsm-prd' command in directory '', output: ''
```
### Environments
```bash
# Development
kubectl config use-context $DEV_CONTEXT
kubectl get env
NAME              NAMESPACE            KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev               jx                   Development   Never               https://github.com/jx3rocks/jx3-gke-gsm.dev.git   master
jx3-gke-gsm-prd   jx-jx3-gke-gsm-prd   Permanent     Auto        500     https://github.com/jx3rocks/jx3-gke-gsm.prd.git   master
staging           jx-staging           Permanent     Auto        100     

# Production
kubectl config use-context $PROD_CONTEXT
kubectl get env
NAME      NAMESPACE    KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev       jx           Development   Never               https://github.com/jx3rocks/jx3-gke-gsm.prd.git   master
staging   jx-staging   Permanent     Auto        100           
```
### Set Dev Container Registry to Public
In order to deploy applications to the remote prod environment it is required that the dev container registry is publically available. The image below highlights how you can make the change using the Google console.

![Container Setting](/images/v3/setContainer.png)
### Deploy Quickstart Project
To ensure everything is working as intended, the following commands will create and deploy a simple NodeJS app to staging and the remote production.
```bash
kubectl config use-context $DEV_CONTEXT
jx ns jx
# Using quickstart deploy app to staging
jx project quickstart --git-token ${TF_VAR_jx_bot_token} --git-username ${TF_VAR_jx_bot_user} --filter node-http --org ${JX3ORG} --batch-mode  --name node-http01

# Confirm deployments
kubectl config use-context $DEV_CONTEXT
kubectl get environments
NAME              NAMESPACE            KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev               jx                   Development   Never               https://github.com/jx3rocks/jx3-gke-gsm.dev.git   master
jx3-gke-gsm-prd   jx-jx3-gke-gsm-prd   Permanent     Auto        500     https://github.com/jx3rocks/jx3-gke-gsm.prd.git   master
staging           jx-staging           Permanent     Auto        100   

jx get applications
APPLICATION STAGING PODS URL
node-http01 0.0.1   1/1  https://node-http01.dev.jx3rocks.com

jx get applications -e jx3-gke-gsm-prd
APPLICATION
node-http01

kubectl config use-context $PROD_CONTECT
kubectl get environments
kubectl get env
NAME      NAMESPACE    KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev       jx           Development   Never               https://github.com/jx3rocks/jx3-gke-gsm.prd.git   master
staging   jx-staging   Permanent     Auto        100           

# URLS
Dev:  https://node-http01.dev.jx3rocks.com
Prod: https://node-http01.prd.jx3rocks.com
```
