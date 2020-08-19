---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins X 3.x
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 10
---

Jenkins X 3.x alpha takes a fresh look at areas that it has not done enough in the past and where it needs to improve, for a quick overview look [here](/docs/v3/about/overview/).

Jenkins X 3.x alpha includes a new install approach which uses tools like helm 3, kpt, kustomize to maintain Kubernetes YAML and includes a number of [improvements](/docs/v3/about/benefits/) over Jenkins X 2.

## Lets go

- Download the new `jx` CLI and install it in your executable path by running the snippet appropriate for your OS given here: https://github.com/jenkins-x/jx-cli/releases/latest

The new `jx` CLI uses a plugin system to add sub commands when working with Jenkins X.

Once you have the new `jx` CLI, download the base set of sub command plugins used for admistrating and working with Jenkins X:

```bash
jx upgrade plugins
```

## Pick your initial git repository

Before you chose which Git template you start with here's a quick explanatiom of both:

-  __Cloud Infrastructure__ - Jenkins X requires a Kubernetes cluster, storage, networking, DNS, IAM bindings, all things that we refer to cloud resources.  Jenkins X 3.x alpha is recommending to use Terraform + optinally Terrafrom Cloud to create and manage your cloud resources, we have quickstarts and guides to help.

- __Secrets Management__ - Jenkins X requires a number of secrets, some generated some are provided at installation, these need to be managed and there are a number of solutions that help.  Jenkins X prefers to use managed cloud services where possible, [Google Secrets manager](https://cloud.google.com/secret-manager), [AWS Secrets manager](https://aws.amazon.com/secrets-manager/) are good examples where secrets are stored out of the cluster and syncronsied in cluster using [external secrets](https://github.com/godaddy/kubernetes-external-secrets).  Where managed cloud services are not available or desired Jenkins X can also use Vault.

We have a [number of quickstart git repositories](https://github.com/jx3-gitops-repositories) that are GitHub Repository templates that make it easy to start from when installing Jenkins X 3.x.