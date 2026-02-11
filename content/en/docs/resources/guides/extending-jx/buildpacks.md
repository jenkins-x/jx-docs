---
title: Build Packs
linktitle: Build Packs
description: Extending Jenkins X using custom Build Packs
type: docs
weight: 40
---

## Build Packs & Pod Templates

In Jenkins X a _Build Pack_ allows you to transform source code into a applications which can be deployed on Kubernetes. Build Packs are based on [draft](https://draft.sh/), and will automatically add:

* `Dockerfile` to turn the code into an immutable docker image for running on kubernetes
* `Jenkinsfile` to define the declarative Jenkins pipeline to define the CI/CD steps for the application
* helm chart in the `charts` folder to generate the kubernetes resources to run the application on kubernetes
* a *preview chart* in the `charts/preview` folder to define any dependencies for deploying a preview environment on a Pull Request

If you need to add support for different languages or build tools then you will need to create a new _Pod Template_. A pod template defines the pod used to run the build, and consists of:

* one or more build containers for running commands inside (e.g. your build tools like `mvn` or `npm` along with tools we use for other parts of the pipeline like `git`, `jx`, `helm`, `kubectl` etc)
* volumes for persistence
* environment variables
* secrets so the pipeline can write to git repositories, docker registries, maven/npm/helm repositories and so forth

Read more about [creating build packs](/docs/create-project/build-packs/#creating-new-build-packs) and [creating pod templates](/docs/reference/components/pod-templates/).
