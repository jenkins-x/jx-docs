---
title: Create EKS cluster
linktitle: EKS
description: How to create an EKS cluster?
weight: 10
categories: [getting started]
keywords: [cluster]
draft: false
---

{{< alert >}}
<h3>TIP:</h3> The EKS Terraform Module for Jenkins X is published in the  <a class="alert-link" href="https://registry.terraform.io/modules/jenkins-x/eks-jx/aws">[Terraform Registry]</a>.  The source is in the  <a class="alert-link" href="https://github.com/jenkins-x/terraform-aws-eks-jx">[terraform-google-jx]</a> repository on GitHub.  We welcome contributions!
{{< /alert >}}


## Prerequisites

This Jenkins X EKS Terraform Module allows you to create an EKS cluster for installation of Jenkins X. You will need the following binaries locally installed and configured on your _PATH_:

- `terraform` (~> 0.12.0)
- `kubectl` (>=1.10)
- `aws-iam-authenticator`

## Usage

A default Jenkins X ready cluster can be provisioned by creating a _main.tf_ file in an empty directory with the following content:

{{<highlight javascript>}}
module "eks-jx" {
  source  = "jenkins-x/eks-jx/aws"

  vault_user="<your_vault_iam_username>"
}
{{</highlight>}}

You will need to provide a existing IAM user name for Vault.
The specified user's access keys are used to authenticate the Vault pod against AWS.
The IAM user does not need any permissions attached to it.
For more information refer to [Configuring Vault for EKS](/docs/getting-started/setup/boot/clouds/amazon#configuring-vault-for-eks).

The minimal configuration from above can be applied by running:

```sh
terraform init
terraform apply
```

The name of the cluster will be randomized, but you can provide your own name using the _cluster_name_ variable.
Refer to the [Inputs](/docs/getting-started/setup/create-cluster/eks#inputs) section for a full list of all configuration variables.
The following sections give an overview of the possible configuration options.

### VPC

The following variables allow you to configure the settings of the generated VPC: `vpc_name`, `vpc_subnets` and `vpc_cidr_blocl`.

### EKS Worker Nodes configuration

You can configure the EKS worker node pool with the following variables: `desired_number_of_nodes`, `min_number_of_nodes`, `max_number_of_nodes` and `worker_nodes_instance_types`.

### Long Term Storage

You can choose to create S3 buckets for long term storage of various artifacts.
`enable_logs_storage`, `enable_reports_storage` and `enable_repository_storage` are variables which control bucket creation.

During `terraform apply` the enabledS3 buckets are created, and the generated `jx-requirements.yml` will contain the following section:

```yaml
    storage:
      logs:
        enabled: ${enable_logs_storage}
        url: s3://${logs_storage_bucket}
      reports:
        enabled: ${enable_reports_storage}
        url: s3://${reports_storage_bucket}
      repository:
        enabled: ${enable_repository_storage}
        url: s3://${repository_storage_bucket}
```

### Vault

Vault is used by Jenkins X for managing secrets.
Part of Terraform's responsibilities is the creation of all resources required to run the [Vault Operator](https://github.com/banzaicloud/bank-vaults) used by Jenkins X.
These resources are an S3 Bucket, a DynamoDB table and a KMS key.

The `vault_user` variable is required when running this script. This is the user whose credentials will be used to authenticate the Vault pods against AWS.

### ExternalDNS

You can enable [ExternalDNS](https://github.com/kubernetes-sigs/external-dns) with the `enable_external_dns` variable. This will modify the generated _jx-requirements.yml_ file to enable External DNS when running `jx boot`.

If `enable_external_dns` is _true_, additional configuration will be required.

If you want to use a domain with an already existing Route 53 Hosted Zone, you can provide it through the `apex_domain` variable:

This domain will be configured in the resulting _jx-requirements.yml_ file in the following section:

```yaml
    ingress:
      domain: ${domain}
      ignoreLoadBalancer: true
      externalDNS: ${enable_external_dns}
```

If you want to use a subdomain and have this script create and configure a new Hosted Zone with DNS delegation, you can provide the following variables:

`subdomain`: This subdomain will be added to the apex domain. This will be configured in the resulting _jx-requirements.yml_ file.

`create_and_configure_subdomain`: This flag will instruct the script to create a new `Route53 Hosted Zone` for your subdomain and configure DNS delegation with the apex domain.

By providing these variables, the script creates a new `Route 53` HostedZone that looks like `<subdomain>.<apex_domain>`, then it delegates the resolving of DNS to the apex domain.
This is done by creating a `NS` RecordSet in the apex domain's Hosted Zone with the subdomain's HostedZone nameservers.

This will make sure that the newly created HostedZone for the subdomain is instantly resolvable instead of having to wait for DNS propagation.

### cert-manager

You can enable [cert-manager](https://github.com/jetstack/cert-manager) to use TLS for your cluster through LetsEncrypt with the `enable_tls` variable.

[LetsEncrypt](https://letsencrypt.org/) has two environments, `staging` and `production`.

If you use staging, you will receive self-signed certificates, but you are not rate-limited, if you use the `production` environment, you receive certificates signed by LetsEncrypt, but you can be rate limited.

You can choose to use the `production` environment with the `production_letsencrypt` variable.

You need to provide a valid email to register your domain in LetsEncrypt with `tls_email`.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| apex\_domain | The main domain to either use directly or to configure a subdomain from | `string` | `""` | no |
| cluster\_name | Variable to provide your desired name for the cluster. The script will create a random name if this is empty | `string` | `""` | no |
| create\_and\_configure\_subdomain | Flag to create an NS record ser for the subdomain in the apex domain's Hosted Zone | `bool` | `false` | no |
| desired\_number\_of\_nodes | The number of worker nodes to use for the cluster | `number` | `3` | no |
| enable\_external\_dns | Flag to enable or disable External DNS in the final `jx-requirements.yml` file | `bool` | `false` | no |
| enable\_logs\_storage | Flag to enable or disable long term storage for logs | `bool` | `true` | no |
| enable\_reports\_storage | Flag to enable or disable long term storage for reports | `bool` | `true` | no |
| enable\_repository\_storage | Flag to enable or disable the repository bucket storage | `bool` | `true` | no |
| enable\_tls | Flag to enable TLS int he final `jx-requirements.yml` file | `bool` | `false` | no |
| manage\_aws\_auth | Whether to apply the aws-auth configmap file | `bool` | `true` | no |
| max\_number\_of\_nodes | The maximum number of worker nodes to use for the cluster | `number` | `5` | no |
| min\_number\_of\_nodes | The minimum number of worker nodes to use for the cluster | `number` | `3` | no |
| production\_letsencrypt | Flag to use the production environment of letsencrypt in the `jx-requirements.yml` file | `bool` | `false` | no |
| region | The region to create the resources into | `string` | `"us-east-1"` | no |
| subdomain | The subdomain to be used added to the apex domain. If subdomain is set, it will be appended to the apex domain in  `jx-requirements-eks.yml` file | `string` | `""` | no |
| tls\_email | The email to register the LetsEncrypt certificate with. Added to the `jx-requirements.yml` file | `string` | `""` | no |
| vault\_user | The AWS IAM Username whose credentials will be used to authenticate the Vault pods against AWS | `string` | n/a | yes |
| vpc\_cidr\_block | The vpc CIDR block | `string` | `"10.0.0.0/16"` | no |
| vpc\_name | The name of the VPC to be created for the cluster | `string` | `"tf-vpc-eks"` | no |
| vpc\_subnets | The subnet CIDR block to use in the created VPC | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| wait\_for\_cluster\_cmd | Custom local-exec command to execute for determining if the eks cluster is healthy. Cluster endpoint will be available as an environment variable called ENDPOINT | `string` | `"until curl -k -s $ENDPOINT/healthz \u003e/dev/null; do sleep 4; done"` | no |
| worker\_nodes\_instance\_types | The instance type to use for the cluster's worker nodes | `string` | `"m5.large"` | no |

### Outputs

| Name | Description |
|------|-------------|
| cert\_manager\_iam\_role | The IAM Role that the Cert Manager pod will assume to authenticate |
| cluster\_name | The name of the created cluster |
| cm\_cainjector\_iam\_role | The IAM Role that the CM CA Injector pod will assume to authenticate |
| controllerbuild\_iam\_role | The IAM Role that the ControllerBuild pod will assume to authenticate |
| external\_dns\_iam\_role | The IAM Role that the External DNS pod will assume to authenticate |
| jxui\_iam\_role | The IAM Role that the Jenkins X UI pod will assume to authenticate |
| lts\_logs\_bucket | The bucket where logs from builds will be stored |
| lts\_reports\_bucket | The bucket where test reports will be stored |
| lts\_repository\_bucket | The bucket that will serve as artifacts repository |
| tekton\_bot\_iam\_role | The IAM Role that the build pods will assume to authenticate |
| vault\_dynamodb\_table | The bucket that Vault will use as backend |
| vault\_kms\_unseal | The KMS Key that Vault will use for encryption |
| vault\_unseal\_bucket | The bucket that Vault will use for storage |

## Running `jx boot`

Applying this Terraform module will not only create the [required cloud resources](/docs/getting-started/setup/create-cluster/required-cloud-resources), but also create a _jx-requirements.yml_ file.
From within an empty directory run:

```bash
 jx boot -r <path-to-generated-jx-requirements.yml>
```

More information about the boot process can be found in the [Run Boot](/docs/getting-started/setup/boot) section.
