---
title: Amazon
linktitle: Amazon
description: How to create a kubernetes cluster on Amazon (AWS)?
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 40
---

There are a few ways to setup clusters on Amazon:


## Using EKS and eksctl


If you wish to use EKS on AWS then the preferred tool is [eksctl](https://eksctl.io).

First you will need to [install the eksctl CLI](https://eksctl.io/introduction/installation/).

Then follow the instructions to [create an EKS cluster with eksctl](https://eksctl.io/usage/creating-and-managing-clusters/).

## Using EC2 and kops

If you wish to use EC2 and kops then you will need to download a [kops release](https://github.com/kubernetes/kops/releases).
Then follow the instructions to [create a cluster on AWS with kops](https://kubernetes.io/docs/setup/production-environment/tools/kops/).


## Using the jx CLI

Ensure you [have installed the jx CLI](/docs/getting-started/setup/install/) then for kops use:


```sh
jx create cluster aws --skip-installation
```

or for EKS use:

```sh
jx create cluster eks --skip-installation
```
