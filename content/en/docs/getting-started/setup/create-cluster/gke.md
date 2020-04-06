---
title: Create GKE cluster
linktitle: GKE
description: How to create a GKE cluster?
weight: 5
categories: [getting started]
keywords: [cluster]
---

{{% alert title="Tip" %}}
The GKE Terraform Module for Jenkins X is published in the [Terraform Registry](https://registry.terraform.io/modules/jenkins-x/jx/google).
The source is in the [terraform-google-jx](https://github.com/jenkins-x/terraform-google-jx) repository on GitHub.
{{% /alert %}}

## Prerequisites

To create your GKE cluster, you need first a Google Cloud project.
Instructions on how to setup a project can be found in the Google Cloud [documentation](https://cloud.google.com/deployment-manager/docs/step-by-step-guide/installation-and-setup).
You need your Google Cloud project id as input for using the Terraform Module.

You also need to install the Cloud SDK, in particular `gcloud`.
You find instructions on how to install and authenticate in the documentation mentioned above.

Once you have `gcloud` installed, you need to create [Application Default Credentials](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login) by running:

```bash
gcloud auth application-default login
```

Finally, ensure you have the following binaries installed:

- `gcloud`
- `kubectl` ~> 1.14.0
    - `kubectl` comes bundled with the Cloud SDK
- `terraform` ~> 0.12.0
    - Terraform installation instruction can be found [here](https://learn.hashicorp.com/terraform/getting-started/install)

## Cluster creation

A default Jenkins X ready cluster can be provisioned by creating a file _main.tf_ with the following content in an empty directory:

```tf
module "jx" {
  source  = "jenkins-x/jx/google"

  gcp_project = "<my-gcp-project-id>"
}
```

You can then apply this Terraform configuration via the following terminal commands:

```bash
terraform init
terraform apply
```

This creates a cluster within the specified Google Cloud project with all possible configuration options defaulted.

No custom domain is used.
Instead DNS resolution occurs via [nip.io](https://nip.io/).
For more information on how to configure and use a custom domain, refer to [Using a custom domain](/docs/getting-started/setup/create-cluster/gke#using-a-custom-domain).

If you just want to evaluate Jenkins X, you can set `force_destroy` to `true`.
This allows you to remove all generated resources when running `terraform destroy`, including any generated buckets with their content.

On completion of `terraform apply` there will be a _jx-requirements.yml_ in the working directory.
This file can be used as input for running [`jx boot`](/docs/getting-started/setup/boot).

The following sections define the various configuration variables as well as the Module's output variables.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | Name of the Kubernetes cluster to create | `string` | `"jenkins-x"` | no |
| dev\_env\_approvers | List of git users allowed to approve pull request for dev enviornment repository | `list(string)` | `[]` | no |
| force\_destroy | Flag to determine whether storage buckets get forcefully destroyed | `bool` | `false` | no |
| gcp\_project | The name of the GCP project to use | `string` | n/a | yes |
| git\_owner\_requirement\_repos | The git id of the owner for the requirement repositories | `string` | `""` | no |
| max\_node\_count | Maximum number of cluster nodes | `number` | `5` | no |
| min\_node\_count | Minimum number of cluster nodes | `number` | `3` | no |
| node\_disk\_size | Node disk size in GB | `string` | `"100"` | no |
| node\_machine\_type | Node type for the Kubernetes cluster | `string` | `"n1-standard-2"` | no |
| parent\_domain | The parent domain to be allocated to the cluster | `string` | `""` | no |
| tls\_email | Email used by Let's Encrypt. Required for TLS when parent\_domain is specified. | `string` | `""` | no |
| velero\_schedule | The Velero backup schedule in cron notation to be set in the Velero Schedule CRD (see [default-backup.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/systems/velero-backups/templates/default-backup.yaml)) | `string` | `"0 * * * *"` | no |
| velero\_ttl | The the lifetime of a velero backup to be set in the Velero Schedule CRD (see [default-backup.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/systems/velero-backups/templates/default-backup)) | `string` | `"720h0m0s"` | no |
| version\_stream\_ref | The git ref for version stream to use when booting Jenkins X. Refer to [version stream](/docs/concepts/version-stream) for more information. | `string` | `"master"` | no |
| version\_stream\_url | The URL for the version stream to use when booting Jenkins X. Refer to [version stream](/docs/concepts/version-stream) for more information. | `string` | `"https://github.com/jenkins-x/jenkins-x-versions.git"` | no |
| webhook | Jenkins X webhook handler for git provider | `string` | `"prow"` | no |
| zone | Zone in which to create the cluster | `string` | `"us-central1-a"` | no |

### Outputs

| Name | Description |
|------|-------------|
| backup\_bucket\_url | The URL to the bucket for backup storage |
| cluster\_name | The name of the created Kubernetes cluster |
| gcp\_project | The GCP project in which the resources got created |
| log\_storage\_url | The URL to the bucket for log storage |
| report\_storage\_url | The URL to the bucket for report storage |
| repository\_storage\_url | The URL to the bucket for artifact storage |
| vault\_bucket\_url | The URL to the bucket for secret storage |
| zone | The zone of the created Kubernetes cluster |

## Using a custom domain

If you want to use a custom domain with your Jenkins X installation, you need to provide values for the variables _parent_domain_ and _tls_email_.
_parent_domain_ is the fully qualified domain name you want to use and _tls_email_ is the email you want to use for issuing Let's Encrypt TLS certificates.

Before you run the Terraform configuration, you also need to create a [Cloud DNS managed zone](https://cloud.google.com/dns/zones), with the DNS name in the managed zone matching your custom domain name, for example in the case of _example.jenkins-x.rocks_ as domain:

![Creating a Managed Zone](/images/getting-started/create_managed_zone.png)

When creating the managed zone, a set of DNS servers get created which you need to specify in the DNS settings of your DNS registrar.

![DNS settings of a Managed Zone](/images/getting-started/managed_zone_details.png)

It is essential that before you run `jx boot`, your DNS servers settings are propagated, and your domain resolves.
You can use [DNS checker](https://dnschecker.org/) to check whether your domain settings have propagated.

When a custom domain is provided, Jenkins X uses [ExternalDNS](https://github.com/kubernetes-sigs/external-dns) together with [cert-manager](https://github.com/jetstack/cert-manager) to create A record entries in your managed zone for the various exposed applications.

If _parent_domain_ is not set, your cluster will use [nip.io](https://nip.io/) in order to create publicly resolvable URLs of the form ht<span>tp://\<app-name\>-\<environment-name\>.\<cluster-ip\>.nip.io.

## Running `jx boot`

Applying this Terraform module will not only create the [required cloud resources](/docs/getting-started/setup/create-cluster/required-cloud-resources), but also create a _jx-requirements.yml_ file.
From within an empty directory run:

```bash
 jx boot -r <path-to-generated-jx-requirements.yml>
```

More information about the boot process can be found in the [Run Boot](/docs/getting-started/setup/boot) section.
