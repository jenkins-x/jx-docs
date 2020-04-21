---
title: Required cloud resources
linktitle: Required cloud resources
description: What cloud resources are created?
weight: 20
categories: [getting started]
keywords: [cluster]
---

No matter which Terraform module you choose, each will create a similar set of resources.
Most importantly it will create the Kubernetes cluster of course, but there are a other aspects as well.

## Cloud APIs

Terraform enables all required cloud provider APIs.

## Storage

Logs, test reports and build artifacts, but also backups and secrets are stored in cloud storage (buckets).
One task of the Terraform module is to create these buckets.
Some buckets are optional and you can configure whether they get created or not.
Refer to the documentation for your cloud provider specific Terraform module for more information.

If all storage options are enabled, the following buckets are created:
{{% description-list %}}

* Log bucket; Bucket for storing build logs.
Refer to [Configuring Storage](/docs/guides/managing-jx/common-tasks/storage#configuring-storage) for more information.
* Report bucket; Bucket for storing test and coverage reports.
Refer to [Configuring Storage](/docs/guides/managing-jx/common-tasks/storage#configuring-storage) for more information.
* Repository bucket; Bucket used for storing artifacts when using [Bucketrepo](/docs/getting-started/setup/boot/#bucketrepo).
Bucketrepo  is a small footprint microservice that is an alternative to both Nexus and Chartmusem.
* Velero bucket; Bucket for [Velero](https://velero.io) backups.
Refer to [Backups](/docs/getting-started/setup/boot/#backups) for more information.
* Vault bucket; Bucket used by Vault for storing its data.
Jenkins X uses Vault to store secrets.
Refer to [Vault](/docs/getting-started/setup/boot/#vault) for more information.

{{% /description-list %}}

## Permission management

Several Jenkins X services need to interact with the underlying cloud infrastructure.
For example, the Build Controller needs to be able to store log files into the log storage bucket.
Another example is [ExternalDNS](https://github.com/kubernetes-sigs/external-dns) creating dynamically new DNS entries for services.
In this case ExternalDNS service needs access to the DNS APIs of the underyling cloud provider.

To ensure that each service gets only the permissions it needs to fulfill its resposibilty, cloud providers allow to bind Kuberenetes service accounts to cloud provider specific service announts or roles.
The mechanism to achieve this varies between cloud providers.
For Google Cloud it is called [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) and for AWS [IAM Roles for Service Accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).
It is the resposibilty of the corresponding Terraform module to configure these permissions.

At the moment Kubernetes service accounts for the following areas are created:

{{% description-list %}}

* Tekton; Service account used by Tekton for the actual pipline execution.
The Tekton service account needs permissions to read and write to cloud storage.
The name of the service account is _tekton-bot_.
* Build Controller; Service account used by the Build Controller service which is responsible to track the overall progress of pipeline executions.
The Build Controller service account needs permissions to read and write to cloud storage.
The name of the service account is _jenkins-x-controllerbuild_.
* DNS; There are three Kuberenetes services accounts created related to DNS.
One for ExternalDNS with the name _exdns-external-dns_ and two for [cert-manager](https://github.com/jetstack/cert-manager), namely _cm-cert-manager_ and _cm-cainjector_.
Each of these services need access to the DNS API of the cloud provider.
* Vault; Service account used by the Vault operator.
The Vault service account needs permissions to read and write to cloud storage and access to kryptographic key managment.
The name of the service account is _\<cluster-name\>-vt.
* Velero; Service account used by the Velero backup service.
The Velero service account needs permissions to read and write to cloud storage.
The name of the service account is _velero-server_
* Kaniko; Service account used by [Kaniko](https://github.com/GoogleContainerTools/kaniko) which is a safer option to build Docker images in Kuberenetes than the Docker daemon.
The Kaniko service account needs permissions to read and write to cloud storage.
The name of the service account is _kaniko-sa_.

{{% /description-list %}}

## Kryptograpphic key management

For using the Vault Operator, the Terraform module needs to create a krypographic keyring and key to seed Vault.
