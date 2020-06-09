---
title: Introduction
linktitle: Apps Framework
description: Extending Jenkins X using the Apps Framework
type: docs
weight: 1
aliases:
    - /docs/contributing/addons/
---

> This guide is still a work in progress!

In this guide we will explore the Apps Framework that allows you to extend and enhance the capabilities in Jenkins X.

> We're still working on the ability to alter the pipeline from an app - right now our apps include a section in the
  README explaining how to change your `JenkinsFile`.

> Once complete an App will be able to add, remove and alter stages of the pipeline.

Jenkins X is built on top of Kubernetes. Kubernetes is highly configurable and extensible. This extensibility forms the
basis of many of the ways we recommend extending Jenkins X.

The Apps Framework consists of a number of areas:

* the install and configuration framework
* the APIs offered by Jenkins
* the data model
* pipeline extensibility
* the testing framework
* plugins for the `jx` CLI


In this reference guide we'll cover each of these areas in depth. We also provide a number of other resources for
working with the Apps Framework:

* Tutorials
* How To's
* Articles

# Install and Configuration Framework

Jenkins X Apps are distributed as Helm Charts via Helm Chart repositories. Any Helm chart can be installed as an app
using `jx add app`, although Jenkins X adds various capabilities to Helm Charts including:

* the ability to interactively ask questions to generate `values.yaml` based on JSON Schema
* the ability to create pull requests against the GitOps repo that manages your team/cluster
* the ability to store secrets in vault
* the ability to upgrade all apps to the latest version

Planned features include:

* integrating [kustomize](https://github.com/kubernetes-sigs/kustomize) to allow existing charts to be modified
* storing Helm repository credentials in vault
* taking existing `values.yaml` as defaults when asking questions based on JSON Schema during app upgrade
* only asking new questions during app upgrade
* `jx get apps` - the ability to list all apps that can be installed
* integration for bash completion

# APIs

APIs can be consumed from a microservice deployed to Kubernetes, from outside the cluster (with appropriate
configuration for authentication) or from inside pipeline extensions.

Jenkins X APIs uses [Kubernetes Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) to expose its API. The API is declarative, and
Jenkins X uses controllers to try to match the actual state to the desired state. Jenkins X continually takes action
to achieve and maintain the desired state.

Jenkins X uses this architectural pattern itself meaning that this API is very complete.

Custom resources are exposed by the Kubernetes API server and can be accessed as REST endpoints, using `kubectl` or
via client libraries for different platforms. Currently we offer clients for:

* Go
* Java (incomplete) - [Quickstart](https://github.com/jenkins-x-quickstarts/spring-boot-watch-pipeline-activity)
* Javascript [Quickstart](https://github.com/jenkins-x-quickstarts/spring-boot-watch-pipeline-activity)

## Using `jx` as a library

[jx](https://github.com/jenkins-x/jx) contains many useful functions and is documented on [godoc.org](https://godoc.org/github.com/jenkins-x/jx). The easiest way to consume it is is as a go module:

```sh
go get github.com/jenkins-x/jx
```
## `jx` app CLI Commands

* [jx add app](/commands/jx_add_app/)	 - Adds an app to Jenkins X
* [jx delete app](/commands/jx_delete_app/)	 - Deletes one or more apps from Jenkins X
* [jx get apps](/commands/jx_get_apps/)	 - Display one or more installed apps
* [jx upgrade apps](/commands/jx_upgrade_apps/)	 - Upgrades one or more apps to a newer release

## Source code management

The ability to add new SCM connections to Jenkins X from an app is under active development.

## Identity Management

In the future we intend to add the ability to plug your own identity management and SSO solution in to Jenkins X.

## Custom Quickstarts

Jenkins X ships with a series of quickstarts that provide you with pre-made applications that you can start a project with.

You can create your own quickstarts that give your team members a starting point. Read more about [creating quickstarts](/docs/create-project/creating/).

You can customize the list of quickstarts available to your team making it easier for them to select the right place to start. Read more about [customizing the quickstarts available](/docs/create-project/creating/#customising-your-teams-quickstarts).



# Pipeline Extensibility

## Pipeline triggers

TODO

## Build environment (creds, env vars, parameters)

### Build Packs & Pod Templates

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

## Build Stages

Build stages are defined in the `Jenkinsfile`. The `Jenkinsfile` defines the actions to take, and the order in which to
take the actions.

The order is of actions is procedural - the first action defined will be executed first. Simple conditions are supported via the `when` directive.

The action that can be taken are defined by the pipeline engine. In the case of a Jenkinsfile these are defined in the [Pipeline Steps Reference](https://jenkins.io/doc/pipeline/steps/). Typically in Jenkins X we use the `sh` step which allows us to execute any shell script in the build container.

Read more about [defining pipelines](https://jenkins.io/doc/book/pipeline/syntax/) using the `Jenkinsfile`.

We're still working on adding the ability to customize build stages to the Apps Framework.

# Data Model

# Testing Frame

# `jx` CLI plugins

The `jx` CLI can be extended with binary plugins. Binary plugins are separate binaries to `jx` that are entirely
responsible for their own execution (argument parsing, subcommands, platform compatibility). We strongly recommend
writing binary plugins in Go and using the [Cobra CLI framework](https://github.com/spf13/cobra) just like `jx`
itself. Binary plugins can import `jx` as a library of useful functions.

Jenkins X provides a management framework for binary plugins that allows them to be automatically installed on the
users machine when the relevant subcommand is called. The management framework will also take care of upgrading and
removing plugins as needed. Plugins are managed by adding a custom resource to the team or cluster.
