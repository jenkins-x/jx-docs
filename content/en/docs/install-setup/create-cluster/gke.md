---
title: Create GKE cluster
linktitle: GKE
description: How to create a GKE cluster?
weight: 5
categories: [getting started]
keywords: [cluster]
aliases:
  - /docs/getting-started/setup/create-cluster/gke/
  - /docs/getting-started/setup/create-cluster/gke
  - /docs/install-setup/create-cluster/gke/
---

{{% alert %}}
The GKE Terraform module for Jenkins X is published in the [Terraform Registry](https://registry.terraform.io/modules/jenkins-x/jx/google).
The source is in the [terraform-google-jx](https://github.com/jenkins-x/terraform-google-jx) repository on GitHub.
{{% /alert %}}

## Prerequisites

To use the GKE Terraform module for Jenkins X, you need a Google Cloud project.
Instructions on how to setup such a project can be found in the  [Google Cloud Installation and Setup](https://cloud.google.com/deployment-manager/docs/step-by-step-guide/installation-and-setup) guide.
You need your Google Cloud project id as an input variable for using this module.

You also need to install the Cloud SDK, in particular `gcloud`.
You find instructions on how to install and authenticate in the [Google Cloud Installation and Setup](https://cloud.google.com/deployment-manager/docs/step-by-step-guide/installation-and-setup) guide as well.

Once you have `gcloud` installed, you need to create [Application Default Credentials](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login) by running:

```bash
gcloud auth application-default login
```

Alternatively, you can export the environment variable _GOOGLE_APPLICATION_CREDENTIALS_ referencing the path to a Google Cloud [service account key file](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

Last but not least, ensure you have the following binaries installed:

- `gcloud`
- `kubectl` ~> 1.14.0
    - `kubectl` comes bundled with the Cloud SDK
- `terraform` ~> 0.12.0
    - Terraform installation instruction can be found [here](https://learn.hashicorp.com/terraform/getting-started/install)

## Cluster provisioning

A default Jenkins X ready cluster can be provisioned by creating a file _main.tf_ in an empty directory with the following content:

```
module "jx" {
  source  = "jenkins-x/jx/google"

  gcp_project = "<my-gcp-project-id>"
}
```

You can then apply this Terraform configuration via:

```bash
terraform init
terraform apply
```

This creates a cluster within the specified Google Cloud project with all possible configuration options defaulted.

{{% alert title="Warning" color="warning" %}}
This example is for getting up and running quickly.
It is not intended for a production cluster.
Refer to [Production cluster considerations](/docs/install-setup/create-cluster/gke/#production-cluster-considerations) for things to consider when creating a production cluster.
{{% /alert %}}

On completion of `terraform apply` there will be a _jx\_requirements_ output available which can be used as input to `jx boot` using the `--requirements` option.
Refer to [Running `jx boot`](#running-jx-boot) for more information.

In the default configuration, no custom domain is used.
DNS resolution occurs via [nip.io](https://nip.io/).
For more information on how to configure and use a custom domain, refer to [Using a custom domain](/docs/install-setup/create-cluster/gke/#using-a-custom-domain).

If you just want to experiment with Jenkins X, you can set `force_destroy` to `true`.
This allows you to remove all generated resources when running `terraform destroy`, including any generated buckets including their content.

The following two paragraphs provide the full list of configuration and output variables of this Terraform module.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| bucket\_location | Bucket location for storage | `string` | `"US"` | no |
| cluster\_location | The location (region or zone) in which the cluster master will be created. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region | `string` | `"us-central1-a"` | no |
| cluster\_name | Name of the Kubernetes cluster to create | `string` | `""` | no |
| dev\_env\_approvers | List of git users allowed to approve pull request for dev enviornment repository | `list(string)` | `[]` | no |
| enable\_backup | Whether or not Velero backups should be enabled | `bool` | `false` | no |
| force\_destroy | Flag to determine whether storage buckets get forcefully destroyed | `bool` | `false` | no |
| gcp\_project | The name of the GCP project to use | `string` | n/a | yes |
| git\_owner\_requirement\_repos | The git id of the owner for the requirement repositories | `string` | `""` | no |
| jenkins\_x\_namespace | Kubernetes namespace to install Jenkins X in | `string` | `"jx"` | no |
| lets\_encrypt\_production | Flag to determine wether or not to use the Let's Encrypt production server. | `bool` | `true` | no |
| max\_node\_count | Maximum number of cluster nodes | `number` | `5` | no |
| min\_node\_count | Minimum number of cluster nodes | `number` | `3` | no |
| node\_disk\_size | Node disk size in GB | `string` | `"100"` | no |
| node\_machine\_type | Node type for the Kubernetes cluster | `string` | `"n1-standard-2"` | no |
| parent\_domain | The parent domain to be allocated to the cluster | `string` | `""` | no |
| release\_channel | GKE [Release Channel](https://cloud.google.com/kubernetes-engine/docs/concepts/release-channels) to subscribe to. | `string` | `UNSPECIFIED` | no |
| resource\_labels | Set of labels to be applied to the cluster | `map` | `{}` | no |
| tls\_email | Email used by Let's Encrypt. Required for TLS when parent\_domain is specified | `string` | `""` | no |
| vault\_url | URL to an external Vault instance in case Jenkins X shall not create its own system Vault | `string` | `""` | no |
| velero\_namespace | Kubernetes namespace for Velero | `string` | `"velero"` | no |
| velero\_schedule | The Velero backup schedule in cron notation to be set in the Velero Schedule CRD (see [default-backup.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/systems/velero-backups/templates/default-backup.yaml)) | `string` | `"0 * * * *"` | no |
| velero\_ttl | The the lifetime of a velero backup to be set in the Velero Schedule CRD (see [default-backup.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/systems/velero-backups/templates/default-backup)) | `string` | `"720h0m0s"` | no |
| version\_stream\_ref | The git ref for version stream to use when booting Jenkins X. See https://jenkins-x.io/docs/concepts/version-stream/ | `string` | `"master"` | no |
| version\_stream\_url | The URL for the version stream to use when booting Jenkins X. See https://jenkins-x.io/docs/concepts/version-stream/ | `string` | `"https://github.com/jenkins-x/jenkins-x-versions.git"` | no |
| webhook | Jenkins X webhook handler for git provider | `string` | `"lighthouse"` | no |
| zone | Zone in which to create the cluster (deprecated, use cluster\_location instead) | `string` | `""` | no |

### Outputs

| Name | Description |
|------|-------------|
| backup\_bucket\_url | The URL to the bucket for backup storage |
| cluster\_location | The location of the created Kubernetes cluster |
| cluster\_name | The name of the created Kubernetes cluster |
| gcp\_project | The GCP project in which the resources got created |
| log\_storage\_url | The URL to the bucket for log storage |
| report\_storage\_url | The URL to the bucket for report storage |
| repository\_storage\_url | The URL to the bucket for artifact storage |
| vault\_bucket\_url | The URL to the bucket for secret storage |
| jx\_requirements | The yaml formatted output for use with `jx boot` |

## Using a custom domain

If you want to use a custom domain with your Jenkins X installation, you need to provide values for the [variables](/docs/install-setup/create-cluster/gke/#inputs) _parent\_domain_ and _tls\_email_.
_parent\_domain_ is the fully qualified domain name you want to use and _tls\_email_ is the email address you want to use for issuing Let's Encrypt TLS certificates.

Before you apply the Terraform configuration, you also need to create a [Cloud DNS managed zone](https://cloud.google.com/dns/zones), with the DNS name in the managed zone matching your custom domain name, for example in the case of _example.jenkins-x.rocks_ as domain:

![Creating a Managed Zone](/images/getting-started/create_managed_zone.png)

When creating the managed zone, a set of DNS servers get created which you need to specify in the DNS settings of your DNS registrar.

![DNS settings of a Managed Zone](/images/getting-started/managed_zone_details.png)

It is essential that before you run `jx boot`, your DNS servers settings are propagated, and your domain resolves.
You can use [DNS checker](https://dnschecker.org/) to check whether your domain settings have propagated.

When a custom domain is provided, Jenkins X uses [ExternalDNS](https://github.com/kubernetes-sigs/external-dns) together with [cert-manager](https://github.com/jetstack/cert-manager) to create A record entries in your managed zone for the various exposed applications.

If _parent_domain_ id not set, your cluster will use [nip.io](https://nip.io/) in order to create publicly resolvable URLs of the form ht<span>tp://\<app-name\>-\<environment-name\>.\<cluster-ip\>.nip.io.

## Production cluster considerations

The configuration as seen in [Cluster provisioning](/docs/install-setup/create-cluster/gke/#cluster-provisioning) is not suited for creating and maintaining a production Jenkins X cluster.
The following is a list of considerations for a production usecase.

- Specify the version attribute of the module, for example:

    ```
    module "jx" {
      source  = "jenkins-x/jx/google"
      version = "1.2.4"
      # insert your configuration
    }
    ```

  Specifying the version ensures that you are using a fixed version and that version upgrades cannot occur unintented.

- Keep the Terraform configuration under version control,  by creating a dedicated repository for your cluster configuration or by adding it to an already existing infrastructure repository.

- Setup a Terraform backend to securely store and share the state of your cluster. For more information refer to [Configuring a Terraform backend](#configuring-a-terraform-backend).

## Configuring a Terraform backend

A "[backend](https://www.terraform.io/docs/backends/index.html)" in Terraform determines how state is loaded and how an operation such as _apply_ is executed.
By default, Terraform uses the _local_ backend which keeps the state of the created resources on the local file system.
This is problematic since sensitive information will be stored on disk and it is not possible to share state across a team.
When working with Google Cloud a good choice for your Terraform backend is the [_gcs_ backend](https://www.terraform.io/docs/backends/types/gcs.html)  which stores the Terraform state in a Google Cloud Storage bucket.

To use the gcs backend you will need to create the bucket upfront.
You can use `gsutil` to create the bucket:

```sh
gsutil mb gs://<my-bucket-name>/
```

It is also recommended to enable versioning on the bucket as an additional safety net in case of state corruption.

```sh
gsutil versioning set on gs://<my-bucket-name>
```

You can verify whether a bucket has versioning enabled via:

```sh
gsutil versioning get gs://<my-bucket-name>
```

## Running `jx boot`

{{% alert title="Warning" color="warning" %}}
The generated output _jx\_requirements_ is only used for the first run of `jx boot`.
During this first run a git repository containing the source code for Jenkins X Boot is created.
This repository contains the _jx-requirements.yml_ used by successive runs of `jx boot`.
See the diagram below for more information on the typical lifecycle.
{{% /alert %}}

![Jenkins X Boot Lifecyckle](/images/getting-started/terraform_google_jx_boot.png)

An output (_jx\_requirements_) is available after applying the Terraform module, it can be retrieved and pipped to a file.

```sh
terraform output jx_requirements > jx-requirements.yml
```

This file can be used as input to [Jenkins X Boot](/docs/getting-started/setup/boot/) which is responsible for installing all the required Jenkins X components into the cluster.

Change into  an empty directory and execute:

```bash
jx boot --requirements <path-to-jx-requirements.yml>
```

You are prompted for any further required configuration.
The number of prompts depends on how much you have [pre-configured](/docs/install-setup/create-cluster/gke/#inputs) via your Terraform variables.

More information about the boot process can be found in the [Jenkins X Boot](/docs/getting-started/setup/boot) configuration section.
