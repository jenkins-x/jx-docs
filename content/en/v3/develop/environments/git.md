---
title: Git
linktitle: Git
type: docs
description: Environments and Git
weight: 100
---

Each kubernetes cluster has a git repository so that all the kubernetes resources in all namespaces can be managed by GitOps. Each cluster may also have a separate infrastructure git repository (e.g. for Terraform) to define the cloud resources (buckets, IAM roles, kubernetes cluster, node pools, VPNs, firewalls etc).

So if you use a [Multi Cluster Setup](/v3/admin/guides/multi-cluster/) you have git repository per cluster to define the kubernetes resources in all the namespaces in that cluster.

e.g. having `Dev`, `Staging` and `Production` with separate clusters you'll have 3 git repositories containing `helmfile.yaml` files. If you use a single cluster you'll have 1 git repository.
