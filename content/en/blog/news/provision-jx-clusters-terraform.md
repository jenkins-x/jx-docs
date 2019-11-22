---
title: "Managing Jenkins X Kubernetes Clusters Using Infrastructure as Code With Terraform"
date: 2019-04-03T07:36:00+02:00
description: >
    Use Infrastructure as Code to provision Jenkins X clusters.
categories: [blog]
keywords: [terraform,IaC,provisioning,k8s]
slug: "terraform-jenkins-x"
aliases: []
author: Oscar Medina
---


<figure>
<img src="/images/jenkinsTerraform.png"/>
<figcaption>
<h5>Provision Jenkins X Kubernetes Clusters using Terraform</h5>
</figcaption>
</figure>

{{% alert %}}
CAUTION: Do not make updates to the cluster that require recreating the cluster resources, all data will be lost.  Only changes that update the cluster are supported at this time.
{{% /alert %}}

# Overview
Many organizations have adopted DevOps practices in the last few years.  This is valuable as it relates to Jenkins X as we provide a way to manage the Kubernetes clusters  Infrastructure as Code which is one of the core concepts of DevOps practices as it relates to automation.

Many environments may only allow for creating cloud resources using IaC, therefore we provide you with guidance on how to get started using Terraform to manage your Jekins X clusters.

Our objective is to bring awareness to our Jenkins X users on know that they can manage the cluster changes and version them by placing the Terraform code source control and adopting the typical developer workflow which includes PRs in source control to make infrastructure changes in a controlled manner.

## Terraform clusters for AWS, GCP and Azure
Jenkins X supports generating Terraform plans and code for all three leading clouds (AWS, Azure and GCP).

On this post we walk you through the steps for terraforming clusters in GKE.

## Benefits of Using IaC to Manage Your K8s Clusters
- This is great, because at many companies the Ops team typically is already using IaC to manage the resources deployed to the cloud
- Our Users gain the ability to version their infrastructure and follow the typical developer workflow as the code is in Github
- Changes to the cluster can be automated, added to a pipeline

# Prerequisites

To get started, you must have the following items installed on your machine.

 - The `jx` CLI installed.
 - Terraform - can be installed using `brew install terraform`
- GCP account with proper rights to create resources
- The Google Cloud CLI `gcloud`
`kubectl` must also be installed

# Step 1 - Create Terraform Plan

Our first task is to generate the Terraform code for each cluster, we create a Dev, Staging and Production cluster.

We execute the `jx create terraform -c dev=gke -c stage=gke -c prod=gke`.

The command generates three different clusters for each environment respectively in GCP.  Other providers supported are  aks, eks.

## Folder Structure Output
Running the previous command, outputs the following folder structure wherever we executed the command locally.

```txt
├── README.md
├── build.sh
├── ci-demo-206601-121d21dc79ac.json
└── clusters
├── dev
│   └── terraform
│       ├── README.md
│       ├── key.json
│       ├── main.tf
│       ├── output.tf
│       ├── terraform.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── prod
│   └── terraform
│       ├── README.md
│       ├── main.tf
│       ├── output.tf
│       ├── terraform.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── stage
└── terraform
├── README.md
├── main.tf
├── output.tf
├── terraform.tf
├── terraform.tfvars
└── variables.tf

7 directories, 22 files
```
We now have a great code-base to create our clusters on GKE for three different environments.

{{% alert %}}
NOTE: On this Post, we will only create the Dev Cluster, although the process is the same for creating the other Kubernetes clusters.
First we need to make sure we have credentials to execute our Terraform code.
{{% /alert %}}

# Step 2 - Get GKE Credentials

Jenkins X creates a Service Account (SA) for each cluster.

For our dev cluster, it has created the jx-questerring-dev@ci-demo-206601.iam.gserviceaccount.com account.

We need to download the `json` file in order to pass as credentials to our `terraform.tf` file which contains the definition to access the Terraform Backend.

## Downloading Credentials JSON File
To download the SA account credentials, go to the GCP Console > IAM &  Admin > Service Accounts.

We find the one for our cluster which is named in our case
as follows: `jx-questerring-dev@ci-demo-206601.iam.gserviceaccount.com`

We click on the file *name*  > *edit*, then click on *create key* in JSON format, download and save in our project folder structure.

We now add a reference within the `terraform.tf` as shown below.

```tf
terraform {
    required_version = ">= 0.11.0"
    backend "gcs" {
        bucket      = "ci-demo-206601-questerring-terraform-state"
        prefix      = "dev"
        credentials = "key.json"
    }
}
```

Notice that we added the `credentials` portion and point to the credentials `json` file we downloaded from the Google IAM & Admin web console.

# Step 3 - Initiate Terraform Backend
We are now ready to initiate Terraform backend.  Terraform backends are used to save the Terraform State remotely.  This is great for when a team needs to collaborate on making infrastructure changes, because the Terraform State is stored in the GCP Bucket that was also created when we executed our initial command to create the cluster.

```tf
$ terraform init
Initializing the backend...

Successfully configured the backend "gcs"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
Checking for available provider plugins on https://releases.hashicorp.com...
Downloading plugin for provider "google" (2.3.0)...

Terraform has been successfully initialized!
```

We have initiated Terraform and our Terraform State is now configured to use the GCP Buket specified in the terraform.tf file.

# Step 4 - Terraform Plan
We now can execute a `terraform plan` and see what will be created.  At this point, we can opt to augment the terraform code.

For example, you may have an existing network that you wish to deploy the cluster in.  You may also wish to enable the an add-on, or you can specify the cluster_ipv4_cidr_block and many other things (see https://www.terraform.io/docs/providers/google/r/container_cluster.html) for details.

```sh
$ terraform plan

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.
----

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
+ create

Terraform will perform the following actions:

+ google_container_cluster.jx-cluster
id:                                    <computed>
additional_zones.#:                    <computed>
addons_config.#:                       <computed>
cluster_autoscaling.#:                 <computed>
cluster_ipv4_cidr:                     <computed>
description:                           "jx k8s cluster provisioned and managed via Terraform."
enable_binary_authorization:           <computed>
enable_kubernetes_alpha:               "false"
enable_legacy_abac:                    "false"
enable_tpu:                            <computed>
endpoint:                              <computed>
initial_node_count:                    "3"
instance_group_urls.#:                 <computed>
ip_allocation_policy.#:                <computed>
location:                              <computed>
logging_service:                       "logging.googleapis.com"
master_auth.#:                         <computed>
master_ipv4_cidr_block:                <computed>
master_version:                        <computed>
monitoring_service:                    "monitoring.googleapis.com"
name:                                  "questerring-dev"
network:                               "default"
network_policy.#:                      <computed>
node_config.#:                         <computed>
node_locations.#:                      <computed>
node_pool.#:                           <computed>
node_version:                          <computed>
private_cluster:                       <computed>
project:                               <computed>
region:                                <computed>
remove_default_node_pool:              "true"
resource_labels.%:                     "3"
resource_labels.created-by:            "me"
resource_labels.created-timestamp:     "20190326093418"
resource_labels.created-with:          "terraform"
zone:                                  "us-west1-a"

+ google_container_node_pool.jx-node-pool
id:                                    <computed>
autoscaling.#:                         "1"
autoscaling.0.max_node_count:          "5"
autoscaling.0.min_node_count:          "3"
cluster:                               "questerring-dev"
initial_node_count:                    <computed>
instance_group_urls.#:                 <computed>
location:                              <computed>
management.#:                          "1"
management.0.auto_repair:              "true"
management.0.auto_upgrade:             "false"
max_pods_per_node:                     <computed>
name:                                  "default-pool"
name_prefix:                           <computed>
node_config.#:                         "1"
node_config.0.disk_size_gb:            "100"
node_config.0.disk_type:               <computed>
node_config.0.guest_accelerator.#:     <computed>
node_config.0.image_type:              <computed>
node_config.0.local_ssd_count:         <computed>
node_config.0.machine_type:            "n1-standard-2"
node_config.0.metadata.%:              <computed>
node_config.0.oauth_scopes.#:          "7"
node_config.0.oauth_scopes.1277378754: "https://www.googleapis.com/auth/monitoring"
node_config.0.oauth_scopes.1693978638: "https://www.googleapis.com/auth/devstorage.full_control"
node_config.0.oauth_scopes.172152165:  "https://www.googleapis.com/auth/logging.write"
node_config.0.oauth_scopes.1733087937: "https://www.googleapis.com/auth/cloud-platform"
node_config.0.oauth_scopes.2184564866: "https://www.googleapis.com/auth/service.management"
node_config.0.oauth_scopes.299962681:  "https://www.googleapis.com/auth/compute"
node_config.0.oauth_scopes.3663490875: "https://www.googleapis.com/auth/servicecontrol"
node_config.0.preemptible:             "true"
node_config.0.service_account:         <computed>
node_count:                            "3"
project:                               <computed>
region:                                <computed>
version:                               <computed>
zone:                                  "us-west1-a"
Plan: 2 to add, 0 to change, 0 to destroy.
----

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

# Step 5 - Create Cluster Using Terraform Apply
Now that we've seen what will be created and using the default terraform code generated, let us create said resources!

```sh
$ terraform apply
.....trimmed for brevity
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = 35.203.147.59
cluster_master_version = 1.11.7-gke.12
```
The outcome shows some key information, like the *cluster_endpoint* and the *cluster_master_version*

## Set Kubectl Context

Let us access the cluster using kubectl.  In order to do that, we need to get credentials.  We execute the following command (which you can get from the UI on GCP right from the cluster connect window)

```sh
$ gcloud container clusters get-credentials questerring-dev --zone us-west1-a --project ci-demo-206601

Fetching cluster endpoint and auth data.
kubeconfig entry generated for questerring-dev.
```
This has effectively modified our `kubeconfig` file and we now have a new context.

Executing the following command, we see our new cluster (in bold)

```sh
$ jx context
BigDaddyO
arn:aws:eks:us-west-2:653931956080:cluster/jxcluster
gke_ci-demo-206601_europe-west1-b_sirjenkinsgke
gke_ci-demo-206601_us-west1-a_chingold
gke_ci-demo-206601_us-west1-a_questerring-dev
gke_ci-demo-206601_us-west1-a_sirjenkinsgke
gke_ci-demo-206601_us-west1-a_sirjenkinsx
gke_ci-demo-206601_us-west1_sirjenkinsxgke
minikube
1553553075211690000@jxcluster.us-west-2.eksctl.io
```
We are now ready to install Jenkins X on our cluster!

# Step 6 - Installing Jenkins X on Cluster

To install Jenkins X, we simply run jx intall and follow the prompts.

{{ alert }}
NOTE that can pass additional flags as per your prefernces.  For example set the default admin password like so `--default-admin-password=MyPassw0rd` (see other options by typing `jx install --help`
{{ /alert }}

Now that we have Jenkins X installed, we can deploy an app etc.  We make sure it is up and running.

# Step 7 - Modify Clusters

There are certain properties that can be modified without forcing a recreation of the clusters.  You *do not want to recreate them as your data will be lost*.  Only changes that update the clusters are supported.

We are going to modify the cluster and add an add-on for the Dashboard which is typically disabled.

To do that we change the following within the cluster declaration in main.tf and add the following (in bold):

```tf
resource "google_container_cluster" "jx-cluster" {
    name                     = "${var.cluster_name}"
    description              = "jx k8s cluster provisioned and managed via Terraform."
    zone                     = "${var.gcp_zone}"
    enable_kubernetes_alpha  = "${var.enable_kubernetes_alpha}"
    enable_legacy_abac       = "${var.enable_legacy_abac}"
    initial_node_count       = "${var.min_node_count}"
    remove_default_node_pool = "true"
    logging_service          = "${var.logging_service}"
    monitoring_service       = "${var.monitoring_service}"

    resource_labels {
        created-by = "${var.created_by}"
        created-timestamp = "${var.created_timestamp}"
        created-with = "managed by terraform"
    }

    lifecycle {
        ignore_changes = ["node_pool"]
    }

    addons_config {
        kubernetes_dashboard {
            disabled = false
        }
    }

}
```

Then we run the terraform plan, output shows a change to the cluster as expected.

```sh
$ terraform plan

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

google_container_cluster.jx-cluster: Refreshing state... (ID: sposcar-dev)
google_container_node_pool.jx-node-pool: Refreshing state... (ID: us-west1-a/sposcar-dev/default-pool)
----

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
~ update in-place

Terraform will perform the following actions:

~ google_container_cluster.jx-cluster
addons_config.0.kubernetes_dashboard.0.disabled: "true" => "false"
resource_labels.created-with:                    "terraform" => "managed by terraform"

Plan: 0 to add, 1 to change, 0 to destroy.

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

## Accessing kubernetes dashboard

Now that our change has taken effect on our cluster, lets access the Dashboard.

{{ alert }}
NOTE: This dashboard is deprecated, and we are only showing you in the context of modifying your cluster to add an add-on.  Please use the GKE built-in UI
{{ /alert }}

### Get Access token
```sh
gcloud config config-helper --format=json | jq -r '.credential.access_token'
```

Copy the token from the output of that command.

Next, execute `kubectl proxy` which will enable you to access via the following URL

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

Paste the token and now you should be able to access the now deprecated dashboard via the browser.

# Conclusion
We walked through how to create your initial Terraform code and structure, created the Dev cluster and modified it by specifying an add-on to include in our cluster.

Please keep in mind, that once *GitOps* feature in Jenkins X is available, we recommend you manage the platform in that manner.  Documentation, tutorials and presentations on that topic will be coming soon!


Cheers,

[@SharePointOscar](http://twitter.com/SharePointOscar)

Developer Advocate | Jenkins X


