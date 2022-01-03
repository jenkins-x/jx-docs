---
title: Configure Google Service Account
linktitle: Service Account
type: docs
weight: 100
aliases:
---

This guide will describe how to set up a Google service account that can be used by Terraform to maintain a GKE cluster environment using the Googlce Command Line Interface (CLI). 

### Build Variables and Roles Assigned
For clarity, the following are variables used to build the service account and a roles that will be assigned:
```
MYPROJECT=<your project>
IAMNAME=<IAM name>
MY_GCP_SA="${IAMNAME}@${MYPROJECT}.iam.gserviceaccount.com"

roles/container.admin
roles/editor
roles/iam.serviceAccountAdmin
roles/iam.serviceAccountKeyAdmin
roles/resourcemanager.projectIamAdmin
roles/storage.admin

APEXPROJECT=<your apex project>        ## Required for separate APEX project
roles/dns.admin                        ## Required for separate APEX project
```
### CLI Build Commands
The following Google CLI commands will create a service account `($MY_GCP_SA)` with a name `($IAMNAME)` with the necessary roles under the Google project `($MYPROJECT)`.
``` bash
gcloud iam service-accounts create ${IAMNAME} --description "My SA" --display-name "${IAMNAME}" --project ${MYPROJECT} 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/container.admin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/storage.admin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/editor 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/resourcemanager.projectIamAdmin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountAdmin 
gcloud projects add-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountKeyAdmin 
```
If the environment uses external DNS and has the Apex domain records under a different project, assign to the service account `($MY_GCP_SA)` the necessary role to mangage DNS under the Apex project `($APEXPROJECT)`. 
``` bash
gcloud projects add-iam-policy-binding ${APEXPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/dns.admin
```
### CLI Display Commands
To display the roles assigned to the service account use the following commands;
``` bash
gcloud projects get-iam-policy ${MYPROJECT} --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:${MY_GCP_SA}"
gcloud projects get-iam-policy ${APEXPROJECT} --flatten="bindings[].members"  --format='table(bindings.role)' --filter="bindings.members:${MY_GCP_SA}"
```
 
### Create and Assign Service Account Key
Create the service account key into a json file and assign Google application credentials variable so that it can be used by Terraform.
```bash
gcloud iam service-accounts keys create ~/${IAMNAME}_key.${MYPROJECT}.json --iam-account ${MY_GCP_SA} --project ${MYPROJECT}
export GOOGLE_APPLICATION_CREDENTIALS=~/${IAMNAME}_key.${MYPROJECT}.json
# Set CLI to use service account privileges for debugging purposes (optional)
gcloud auth activate-service-account ${MY_GCP_SA} --key-file ~/${IAMNAME}_key.${MYPROJECT}.json --project ${MYPROJECT}
```
### Clean Up
The following Google CLI commands will remove the roles and service account.
``` bash
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/container.admin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/storage.admin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/editor 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/resourcemanager.projectIamAdmin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountAdmin 
gcloud projects remove-iam-policy-binding ${MYPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/iam.serviceAccountKeyAdmin 
gcloud projects remove-iam-policy-binding ${APEXPROJECT} --member serviceAccount:${MY_GCP_SA} --role roles/dns.admin 
gcloud iam service-accounts delete ${MY_GCP_SA} --project ${MYPROJECT}
```
