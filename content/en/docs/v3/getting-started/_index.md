---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins X 3.x
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 10
---

Jenkins X 3.x alpha includes a new install approach which uses tools like helm 3, kpt, and kustomize to maintain Kubernetes YAML. This is one of many [improvements](/docs/v3/about/benefits/) over Jenkins X 2.

Jenkins X 3.x alpha has a simplified architecture and reduced complexity compared to Jenkins X 2. You can read an overview of Jenkins X 3.x alpha [here](/docs/v3/about/overview/).

## Lets go

- Download the new `jx` CLI and install it in your executable path by running the appropriate snippet for your OS found here: https://github.com/jenkins-x/jx-cli/releases/latest

The new `jx` CLI uses a plugin system to add subcommands when working with Jenkins X.

Once you have the new `jx` CLI, download the base set of subcommand plugins for administrating and working with Jenkins X:

```bash
jx upgrade plugins
```

## Pick your initial git repository

Before you chose which Git template you start with, note that part of removing complexity out of Jenkins X 3.x alpha has meant relying on other solutions where appropriate. Here's a quick explanation of our recommendations for setting up Cloud Infrastructure and for Secrets Management with Jenkins X 3:

-  __Cloud Infrastructure__ - Jenkins X requires a Kubernetes cluster, storage, networking, DNS, IAM bindings, all things that we refer to as cloud resources. We recommend you use Terraform, or optionally Terrafrom Cloud, to create and manage your cloud resources for Jenkins X 3.x alpha. To help you set up your Cloud Infrastructure, we have created quickstarts and guides.

- __Secrets Management__ - Jenkins X requires a number of secrets, some are generated and some are provided at installation by the user. These need to be managed and there are a number of solutions that help.  Jenkins X prefers to use managed cloud services where possible. [Google Secrets manager](https://cloud.google.com/secret-manager) is a good example where secrets are stored out of the cluster and syncronsied in cluster using [external secrets](https://github.com/godaddy/kubernetes-external-secrets). Where managed cloud services are not available or desired, Jenkins X can also use Vault.

We have a [number of quickstart git repositories](https://github.com/jx3-gitops-repositories) that are GitHub Repository templates that make it easy to start when installing Jenkins X 3.x.
