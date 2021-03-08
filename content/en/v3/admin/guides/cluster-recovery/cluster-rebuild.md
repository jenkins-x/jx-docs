---
title: Cluster Rebuild Example
linktitle: Cluster Rebuild Example
type: docs
description: An example how to rebuild a existing environment back to its original state prior to shutdown.
weight: 300
---
 
This is an example on how to treat your clusters as cattle and not pets by rebuilding a JX3/GKE environment and restoring to it's previous configuration. The steps will include building a JX3 Google/GSM environment from scratch and deploying projects to staging and production. It will utilize DNS (`jx3rocks.com`), TLS, Let's Encrypt certificates. The example includes the recovery of the helm chart repository which is currently implemented with [ChartMuseum](https://github.com/helm/chartmuseum) . This example is inteded for an audience already familiar with Jenkins X operability and focuses on an example of actual commands used to build and maintain a recoverable  environment. Additional information regarding using Google as the provider for this example can be found under [Google Cloud Platform Prequisites](/v3/admin/guides/tls_dns/#prerequisites).

If you wish to bypass the initial building of the cluster and project deployment steps, go to [Prepare for outtage](/v3/admin/guides/cluster-rebuild/#prepare-for-outtage) for the cluster rebuilding steps.
### Initialize the Infra and Cluster Repos
Using a command-line based approach, the example employs a process modeled after the doc [Setup Jenkins X on Google Cloud with GKE](/v3/admin/platforms/google), and will use Google Secret Manger. It requires installation of [Git](https://git-scm.com/downloads) and [Hub](https://hub.github.com/) command line tools. 

The following are the values used for the creation of the Infra and Cluster repos:
```
Repo Source:		jx3-gitops-repositories
Infra Repo:		jx3-terraform-gke
Cluster Repo:		jx3-gke-gsm
Git Organization:	$JX3ORG
JX3 Root Directory:	$JX3HOME
```
Building infra repo: `https://github.com/${JX3ORG}/jx3-terraform-gke` 
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-terraform-gke.git jx3-terraform-gke
cd  jx3-terraform-gke
git remote set-url origin https://github.com/${JX3ORG}/jx3-terraform-gke.git
hub create -p ${JX3ORG}/jx3-terraform-gke
git commit -a -m "chore: Initial"
git push -u origin master
```
Buidling cluster repo: `https://github.com/${JX3ORG}/jx3-gke-gsm`
```bash
cd ${JX3HOME}
git clone https://github.com/jx3-gitops-repositories/jx3-gke-gsm.git jx3-gke-gsm
cd jx3-gke-gsm
git remote set-url origin https://github.com/${JX3ORG}/jx3-gke-gsm.git
hub create -p ${JX3ORG}/jx3-gke-gsm
git commit -a -m "chore: Initial"
git push -u origin master
```
### Manage URL format
This example uses external DNS with subdomain and URLs will have a root of `web.jx3rocks.com`. To avoid including the default string `"-jx"`  in the URLs, the example blanks out the `spec:ingress:namespaceSubDomain` value (`"."`) in the `jx-requirements.yml` file. To eliminate having non-unique URLs after doing this type of update, an additional `spec:environment:ingress:namespaceSubDomain` line item is added (`"-stg."`) for the staging environment.

File:`${JX3HOME}/jx3-gke-gsm/jx-requirements.yml` 
```yaml
  environments:
  - key: dev
  - key: staging
    ingress:
       namespaceSubDomain: -stg.
  - key: production
  ingress:
    domain: ""
    externalDNS: false
    namespaceSubDomain: .
```
### Push initial changes to cluster repo
All the customizations for the cluster repo are now propagated.
```bash
cd ${JX3HOME}/jx3-gke-gsm
git add .
git commit -a -m “chore: Jenkins example init”
git push	

```
### Build the infrastucture with Terraform
The following TF_VAR environment variables are set prior to running Terraform commands:
```
TF_VAR_gcp_project=<google project>
TF_VAR_apex_domain_gcp_project=<google project>
TF_VAR_jx_bot_username=<git username>
TF_VAR_jx_bot_token=<git token>
TF_VAR_tls_email=mymail@jx3rocks.com

TF_VAR_apex_domain=jx3rocks.com
TF_VAR_subdomain=web

TF_VAR_gsm=true
TF_VAR_cluster_name=jx3web
TF_VAR_cluster_location=us-east1-b
TF_VAR_jx_git_url=https://github.com/${JX3ORG}/jx3-gke-gsm.src.git
TF_VAR_lets_encrypt_production=false
TF_VAR_force_destroy=true
```
Additional detail on Terraform settings can be found under [Google Terraform Quickstart Template](https://github.com/jx3-gitops-repositories/jx3-terraform-gke/blob/master/README.md)

Commands to build intrastructure: 
```bash
cd ${JX3HOME}/jx3-gke-gsm
bin/create.sh                # Performs terraform init, plan and apply
```
### Enable prod certificate
This example employs TLS and accesing Jenkins from a browser requires a valid production certificate. It should be noted that TLS is not supported with automated domains `(i.e. nip.io)`. The process will begin by installing a Let's Encrypt test certicate. After the initial build completes and is successful, it’s best to ensure that the test certificate is ready (READY=True) before enabing the production certificate. You can find more information regarding this subject under [TLS and DNS](/v3/admin/guides/tls_dns/).
```bash
## Set credentials
gcloud container clusters get-credentials jx3web --zone us-east1-b 
## Set jx namespace
jx ns jx
## Check certificate
kubectl get cert -n jx
NAME                     READY   SECRET                   AGE
tls-web-jx3rocks-com-s   True    tls-web-jx3rocks-com-s   39m
```
You can also use [Octant](http://127.0.0.1:7777/#/overview/namespace/jx/custom-resources) to check certificate status.

Enabling the production certificate will require updates to both infra `(jx-terraform-gke)` and cluster `(jx3-gke-gsm)` repos. The commands to create the prod certificate are:
```bash
cd ${JX3HOME}/jx3-gke-gsm
git pull         ## Make sure local cluster repo is up to date
cd ${JX3HOME}/jx3-terraform-gke
export TF_VAR_lets_encrypt_production=true
terraform apply -auto-approve 
cd ${JX3HOME}/jx3-gke-gsm
git commit --allow-empty -m "Dummy commit"
git push
jx admin log     ## Make sure it completes before proceeding
git pull         ## Once successful refresh local cluster repo
```
The `${JX3HOME}/jx3-gke-gsm/jx-requirements.yml` file's TLS production setting should now be `true`.
```yaml
  ingress:
    domain: web.jx3rocks.com
    externalDNS: true
    kind: ingress
    namespaceSubDomain: .
    tls:
      email: mymail@jx3rocks.com
      enabled: true
      production: true
```
Once again, the example checks the certificates status till the production certifacte is ready before proceeding.
```bash
kubectl get cert -n jx
NAME                     READY   SECRET                   AGE
tls-web-jx3rocks-com-p   True    tls-web-jx3rocks-com-p   39m
tls-web-jx3rocks-com-s   True    tls-web-jx3rocks-com-s   86m
```
You can also use [Octant](http://127.0.0.1:7777/#/overview/namespace/jx/custom-resources) to check the production certificate.
![Octant Display](/images/v3/octant_display.png)
### Deploy project to Stage and Production
After production certificates become ready, the following commands will deploy a simple JSnode app to staging and production
```bash
# Using quickstart deploy app to staging
jx project quickstart --git-token ${TF_VAR_jx_bot_token} --git-username ${TF_VAR_jx_bot_user} --filter node-http --org ${JX3ORG} --batch-mode  --name node-http01

# For documentation simplicity, use the following command to promote to production
jx promote -v 0.0.1 -e production --app node-http01 --app-git-url https://github.com/${JX3ORG}/node-http01.git 

# Confirm deployments
jx get applications
APPLICATION STAGING PODS URL                                     PRODUCTION PODS URL
node-http01 0.0.1   1/1  http://node-http01-stg.two.${JX3ORG}.com 0.0.1     1/1  https://node-http01.two.${JX3ORG}.com
```
### Prepare for Outtage
To prepare for shutting down your cluster, a backup of the helm repo is essential. The helm repo is located in the chartmuseum pod's local storage and the following will copy the helm chart files to a separate backup location (i.e. $HOME/storage).
```bash
mkdir -p $HOME/storage
cd ${HOME}/storage
kubectl cp jx/`kubectl get pods -n jx --selector=app=chartmuseum -o jsonpath="{.items[0].metadata.name}"`:/storage .
```
### Helm Repo Backup
You should now see a copy of the chart and index file in the backup location. You can ignore the 'lost+found' directory.
```bash
cd ${HOME}/storage
ls
index-cache.yaml  lost+found             node-http01-0.0.1.tgz  
```
### Destroy Infrastructure
Commands to shutdown infrastructure. Make sure the same Terraform variables are set found under [Building the infrastructure with Terraform](/v3/admin/guides/cluster-rebuild/#build-the-infrastucture-with-terraform) 
```bash
cd ${JX3HOME}/jx3-terraform-gke
terraform destroy -auto-approve
```
### Cluster Down
Upon completion of the commands above, the Kubernetes resources will be completely freed up. You want to ensure your infra (jx3-terraform-gke), cluster (jx3-gke-gsm), and project repos, as well as your Terraform variables and helm repo backup, remain unchanged and available for when ready to rebuild..
### Prepare Cluster Repo for Rebuild
Prior to bringing the infrastructure (jx3-terraform-gke) back online, prepare the cluster repo (jx3-gke-gsm) by removing the reference of the `jx-staging` and `jx-production` environments and the long term storage.
```bash
cd ${JX3HOME}/jx3-gke-gsm
git pull     ## Make sure you get any updates from repo
# Remove long term storage refrences
sed -i '/storage:/,/vault:/{/storage:/!{/vault:/!d}}' jx-requirements.yml 
sed -i '/storage:/d' jx-requirements.yml
# Remove staging and prod links
sed -i '/jx-staging/d' helmfile.yaml
sed -i '/jx-production/d' helmfile.yaml
jx gitops helmfile resolve
git commit -a -m "chore: Remove staging and prod links"
git push
```
### Rebuild Infrastructure
Commands to rebuild  infrastructure. Once again, make sure you have the same Terraform variables set found under [Building the infrastructure with Terraform](/v3/admin/guides/cluster-rebuild/#build-the-infrastucture-with-terraform) 
```bash
cd ${JX3HOME}/jx3-terraform-gke
terraform apply -auto-approve
```
### Rebuild Helm Repo
After Terraform creates the infrastruce, the cluster repo resources will be used to launch a new Kubernetes cluster. Once the boot process completes and is sucessful you can safely perform the following recovery commands:
```bash
# Restore backup files to new helm repo
# Make sure chartmuseum pod is running
kubectl get pods -n jx --selector=app=chartmuseum 
# When chartmuseum pod is running it is then safe to proceed to the next steps.
cd $HOME/storage
for i in *; do kubectl cp $i jx/`kubectl get pods -n jx --selector=app=chartmuseum -o jsonpath="{.items[0].metadata.name}"`:/storage/$i; done
```
NOTE: You must wait until the chartmuseum is up and fully functioning. The chartmuseum pod can be running, but the best approach to determine if you can proceed is to access (successfully) the chartmuseum URL (i.e. https://chartmuseum.web.jx3rocks.com).
### Rebuild Cluster Repo
Restore the jx-staging and jx-production links
```bash
cd ${JX3HOME}/jx3-gke-gsm
git pull	## Make sure to get latest updates to repo
sed -i '/helmfiles:/ a - path: helmfiles/jx-production/helmfile.yaml' helmfile.yaml
sed -i '/helmfiles:/ a - path: helmfiles/jx-staging/helmfile.yaml' helmfile.yaml
git commit -a -m "chore: Restore staging and prod links"
git push
```
### Post Recovery Troubleshooting
Sometimes you will need to do some post recovery steps to bring your environment online. Below is a real life example of steps taken after cluster returned back online and needed some adjustments.

Reviewing the applications notice that 'node-http04' in staging does not show pods and is not accessible.
```bash
jx get applications
APPLICATION STAGING PODS URL                                     PRODUCTION PODS URL
node-http02 0.1.0   1/1  http://node-http02-stg.tri.jx3rocks.com 0.1.0      1/1  https://node-http02.tri.jx3rocks.com
node-http03 0.0.1   1/1  http://node-http03-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http03.tri.jx3rocks.com
node-http04 0.0.1        http://node-http04-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http04.tri.jx3rocks.com
node-http05 0.0.1   1/1  http://node-http05-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http05.tri.jx3rocks.com
```
Check to see if the host entry resolves
```bash
ping http://node-http04-stg.tri.jx3rocks.com
ping: http://node-http04-stg.tri.jx3rocks.com: Name or service not known
```
Check to see if DNS record set exists
```bash
gcloud dns record-sets list --zone=${ZONEIDSUB} --project ${PROJECTID} --filter="TYPE=A OR TYPE=TXT" --format 'table[no-heading](NAME,TYPE,TTL,DATA)' | awk '{print " --name=" $1 " --type=" $2 " --ttl=" $3 " " $4 }' | grep -- node-http04-stg
 --name=node-http04-stg.tri.jx3rocks.com. --type=A --ttl=300 35.231.47.50
 --name=node-http04-stg.tri.jx3rocks.com. --type=TXT --ttl=300 "heritage=external-dns,external-dns/owner=default,external-dns/resource=ingress/jx-staging/node-http04"
```
Check pod status
```bash
kubectl get pods -n jx-staging
NAME                                       READY   STATUS             RESTARTS   AGE
jx-verify-gc-jobs-8gb9h                    0/1     Completed          0          32m
node-http02-node-http02-749d864b58-m5mvk   1/1     Running            0          32m
node-http03-node-http03-59f5f89f4-mq86h    1/1     Running            0          32m
node-http04-node-http04-56f5f757c4-75rhb   0/1     ImagePullBackOff   0          32m
node-http04-node-http04-b74787f78-jcd2c    0/1     ImagePullBackOff   0          32m
node-http05-node-http05-5d6ccf954-g9lrj    1/1     Running            0          32m
node-http05-node-http05-7bc47d4f74-6rs9f   0/1     ImagePullBackOff   0          32m

kubectl logs -f node-http04-node-http04-56f5f757c4-75rhb -n jx-staging
Error from server (BadRequest): container "node-http04" in pod "node-http04-node-http04-56f5f757c4-75rhb" is waiting to start: trying and failing to pull image
```
Try restarting the 3 pods with the ImagePullBackOff (not running) status.
```bash
delete pods --field-selector=status.phase!=Running -n jx-staging
```
Final check running applications 
```bash
jx get applications
APPLICATION STAGING PODS URL                                     PRODUCTION PODS URL
node-http02 0.1.0   1/1  http://node-http02-stg.tri.jx3rocks.com 0.1.0      1/1  https://node-http02.tri.jx3rocks.com
node-http03 0.0.1   1/1  http://node-http03-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http03.tri.jx3rocks.com
node-http04 0.0.1   1/1  http://node-http04-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http04.tri.jx3rocks.com
node-http05 0.0.1   1/1  http://node-http05-stg.tri.jx3rocks.com 0.0.1      1/1  https://node-http05.tri.jx3rocks.com
```
### Cluster Rebuilt
Following the completion of the previous commands the cluster has now been returned to it's previous state and should be fully functioning.  If you wish to repeat the rebuild process start from the [Prepare for outtage](/v3/admin/guides/cluster-rebuild/#prepare-for-outtage) step.
