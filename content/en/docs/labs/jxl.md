---
title: Getting jxl
linktitle: Getting jxl
type: docs
description: Getting the jxl binary so you can try the Labs features
weight: 1
---

Before you start using the Labs features you need to get the Labs Command Line tool called `jxl`.

You can download `jxl` from here: https://github.com/jenkins-x-labs/jxl/releases

Its basically a drop in alternative to the usual `jx` that has all of the new Labs features enabled.

e.g. `jxl` assumes:

* helm 3 is used
* we use lighthouse and tekton for CI/CD

notes:
* main development has been done using GitHub and Google Container Engine (GKE) but OSS contributions have been helping to validate and fix issues using other platforms.

## How jxl is built

We are trying to take a microservices approach to creating improvements to Jenkins X inside the Labs.

We are trying to keep Jenkins X stable; but provide a place where we can rapidly innovate with new experiments, improvements and enhancements.

So rather than forking the Jenkins X repositories or complicating the `jx` codebase too much our current strategy is:

* create new git repositories and new CLI binaries for new features. e.g. the new [boot improvements](/docs/labs/boot/) CLI is in a git repository [jenkins-x-labs/helmboot/](https://github.com/jenkins-x-labs/helmboot/) 
* the [jenkins-x-labs/jxl](https://github.com/jenkins-x-labs/jxl) repository then creates a `jx` like CLI called `jxl` by importing these microservices. Currently this is static compilation but over time we'd like this to use more binary extensions.
* we then reuse code from [jenkins-x/jx](https://github.com/jenkins-x/jx/) to fill in more details and commands

We are actually using a long term feature branch, the [multicluster](https://github.com/jenkins-x/jx/tree/multicluster) branch of [jenkins-x/jx](https://github.com/jenkins-x/jx/tree/multicluster) currently in Labs. As the [Accelerate book](/docs/overview/accelerate/) describes very clearly; long term feature branches are not a habit of high performing team teams - so this is bad! 

So our intention is to try get changes from that branch either merged upstream or the code changed in that branch moved into separate microservices we can use; so that eventually we can reuse upstream [jenkins-x/jx](https://github.com/jenkins-x/jx/) and avoid the long term feature branch. 