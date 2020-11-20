---
title: Google
linktitle: Google
type: docs
description: Setup Jenkins X on Google Cloud with GKE 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 40
aliases:
  - /v3/admin/platforms/gke
  - /docs/v3/getting-started/gke
---

---
**NOTE**

Ensure you are logged into GitHub else you will get a 404 error when clicking the links below

---

### GKE + Terraform
This is our current recommended quickstart for Google Cloud Platform:

*  <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-gke/generate" target="github" class="btn bg-primary text-light">Create Git Repository</a> 

* Ensure **Owner** is the Git Organisation that will hold the repositories used for Jenkins X.

* `git clone` the new repository and `cd`  into the git clone

*  <a href="https://github.com/jx3-gitops-repositories/jx3-terraform-gke/blob/master/README.md"
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a>

*  <a href="/docs/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a>

The following demo walks through how to get started with Jenkins X 3 on GKE + Terraform 
<iframe width="560" height="315" src="https://www.youtube.com/embed/RYgKvRpjkoY" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
