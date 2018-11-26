---
title: Overview
linktitle: Extending Jenkins X
description: Extending Jenkins X
date: 2018-09-04
publishdate: 2018-09-04
lastmod: 2018-09-04
categories: [extending]
keywords: []
menu:
  docs:
    parent: "extending"
    weight: 1
weight: 1
draft: false
aliases: [/extending/]
toc: false
---

> This guide is still a work in progress!


In this guide we will explore the extension points that Jenkins X offers.

Jenkins X is built on top of Kubernetes. Kubernetes is highly configurable and extensible. This extensibility forms the basis of many of the ways we recommend extending Jenkins X.

## Source code management

### SCM connections

Jenkins X comes with built in support for popular source code management providers such as GitHub.

TODO

* How to add other SCM connections

### SCM enhancements

SCM enhancements allow you to manipulate your source code prior to building it. In Jenkins X this is best achieved by customizing the build pipeline.

## Customizing the build pipeline

TODO write intro

### Pipeline triggers

Pipelines are automatically triggered when a new commit is made to a branch in the SCM repository. Pipelines can also be triggered manually using the JX command:

```bash
jx start pipeline <pipeline name>`
```

TODO REST API?

### Build environment (creds, env vars, parameters)

#### Containerization

Use containers to provide build environments.

Kubernetes is based around containers. Containers have low overhead and are isolated from one another. They bundle their own tools, libraries and configuration files. Containers are defined using configuration files meaning that they can always be reproduced.

Containers are ideal for creating builds as they can be created and discarded quickly, allowing each build to use an isolated, reproducible build environment. There are more than one hundred thousand containers in Docker Hub, any of which can be used as the basis for your build.

#### Build Packs & Pod Templates

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

Read more about [creating build packs](/architecture/build-packs#creating-new-build-packs) and [creating pod templates](/architecture/pod-templates).

### Build Steps

Build steps are defined in the `Jenkinsfile`. The `Jenkinsfile` defines the actions to take, and the order in which to take the actions.

The order is of actions is procedural - the first action defined will be executed first. Simple conditions are supported via the `when` directive.

The action that can be taken are defined by the pipeline engine. In the case of a Jenkinsfile these are defined in the [Pipeline Steps Reference](https://jenkins.io/doc/pipeline/steps/). Typically in Jenkins X we use the `sh` step which allows us to execute any shell script in the build container.

Read more about [defining pipelines](https://jenkins.io/doc/book/pipeline/syntax/) using the `Jenkinsfile`.

### Post-build

Post build steps work just like build steps and are defined using the `jx step post` command.

### Build reports

In the future we intend to provide a simple repository where you can attach reports to builds, apps and environments. We will also provide simple configuration allowing you to push reports generated during build steps into the repository, as well as tooling to view those reports.

### Artifact management

To add a externally hosted artifact repository (e.g. an npm repository) you would need to modify your projects build scripts to push to that repository or add a step to the build pipeline. In either case you will need to make sure the build pod has access to the correct secrets.

To include a artifact repository in Jenkins X would require you to create a new Jenkins X Addon that bundled the artifact repository. You would then modify your projects build scripts to push to that repository or add a step to the build pipeline. In either case you will need to make sure the build pod has access to the correct secrets.

## Identity Management

In the future we intend to add the ability to plug your own identity management and SSO solution in to Jenkins X.

## Integrating new functionality to Jenkins X

In many cases we recommend creating a new a microservice that integrates one or more existing APIs, or exposes one or more existing tools. We call these microservices _Jenkins X Addons_. For example, pushing comments to an issue tracker when a changeset that mentions the issue is built.

### Kubernetes

If you need to create a new microservice to add new functionality, some of the key Kubernetes concepts for extensiblity in Jenkins X are:

* Service Discovery. Kubernetes creates DNS records for any services deployed, and we make sure that all the components of Jenkins X that we create and deploy have good, well documented REST APIs. Service Discovery allows you to access any API deployed in the cluster - those that are part of the Jenkins X platform, those that you've added through other extensions, and any you create yourself.

* Custom Resource Definitions. A custom resource is an extension of the Kubernetes API and is ideal when you want to reuse the Kubernetes infrastructure to store a resources that are naturally scoped to the cluster or environment. Jenkins X uses custom resource definitions to add the `PipelineActivity` object to Kubernetes, which allow anyone to view changes to pipelines.

## Custom Quickstarts

Jenkins X ships with a series of quickstarts that provide you with pre-made applications that you can start a project with.

You can create your own quickstarts that give your team members a starting point. Read more about [creating quickstarts](/developing/create-quickstart).

You can customize the list of quickstarts available to your team making it easier for them to select the right place to start. Read more about [customizing the quickstarts available](/developing/create-quickstart#customising-your-teams-quickstarts).

## UI extension

In the future we may introduce the ability to extend UIs within Jenkins X however before we do that we want to better understand the requirements for UI extension based on feedback from users and our own experience building extensions.

## Marketplace

TODO Are what I called extensions just addons?

In the future we intend to build a Marketplace for extensions to Jenkins X to allow you to easily discover and install any extensions you wish to use.

We have intentionally delayed working on this, as we believe understanding and developing the extension points is more important. In the meantime, you can add to the list of extensions we maintain by sending a pull request.

TODO Create list of extensions

## TODOs

* Anchore