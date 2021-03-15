---
title: Inner loop
linktitle: Inner loop
type: docs
description: Incrementally rebuilding applications as you change source
weight: 510
---

In v2 of Jenkins X we had a feature called `Dev Pods`  where we spun up a pod using the container image from the Jenkins X pipeline so that you could perform interative development inside the cluster.

We don't yet have an exact equivalent in Jenkins X v3 as we've moved from large monolithic container images with all the tools inside to small focussed images for each tekton pipeline step. e.g. using the upstream images for maven, golang, npm to perform those builds directly.


You may also find [this article on kubernetes inner loop](https://thenewstack.io/kubernetes-infrastructure-know-the-inner-dev-loop/) useful

If you want something like `Dev Pods`  in v3 there are a few open source tools that offer something similar:
