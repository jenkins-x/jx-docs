---
title: Cluster Recovery
linktitle: Cluster Recovery
type: docs
description: Cluster Recovery
weight: 94
---
 
This section describes cluster recovery situations for when things go bad.  It can also be used to reguary recreate clusters, this is something the Jenkins X project does itself as we prefer to treat our clusters as cattle and not pets, giving confidence that we can restore services at any time.
 
Disclaimer: there may well be better approaches so if you know of better ways please contribute and help improve the experience.  There are some manual steps below that we know to work but expect we can improve.
 
# Cluster applications and services
 
Jenkins X embraces GitOps, details of any application or configuration are stored declaratively in Git.  Jenkins X recommends using external storage if you require persistence to be preserved.  Cloud Storage buckets are great at achieving this.  With that said Jenkins X has one service that writes data to a persistent volume and is not backed up in cloud storage.  The current use of Chartmuseuam to store helm charts for applications means if we need to recreate a cluster we will need to retrigger release pipelines for any application running in the staging or production cluster.
 
The Jenkins X project itself does not use Chartmuseum, instead it uses Work Load Identity and [helm gcs plugin](https://github.com/hayorov/helm-gcs) to write directly to a GCP bucket.  You could consider using this approach but as well Jenkins X will look to resolve this by adding OOTB support for buckets or other external repositories for charts.
 
For now you will need to modify your cluster git repository and remove the helmfile repository that points to the internal chartmuseum service.
 
For example: https://github.com/cb-kubecd/jx3-demo-walk-cluster/blob/ce3fa07834e93e44b2d19882b82a7de51f627ba2/helmfiles/jx-staging/helmfile.yaml#L7-L15
```
filepath: ""
environments:
 default:
   values:
   - jx-values.yaml
namespace: jx-staging
repositories:
- name: dev
 url: http://jenkins-x-chartmuseum.jx.svc.cluster.local:8080
releases:
- chart: dev/jx3-golang1
 version: 0.0.4
 name: jx3-golang1
 values:
 - jx-values.yaml
templates: {}
renderedvalues: {}
```
 
Once you recover any infrastructure below you will then need to trigger release pipelines again using
```
jx start pipeline
```
 
# Infrastructure
 
Cloud Infrastructure is managed by Terraform.  We recommend storing the Terraform state file in a [secure backend](https://www.terraform.io/docs/backends/index.html) or use a service like [Terraform Cloud](https://app.terraform.io/) as this means you can recover your Cloud Infrastructure in situations where it is deleted.
 
## GCP specific
For Google Container Engine there is a manual task you need to perform because the Terraform module does not manage deleting Cloud DNS Manage Zones that contain record sets.  This is something we hope to address in the future but if you are using DNS you will need to manually delete your Managed Zone, the easiest way is via the GCP console. 
 
Select your managed zone https://console.cloud.google.com/net-services/dns/zones
![Select Zone](/images/v3/gcp_select_zone.png)
 
Select all record set checkbox and click the DELETE RECORD SETS button
![Delete Record Sets](/images/v3/gcp_delete_recordsets.png)
 
Now select the DELETE ZONE button at the top
 
![Delete Zone](/images/v3/gcp_delete_zone.png)
 
## Recover
The Jenkins X terraform modules write some details into a cluster once it is created, this can cause issues when applying the Terraform plan if that cluster is not available.
 
You will need to modify the state file so navigate to your local clone of your infrastructure git repository
 
Set your bot username and personal access token `TF_VAR_`s
```
export TF_VAR_jx_bot_username=
export TF_VAR_jx_bot_token=
```
 
If you are using Terraform Cloud you can get you state file by adding this to your `main.tf`
 
```
# Enable to work with local and remote states
# run terraform init after uncommenting below
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "foo"
    workspaces {
      name = "bar"
    }
  }
}
```
 
If you already have a local state file make a backup of it, e.g:
```sh
cp terraform.tfstate terraform.tfstate.backup
```
 
now modify the state file:
```sh
terraform state rm module.jx
terraform refresh
terraform state pull > terraform.tfstate
terraform plan
terraform apply
```
 
## What is not recovered
 
Any Custom Resources not stored in git will not be recovered, for example Jenkins X Pipeline Activities.  There are solutions like [Velero](https://velero.io/) that handles backups which could be used.