
---
title: Multi-Cluster Example
linktitle: Multi-Cluster Example
type: docs
description: An example how to build a multi-cluster environment using GKE/GSM/DNS
weight: 101
---
 
This is an example on how to build a multi-cluster environment having two separate cluster repos (i.e. 'dev' and 'prod'). The steps will include building a GKE/GSM/DSN environment from scratch for both environments, and deploying projects to staging and the remote production. It will use DNS (`jx3rocks.com`), TLS, Let's Encrypt certificates. This example is intended for an audience already familiar with Jenkins X operability and focuses on an example of actual commands used to build a multi-cluster environment. Additional information regarding using Google as the provider for this example can be found under [Google Cloud Platform Prequisites](/v3/admin/guides/tls_dns/#prerequisites).

> ⚠️ Note to _OSX_ users 
> You may need to substitute `sed -i` commands with `sed -i.bak`, taking note to delete the generated .bak file.
> Some `sed -i` commands that are additive might not work but can easily be completed with a text editor.

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
git push -u origin main
```
Building `PROD CLUSTER` repo: `https://github.com/${JX3ORG}/jx3-gke-gsm.prd`
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-gke-gsm.git jx3-gke-gsm.prd
cd jx3-gke-gsm.prd
git remote set-url origin https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git
hub create -p ${JX3ORG}/jx3-gke-gsm.prd
git commit -a -m "chore: Initial"
git push -u origin main
```
Building `DEV INFRA` repo: `https://github.com/${JX3ORG}/jx3-terraform-gke.dev` 
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-terraform-gke.git jx3-terraform-gke.dev
cd  jx3-terraform-gke.dev
git remote set-url origin https://github.com/${JX3ORG}/jx3-terraform-gke.dev.git
hub create -p ${JX3ORG}/jx3-terraform-gke.dev
git commit -a -m "chore: Initial"
git push -u origin main
```
Buidling `DEV CLUSTER` repo: `https://github.com/${JX3ORG}/jx3-gke-gsm.prd`
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-gke-gsm.git jx3-gke-gsm.prd
cd jx3-gke-gsm.prd
git remote set-url origin https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git
hub create -p ${JX3ORG}/jx3-gke-gsm.prd
git commit -a -m "chore: Initial"
git push -u origin main
```
### Initialize the Prod cluster repo
Prepare the remote prod cluster repo by using the out of the box (OOTB) config (i.e.  dev, jx-staging, and jx-production environemnts). Also remove the default '-jx' URL value and insert jx-production '-prd' URL value (optional).  Prior to building the prod infra repo, prepare the production cluster repo for use by removing unecessary components. The components to modify/remove in the designated remote prod environment are:
* Remove default '-jx.' URL format (optional)
* Remove Non-used JX charts 
* Remove Tekton pipelines
* Add jxgh/local-external-secrets chart (optional)
* Insert imagePullSecret in jx-global-variables.yaml (optional)
* Disable webhooks

> ⚠️ For [cluster autoupdate](/v3/admin/setup/upgrades/cluster/#automatic-upgrades) support both the Lighthouse and jxboot-helmfile-resources charts must be removed.

```bash
cd ${JX3HOME}/jx3-gke-gsm.prd
# File removals
rm -rf helmfiles/tekton-pipelines
# Modifications
sed -i 's/-jx././g' jx-requirements.yml 
sed -i '/tekton-pipelines/d' helmfile.yaml

# JX Chart removals
sed -i '/- chart: jxgh\/jx-pipelines-visualizer/,/  - jx-values.yaml/d' helmfiles/jx/helmfile.yaml
sed -i '/- chart: jxgh\/jx-preview/,/  - jx-values.yaml/d' helmfiles/jx/helmfile.yaml
sed -i '/- chart: jxgh\/lighthouse/,/  - jx-values.yaml/d' helmfiles/jx/helmfile.yaml
sed -i '/- chart: jxgh\/jxboot-helmfile-resources/,/  - jx-values.yaml/d' helmfiles/jx/helmfile.yaml
sed -i '/- chart: jxgh\/jx-build-controller/,/  - jx-values.yaml/d' helmfiles/jx/helmfile.yaml

# JX Chart additions (jxgh/local-external-secrets chart)
sed -i '/templates:/ i - chart: jxgh/local-external-secrets' helmfiles/jx/helmfile.yaml
sed -i '/templates:/ i   version: 0.0.14' helmfiles/jx/helmfile.yaml
sed -i '/templates:/ i   name: local-external-secrets' helmfiles/jx/helmfile.yaml
sed -i '/templates:/ i   values:' helmfiles/jx/helmfile.yaml
sed -i '/templates:/ i   - jx-values.yaml' helmfiles/jx/helmfile.yaml

# jx-global-values changes 
sed -i '/imagePullSecrets:/d' jx-global-values.yaml
sed -i '/jx:/ a\ \ \ - tekton-container-registry-auth' jx-global-values.yaml
sed -i '/jx:/ a\ \ imagePullSecrets:' jx-global-values.yaml

# Makefile changes
sed -i '/include/ i # lets disable the dev cluster settings' Makefile
sed -i '/include/ i COPY_SOURCE = no-copy-source' Makefile
sed -i '/include/ i GENERATE_SCHEDULER = no-gitops-scheduler' Makefile
sed -i '/include/ i REPOSITORY_RESOLVE = no-repository-resolve' Makefile
sed -i '/include/ i GITOPS_WEBHOOK_UPDATE = no-gitops-webhook-update' Makefile

jx gitops helmfile resolve

git commit -a -m "chore: prod cluster repo init"
git push

### Remote Prod Chart List
for i in `find helmfiles -name helmfile.yaml`; do echo; echo $i; grep -- ^-\ chart $i ; done
```
### Remote Prod Chart List
```
helmfiles/kuberhealthy/helmfile.yaml
- chart: jxgh/kh-tls-check

helmfiles/jx-staging/helmfile.yaml
- chart: jxgh/jx-verify

helmfiles/secret-infra/helmfile.yaml
- chart: external-secrets/kubernetes-external-secrets
- chart: jxgh/pusher-wave

helmfiles/jx/helmfile.yaml
- chart: bitnami/external-dns
- chart: jxgh/acme
- chart: jxgh/jenkins-x-crds
- chart: jenkins-x/nexus
- chart: stable/chartmuseum
- chart: jxgh/jx-kh-check
- chart: jxgh/local-external-secrets

helmfiles/jx-production/helmfile.yaml
- chart: jxgh/jx-verify

helmfiles/cert-manager/helmfile.yaml
- chart: jetstack/cert-manager

helmfiles/nginx/helmfile.yaml
- chart: ingress-nginx/ingress-nginx

helmfiles/tekton-pipelines/helmfile.yaml
- chart: cdf/tekton-pipeline
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
Prepare the dev cluster repo by using the out of the box (OOTB) config (i.e.  dev, jx-staging, and jx-production environemnts). Also remove the default '-jx' URL value and insert jx-production '-prd' URL value (optional). Later on prior to importing the external steps will be used to remove the jx-prodcution environment (optional).
```bash
cd ${JX3HOME}/jx3-gke-gsm.dev
sed -i 's/-jx././g' jx-requirements.yml 
sed -i '/- key: production/ a\ \ \ \ \  namespaceSubDomain: -prd.' jx-requirements.yml
sed -i '/- key: production/ a\ \ \ \ ingress:' jx-requirements.yml
jx gitops helmfile resolve
git commit -a -m "chore: dev cluster repo init"
git push

### Dev Chart List (Initial)
for i in `find helmfiles -name helmfile.yaml`; do echo; echo $i; grep -- ^-\ chart $i ; done
```
### Dev Chart List (Initial)
```
helmfiles/kuberhealthy/helmfile.yaml
- chart: jxgh/kh-tls-check

helmfiles/jx-staging/helmfile.yaml
- chart: jxgh/jx-verify

helmfiles/secret-infra/helmfile.yaml
- chart: external-secrets/kubernetes-external-secrets
- chart: jxgh/pusher-wave

helmfiles/jx/helmfile.yaml
- chart: bitnami/external-dns
- chart: jxgh/acme
- chart: jxgh/jxboot-helmfile-resources
- chart: jxgh/jenkins-x-crds
- chart: jxgh/jx-pipelines-visualizer
- chart: jxgh/jx-preview
- chart: jenkins-x/lighthouse
- chart: jenkins-x/nexus
- chart: stable/chartmuseum
- chart: jxgh/jx-build-controller
- chart: jxgh/jx-kh-check

helmfiles/jx-production/helmfile.yaml
- chart: jxgh/jx-verify

helmfiles/cert-manager/helmfile.yaml
- chart: jetstack/cert-manager

helmfiles/nginx/helmfile.yaml
- chart: ingress-nginx/ingress-nginx

helmfiles/tekton-pipelines/helmfile.yaml
- chart: cdf/tekton-pipeline
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
Add the remote prod repo as your production target by importing. PLEASE NOTE: Prior to importing the remote repo make sure all updates to the dev repo have completed.
```bash
# Make sure you're in the dev cluster
kubectl config use-context $DEV_CONTEXT
jx ns jx
# Make sure you're not in the cluster repo directory
cd $JX3HOME
jx project import --url https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git 
```
The '`jx project import`' command will begin to display the following:
```
we are now going to create a Pull Request on the development cluster git repository to setup CI/CD via GitOps

created file /tmp/jx-git-973407466/.jx/gitops/source-config.yaml
Created Pull Request: https://github.com/jx3rocks/jx3-gke-gsm.src/pull/1

we now need to wait for the Pull Request to merge so that CI/CD can be setup via GitOps

Waiting up to 20m0s for the pull request https://github.com/jx3rocks/jx3-gke-gsm.src/pull/1 to merge with poll period 20s....

```
Merge the outstanding pull request for 
```bash
${JX3ORG}/jx3-gke-gsm.src chore: import repository https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git  env/dev
```
Below is an example of the URL for the PR:
```bash
https://github.com/${JX3ORG}/jx3-gke-gsm.src/pull/1
```
Once the pull request is merged, it proceeds to wait for a trigger to be added to the lighthouse config:
```
Pull Request https://github.com/${JX3ORG}/jx3-gke-gsm.src/pull/1 was merged at sha a07df43fcad60df439dad087cf4502f00e002190 after waiting 12m7.719699579s

waiting up to 20m0s for a trigger to be added to the lighthouse configuration in ConfigMap config in namespace jx for repository: jx3rocks/jx3-gke-gsm-prd
you can watch the boot job to update the configuration via: jx admin log
for more information on how this works see: https://jenkins-x.io/docs/v3/about/how-it-works/#importing--creating-quickstarts
```
Eventually the process appears to time out waiting for the adding of the trigger.
```
WARNING: It looks like the boot job failed to setup this project.
You can view the log via: jx admin log
error: failed to wait for repository to be setup in lighthouse: failed to find trigger in the lighthouse configuration in ConfigMap config in namespace jx for repository: jx3rocks/jx3-gke-gsm-prd within 20m0s
error: failed to wait for the pipeline to be setup jx3rocks/jx3-gke-gsm-prd: failed to run 'jx pipeline wait --owner jx3rocks --repo jx3-gke-gsm-prd' command in directory '', output: ''
```
### Adjust Prod Repo Promotion Type (optional)
The newly imported prod repo has a promotion type of 'Auto'. To change this 'Manual' to provide greater deployment control make adjustments in the jx-requirements.yml file:
```bash
## current environment settings
kubectl get env
NAME              NAMESPACE            KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev               jx                   Development   Never               https://github.com/${JX3ORG}/jx3-gke-gsm.src.git   master
jx3-gke-gsm-prd   jx-jx3-gke-gsm-prd   Permanent     Auto        500     https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git   master
production        jx-production        Permanent     Manual      500                                                       
staging           jx-staging           Permanent     Auto        100      

cd ${JX3HOME}/jx3-gke-gsm.dev
git pull
sed -i 's/promotionStrategy: Auto/promotionStrategy: Manual/g' jx-requirements.yml 
git commit -a -m "chore: remote repo manual promotion"
git push

## new environment settings 
kubectl get env
NAME              NAMESPACE            KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev               jx                   Development   Never               https://github.com/${JX3ORG}/jx3-gke-gsm.src.git   master
jx3-gke-gsm-prd   jx-jx3-gke-gsm-prd   Permanent     Manual        500     https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git   master
production        jx-production        Permanent     Manual      500                                                       
staging           jx-staging           Permanent     Auto        100      

```
### Remove jx-production environment (optional)
To have a single designated production environment remove the dev repo's jx-production environment.
```bash
cd ${JX3HOME}/jx3-gke-gsm.dev
sed -i '/- key: production/d' jx-requirements.yml 
sed -i '/jx-production/d' helmfile.yaml
rm -rf helmfiles/jx-production
jx gitops helmfile resolve
git commit -a -m "chore: remove jx-production"
git push
``` 
### Environments
Both the dev and remote prod repos are now ready for deployments.
```bash
# Development
kubectl config use-context $DEV_CONTEXT
kubectl get env
NAME              NAMESPACE            KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev               jx                   Development   Never               https://github.com/${JX3ORG}/jx3-gke-gsm.src.git   master
jx3-gke-gsm-prd   jx-jx3-gke-gsm-prd   Permanent     Manual      500     https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git   master
staging           jx-staging           Permanent     Auto        100 

# Production
kubectl config use-context $PROD_CONTEXT
kubectl get env
NAME   NAMESPACE   KIND          PROMOTION   ORDER   GIT URL                                           GIT BRANCH
dev    jx          Development   Never               https://github.com/${JX3ORG}/jx3-gke-gsm.prd.git   master
```
### Set Dev Container Registry to Public
In order to deploy applications to the remote prod environment it is required that the dev container registry is publically available. The image below highlights how you can make the change using the Google console.

![Container Setting](/images/v3/setContainer.png)

Or you can use the following command:
```bash
gsutil iam ch allUsers:objectViewer gs://artifacts.${PROJECT}.appspot.com
```
### Deploy Quickstart Project
To ensure everything is working as intended, the following commands will create and deploy a simple NodeJS app to staging and the remote production.
```bash
kubectl config use-context $DEV_CONTEXT
jx ns jx
cd ${JX3HOME}
# Using quickstart deploy app to staging
jx project quickstart --git-token ${TF_VAR_jx_bot_token} --git-username ${TF_VAR_jx_bot_user} --filter node-http --org ${JX3ORG} --batch-mode  --name node-http01
```
### Merge Pull Requests
For deployment to remote prod you must merge the auto generated pull request.
```bash
https://github.com/${JX3ORG}/jx3-gke-gsm.prd/pulls
```
### Project Deployments
```bash
# Confirm deployment for Development
kubectl config use-context $DEV_CONTEXT
jx ns jx
jx get applications
APPLICATION STAGING PODS URL
node-http01 0.0.1   1/1  https://node-http01.dev.jx3rocks.com

# Confirm deployment for reomote prod
jx get applications -e jx3-gke-gsm-prd
APPLICATION
node-http01

kubectl config use-context $PROD_CONTEXT
jx ns jx
kubectl get ing -n jx-jx3-gke-gsm-prd
NAME          CLASS    HOSTS                           ADDRESS         PORTS     AGE
node-http01   <none>   node-http01.prd.jx3rocks.com   34.86.236.247   80, 443   6m9s


# URLS
Dev:  https://node-http01.dev.jx3rocks.com
Prod: https://node-http01.prd.jx3rocks.com
```
