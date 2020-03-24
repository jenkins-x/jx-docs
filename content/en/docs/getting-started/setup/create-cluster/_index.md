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

<div class="row">
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">Google Clusters</h5>
        <p class="card-text">How to create a kubernetes cluster on Google Cloud Platform (GCP)</p>
        <a href="/docs/getting-started/setup/create-cluster/google/" class="btn btn-primary">Google <i class="fab fa-google ml-2 "></i></a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">Amazon Clusters</h5>
        <p class="card-text">How to create a kubernetes cluster on Amazon Web Services (AWS)</p>
        <a href="/docs/getting-started/setup/create-cluster/amazon/" class="btn btn-secondary">AWS <i class="fab fa-aws ml-2 "></i></a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">Azure Clusters</h5>
        <p class="card-text">How to create a kubernetes cluster on Microsoft Azure platform.</p>
        <a href="/docs/getting-started/setup/create-cluster/azure/" class="btn btn-dark">Azure <i class="fab fa-microsoft ml-2 "></i></a>
      </div>
    </div>
  </div>
</div>



