---
title: Create cluster
linktitle: Create cluster
description: How to create a Kubernetes cluster?
weight: 10
categories: [getting started]
keywords: [cluster]
aliases:
  - /getting-started/create-cluster
  - /docs/getting-started/setup/create-cluster/
  - /docs/getting-started/setup/create-cluster
  - /docs/install-setup/create-cluster
  - docs/install-setup/create-cluster
---

Jenkins X runs on a Kubernetes cluster.
There are a number of approaches for creating this cluster.
Our recommended approach is to use a cloud provider to create and manage your Kubernetes clusters.
We also recommend using [Terraform](https://www.terraform.io) to setup and manage all required cloud infrastructure.

To make this as easy as possible, we are providing [Terraform Modules](https://www.terraform.io/docs/modules/index.html) for the most popular cloud providers.
The modules can be found in the [Terraform Registry](https://registry.terraform.io/search?q=jx), as well as on [GitHub](http://github.com/jenkins-x?q=terraform-).

If you want to run your cluster on Google Cloud refer to the [GKE](/docs/getting-started/setup/create-cluster/gke) instructions.
<!-- In case you prefer Amazon's refer to the [EKS](/docs/getting-started/setup/create-cluster/eks) instructions. -->

If you want more what cloud resources are required by Jenkins X and created by Terraform refer to [Required cloud resources](/docs/getting-started/setup/create-cluster/required-cloud-resources).
