---
title: Configure Google Service Account
linktitle: GCP Service Account
type: docs
weight: 100
aliases:
---

This doc will demonstrate how to set up a Google service account that can be used by Terraform to execute [Jenkins X GKE Module](https://github.com/jenkins-x/terraform-google-jx#jenkins-x-gke-module)

> 💡 This doc has been designed to assist in performing the demonstration through copying and pasting each block of code into a shell terminal.<br>
>
> To execute the commands listed in your local bash shell will require the [Google gcloud tool and Cloud SDK](https://cloud.google.com/sdk/gcloud/#the_and) and the [JQ command-line JSON processor](https://stedolan.github.io/jq/).<br>
>
> To execute the commands listed in [Google Cloud Shell](https://cloud.google.com/shell/) does not require any additiobnal software installed.

### Service account privileges
In order to build your GKE environment with Terraform using a service account, the following are the service accounts minimal role requirements:
* roles/container.admin
* roles/editor
* roles/iam.serviceAccountAdmin
* roles/iam.serviceAccountKeyAdmin
* roles/resourcemanager.projectIamAdmin
* roles/storage.admin

If the service account needs to access a separate project to manage an apex domain then an additional role setting is required for the separate project.
* roles/dns.admin

### Create service account and assign roles
The first step is to create a new service account (APP_NAME) and to assign tbe roles.
> 💡  If you are using a local terminal, prior to executing the following commands, in the local terminal log into GCP (`gcloud auth login`) with an ID that has the necessary privileges (i.e. Owner) and set the appropriate project (`gcloud config set project PROJECT_ID`). .
> Always perform all commands in the same local terminal session to preserve dependent variables that are created.
>
> If you are using Google cloud shell, you should be logged into the GCP console with the necessary project selected (`MYPROJECT`) and the terminal window opened. Inside the terminal, run the `gcloud config list` to check the envrionment availability. 

First set an IAM name (required, minimum 6 characters  and MUST be all lowercase):
```bash
read -p "IAM name (i.e. tftest ) : " IAMNAME
```
With an IAM Name defined, create the service account and assign the roles:
``` bash
MYPROJECT=`gcloud config get-value project`
MY_GCP_SA=${IAMNAME}@${MYPROJECT}.iam.gserviceaccount.com
gcloud iam service-accounts create ${IAMNAME} --description "My SA" --display-name "${IAMNAME}" --project ${MYPROJECT} 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/container.admin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/storage.admin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/editor 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/resourcemanager.projectIamAdmin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountAdmin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountKeyAdmin 
```
If the environment uses external DNS and has the Apex domain records under a different project, assign to the service account `($MY_GCP_SA)` the necessary role to manage DNS under the Apex project `($APEXPROJECT)`. 
> 💡  If you are not using a separate Apex project, proceed to [CLI display commands](http://localhost:1313/v3/admin/platforms/google/svc_acct/#cli-display-commands).
```bash
read -p "Apex Project (if none leave blank) : " APEXPROJECT
```
``` bash
[[ ! -z "$APEXPROJECT" ]] && gcloud projects add-iam-policy-binding ${APEXPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/dns.admin || echo "No project"
```
### CLI display commands
To display the roles assigned to the service account use the following commands;
``` bash
gcloud projects get-iam-policy ${MYPROJECT} --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:${MY_GCP_SA}"
[[ ! -z "$APEXPROJECT" ]] && gcloud projects get-iam-policy ${APEXPROJECT} --flatten="bindings[].members"  --format='table(bindings.role)' --filter="bindings.members:${MY_GCP_SA}"
```
 
### Create and assign service account key
Create the service account key into a json file and assign Google application credentials variable (GOOGLE_APPLICATION_CREDENTIALS) so that it can be used by Terraform.
```bash
gcloud iam service-accounts keys create ~/${IAMNAME}_key.${MYPROJECT}.json --iam-account ${MY_GCP_SA} --project ${MYPROJECT}
eval export GOOGLE_APPLICATION_CREDENTIALS=~/${IAMNAME}_key.${MYPROJECT}.json
env | grep GOOGLE_APPLICATION_CREDENTIALS
```
> 💡 If you want the CLI to use the service account credentials, which may be suitable for debugging, use the following `gloud auth` command, otherwise proceed to [Clean Up](http://localhost:1313/v3/admin/platforms/google/svc_acct/#clean-up) step.
``` bash
gcloud auth activate-service-account ${MY_GCP_SA} --key-file ~/${IAMNAME}_key.${MYPROJECT}.json --project ${MYPROJECT}
```
### Clean up
The following Google CLI commands will remove the roles and service account.
``` bash
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/container.admin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/storage.admin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/editor 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/resourcemanager.projectIamAdmin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountAdmin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountKeyAdmin 
[[ ! -z "$APEXPROJECT" ]] && gcloud projects remove-iam-policy-binding ${APEXPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/dns.admin 
gcloud iam service-accounts delete ${MY_GCP_SA} --project ${MYPROJECT}
```
