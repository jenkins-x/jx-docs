---
title: Build Packs
linktitle: Build Packs
description: Turning source code into applications on kubernetes
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 70
weight: 70
sections_weight: 70
draft: false
toc: true
---

We use [draft](https://draft.sh/) style _build packs_ for different languages, runtimes and build tools to add the necessary configuration files to projects as we [import them](/developing/import/) or [create](/developing/create-spring/) [them](/developing/create-quickstart/) so that we can build and deploy them in kubernetes.

The build packs are used to default the following files if they do not already exist in the project being created/imported:

* `Dockerfile` to turn the code into an immutable docker image for running on kubernetes
* `Jenkinsfile` to define the declarative Jenkins pipeline to define the CI/CD steps for the application
* helm chart in the `charts` folder to generate the kubernetes resources to run the application on kubernetes
* a _preview chart_ in the `charts/preview` folder to define any dependencies for deploying a [preview environment](/about/features/#preview-environments) on a Pull Request   

The default build packs are at [https://github.com/jenkins-x/draft-packs](https://github.com/jenkins-x/draft-packs) with a folder for each language or build tool.

The `jx` command line clones the build packs to your `.~/.jx/draft/packs/` folder and updates them via a `git pull` each time you try create or import a project.
