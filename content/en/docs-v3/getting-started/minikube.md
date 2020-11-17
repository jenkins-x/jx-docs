---
title: Minikube
linktitle: Minikube
type: docs
description: Setup Jenkins X on your laptop
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 100
aliases:
  - /docs/v3/getting-started/minikube
---

---
**NOTE**

Ensure you are logged into GitHub else you will get a 404 error when clicking the links below

---

This is our current recommended quickstart for Minikube:

*  <a href="https://github.com/jx3-gitops-repositories/jx3-minikube/generate" target="github" class="btn bg-primary text-light">Create the cluster Git Repository</a> based on the [jx3-gitops-repositories/jx3-minikube](https://github.com/jx3-gitops-repositories/jx3-minikube/generate) template 

* `git clone` the new repository you created above and `cd`  into the git clone

*  <a href="/docs/v3/guides/infra/minikube/" 
    target="github" class="btn bg-primary text-light" 
    title="use your new git repository to create your cloud infrastructure and install Jenkins X">
    Create your infrastructure
  </a> to setup minikube and configure webhooks
  
*  <a href="/docs/v3/develop/create-project/" class="btn bg-primary text-light">Create or import projects</a> 
