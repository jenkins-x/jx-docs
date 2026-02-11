---
title: Kubernetes upgrades
linktitle: Kubernetes upgrade
type: docs
description: How to upgrade the version of Kubernetes in your cluster.
weight: 92
---

Upgrading your Kubernetes cluster is one of the tasks you must take on as an operator of Jenkins X. Kubernetes comes out with [new releases](https://kubernetes.io/releases/) regularly, and will only maintain releases for the three latest versions. Meaning if something breaks, or there is a security issue on an older version, Kubernetes will not fix it, but ask you to upgrade. All the major cloud providers only support a given set of latest versions.

{{< k8s-versions >}}

## Upgrade procedure

- It is highly recommended to test upgrades on a separate cluster, where you have all the same setup as you use in production.
- Run [Pluto](https://github.com/FairwindsOps/pluto) to find any deprecated CRDs present in your cluster. You can run Pluto both on the cluster using `pluto detect-helm`, and on the files on your cluster repo using `pluto detect-files`
- Cross-check the list of deprecations you find, with the list from [Kubernetes](https://kubernetes.io/docs/reference/using-api/deprecation-guide/) and see what is required for the Kubernetes version you want to upgrade to.
- Fix what needs to be fixed, and deploy the changes.
- You may now start the upgrade of Kubernetes.
  - The process has two steps, first, you need to upgrade the control plane, and next upgrade the nodes.
    Follow the upgrade steps according to your cloud provider. - [Amazon](https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html) - [Azure](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster?tabs=azure-cli) - [Google](https://cloud.google.com/kubernetes-engine/docs/how-to/upgrading-a-cluster)
- Pour yourself a cup of your favorite drink while you sit back and wait for the magic to happen.
