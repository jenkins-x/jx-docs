---
title: Multi-Cluster
linktitle: Multi-Cluster
description: How to use multiple clusters with helm 3 and helmfile
weight: 6
---


We recommend using separate clusters for your `Preprod` and `Production` environments. This lets you completely isolate your environments which improves security.


## Setting up multi cluster

Follow new [getting started approach](/docs/v3/getting-started/) to setup a new cluster.

Then when you have a git repository URL for your remote cluster, import the git repository like you wouu
ld any other git repository into your development cluster:


