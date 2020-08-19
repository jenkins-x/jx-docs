---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins X, helm 3 and kustomize
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 10
---

Jenkins X 3.x alpha includes a new install approach which uses tools like helm 3, kpt, kustomize and includes a number of [improvements](/docs/v3/about/benefits/) over Jenkins X 2.

- Download the new `jx` CLI https://github.com/jenkins-x/jx-cli/releases/latest

The new `jx` CLI uses a plugin system to add sub commands when working with Jenkins X.

Once you have the new `jx` CLI download the base set of sub commands used for admistrating and working with Jenkins X.

```bash
jx upgrade plugins
```

## Pick your initial git repository

Jenkins X 3.x aims to create clear seperation of concerns (SoC) with three areas when it comes to installation.

-  __Cloud Infrastructure__ - Jenkins X requires a Kubernetes cluster, storage, networking, DNS, IAM bindings, all things that we refer to cloud resources.  Jenkins X 3.x alpha is recommending to use Terraform + optinally Terrafrom Cloud to create and manage your cloud resources, we have quickstarts and guides to help.

- __Secrets Management__ - Jenkins X requires a number of secrets, some generated some are provided at installation, these need to be managed and there are a number of solutions that help.  Jenkins X prefers to use managed cloud services where possible, [Google Secrets manager](https://cloud.google.com/secret-manager), [AWS Secrets manager](https://aws.amazon.com/secrets-manager/) are good examples where secrets are stored out of the cluster and syncronsied in cluster using [external secrets](https://github.com/godaddy/kubernetes-external-secrets).  Where managed cloud services are not available or desired Jenkins X can also use Vault.

- __Jenkins X__ - once cloud provider and a secrets store are decided we can go ahead and set these up and enable the Jenkins X installation.

__NOTE__ The diagram shows intent, as Jenkins X 3 is still in __alpha__ not all integtations have been implemented yet.

---

We have a [number of quickstart git repositories](https://github.com/jx3-gitops-repositories) that are GitHub Repository templates that make it easy to start from when installing Jenkins X 3.x. 

Please pick one of the following setups:

### Google Cloud + Terraform + Google Secrets Manager

This is our current recommended quickstart for Google Cloud:

Here is a walkthrough using [Terraform Cloud](https://www.terraform.io/) which is a great way to get started.

[Terraform Cloud - GCP - Google Secrets Manager walkthrough](/docs/v3/getting-started/install-walkthrough/google_terraform_gsm.md)

### AWS + Terraform + AWS Secrets Manager

- coming soon, please reach out at an office hours or slack if you would like to be involved.

### Azure + Terraform + AWS Secrets Manager

- coming soon, please reach out at an office hours or slack if you would like to be involved.

### Google Cloud + Terraform + Vault

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* `git clone` the new repository and `cd`  into the git clone

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/blob/master/bin/README.md" 
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a> 

*  <a href="/docs/v3/create-project/" class="btn bg-primary text-light">Create or import projects</a> 


## Google Cloud + gcloud + Vault 

This quickstart is similar to the above but does not use terraform so its ideal if you just want to create a quick cluster to kick the tyres without needing to learn terraform.

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gcloud-vault/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* `git clone` the new repository and `cd`  into the git clone

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gcloud-vault/blob/master/bin/README.md" 
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a> 

*  <a href="/docs/v3/create-project/" class="btn bg-primary text-light">Create or import projects</a> 
