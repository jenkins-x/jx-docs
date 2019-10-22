---
title: Create cluster
linktitle: Create cluster
description: How to create a Kubernetes cluster?
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [cluster]
weight: 1
aliases:
  - /getting-started/create-cluster
---

Jenkins X requires a Kubernetes cluster to exist so that it can be installed via [jx boot](/docs/getting-started/setup/boot/).

There are a number of approaches for creating Kubernetes clusters. 

Our recommended a approach is to use [Terraform](https://www.terraform.io) to setup all of your Cloud Infrastructure (kubernetes cluster, service accounts, storage buckets, logging etc) and to use a cloud provider to create and manage your kubernetes clusters.

Or you can use a kubernetes provider specific approach:




