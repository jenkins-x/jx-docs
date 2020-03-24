---
title: Jenkins X Documentation
linkTitle: Documentation
weight: 20
menu:
  main:
    weight: 20
aliases:
  - /documentation
---

Jenkins X is an open source project that provides Kubernetes-based CI/CD
applications featuring pipeline automation, built-in GitOps, and preview
environments to help teams collaborate and accelerate their at any scale. [Read
More...](/docs/overview/)

## Get started with Jenkins X in 3 easy steps!


### Step 1: Install the Jenkins X Binary

The first step in using Jenkins X is installing the Jenkins X binary (`jx`) for
your operating system.

<div style="text-align:center">
<a class="btn btn-lg btn-secondary mr-3 mb-4" href="/docs/getting-started/setup/install/#linux">
		Install Linux <i class="fab fa-linux ml-2 "></i>
    </a> 
<a class="btn btn-lg btn-dark mr-3 mb-4" href="/docs/getting-started/setup/install/#macos">
		Install macOS <i class="fab fa-apple ml-2 "></i>
	</a>
</div>

[More installation options... ](/docs/getting-started/setup/install/)

### Step 2: Configure your Kubernetes environment

Once you have installed the binary on your workstation, next you can configure your kubernetes environment and install Jenkins X.

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

### Step 3: Install Jenkins X on your cluster

Once you have configured your kubernetes environment, you can finally Install Jenkins X and start using it!

<div style="text-align:center">
<a class="btn btn-lg btn-info mr-3 mb-4" href="/docs/getting-started/setup/boot/">
		Install Jenkins X <i class="fas fa-arrow-alt-circle-right ml-2"></i>
	</a>
</div>