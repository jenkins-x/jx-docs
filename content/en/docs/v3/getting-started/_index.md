---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins X, helm 3 and kustomize
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 5
---

Jenkins X 3.x alpha includes a new install approach which uses tools like helm 3, kpt, kustomize and includes a number of [improvements](/docs/v3/about/benefits/) over Jenkins X 2.x use of helm 2.

## Pick your initial git repository

We have a [number of quickstart git repositories](https://github.com/jx3-gitops-repositories) to start from when installing Jenkins X 3.x. 

Please pick one of the following git repository templates. We recommend using terraform for clusters but if you want to just kick the tyres you could use one of the other templates:


### Google Cloud + Terraform + Vault

This is our current recommended quickstart for Google Cloud:

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* `git clone` the new repository and `cd`  into the git clone

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/blob/master/bin/README.md" 
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a> 

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-terraform-vault/README.md" class="btn bg-primary text-light">Create or import projects</a> 


## Google Cloud + gcloud + Vault 

This quickstart is similar to the above but does not use terraform so its ideal if you just want to create a quick cluster to kick the tyres without needing to learn terraform.

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gcloud-vault/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* `git clone` the new repository and `cd`  into the git clone

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gcloud-vault/blob/master/bin/README.md" 
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a> 

*  <a href="https://github.com/jx3-gitops-repositories/jx3-gke-gcloud-vault/README.md" class="btn bg-primary text-light">Create or import projects</a> 
