---
title: Features
linktitle: Features
description: How Jenkins X can help you deliver continuously
weight: 30
---


## Command Line

Jenkins X comes with a handy [jx](/commands/jx/) command line tool to easily:

* [install Jenkins X](/docs/getting-started/setup/install/) inside your existing kubernetes cluster
* [create a new kubernetes cluster](/docs/getting-started/setup/create-cluster/) and install Jenkins X into it
* [import projects](/docs/resources/guides/using-jx/creating/import/) into Jenkins X and their Continuous Delivery pipelines setup
* [create new Spring Boot applications](/developing/create-spring/) which get imported into Jenkins X and their Continuous Delivery pipelines setup

## Automated Pipelines

Jenkins X will automatically set up awesome pipelines for your projects that fully implement both CI and CD using [DevOps best practices](/about/concepts/).

## Environments

An _environment_ is a place where applications get deployed. Developers often refer to environments using a short name like `Testing, Staging/UAT or Production`.

With Jenkins X each _team_ gets its own Environments. By default Jenkins X creates a `Staging` and `Production` environment for each team but you can create new environments via [jx create environment](/commands/jx_create_environment/).

There is also the `Dev` environment which is where tools like Tekton, Nexus or Prow are installed and where CI/CD pipelines run.

We use GitOps to manage the configuration and version of the kubernetes resources which are deployed to each environment. So each Environment has its own git repository that contains all the Helm Charts, their versions and the configuration for the applications be run in the environment.

An Environment maps to a namespace in a Kubernetes cluster. When Pull Requests are merged into the environments git repository the pipeline runs for the environment which then applies the helm charts in git to the environments namespace.

This means both developers and operations can use the same git repository to manage all the configuration and versions of all the applications and resources for an environment in the same git repository and all changes to the environment are captured in git. So its easy to see who made changes when and more importantly its then easy to revert changes which cause bad things to happen.

<img src="/images/gitops.png" class="img-thumbnail">

## Teams

A Team in Jenkins X is represented by an install of Jenkins X in a separate namespace.

You can install Jenkins X into different namespaces in the same cluster if you wish using the `--namespace` command line argument in [jx create cluster](/commands/jx_create_cluster/) or [jx install](/commands/deprecation/). Note that to support multiple installs of Jenkins X in the same cluster you need to [avoid Tiller if you are using helm 2.x](/news/helm-without-tiller/).

You can also use the [jx create team](/commands/jx_create_team/) CLI which creates a new `Team` [Custom Resource](/docs/reference/components/custom-resources/) then in the background the team controller will create a new Jenkins X install in the teams namespaces, by default reusing the same underlying nexus and docker registry.

See the [configuration guide](/docs/resources/guides/managing-jx/common-tasks/config/) for more details on how to share resources like Nexus across Teams.


## Promotion

Promotion is implemented with GitOps by generating a pull request on the Environment's git repository  so that all changes go through git for audit, approval and so that any change is easy to revert.

When a new change to an environments git repository is merged to master, the pipeline for the environment triggers which applies any changes to the resources via helm - using the source code from the git repository.

The CD Pipelines of Jenkins X automate the promotion of version changes through each Environment which is configured with a _promotion strategy_ property of `Auto`. By default the `Staging` environment uses automatic promotion and the `Production` environment uses `Manual` promotion.

To manually promote a version of an application to an environment you can use [jx promote](/developing/promote/) command.

<img src="/images/overview.png" class="img-thumbnail">

## Preview Environments

Jenkins X lets you spin up Preview Environments for your Pull Requests so you can get fast feedback before changes are merged to master. This gives you faster feedback for your changes before they are merged and released and allows you to avoid having human approval inside your release pipeline to speed up delivery of changes merged to master.

When the Preview Environment is up and running Jenkins X will comment on your Pull Request with a link so in one click your team members can try out the preview!

<img src="/images/pr-comment.png" class="img-thumbnail">


## Feedback

As you can see above Jenkins X automatically comments on your Pull Requests when using Preview Environments.

If the commit comments reference issues (e.g. via the text `fixes #123`) then Jenkins X pipelines will generate release notes like those of [the jx releases](https://github.com/jenkins-x/jx/releases).

Also as the version with those new commits is promoted to `Staging` or `Production` you will get automated comments on each fixed issue that the issue is now available for review in the corresponding environment. e.g.

<img src="/images/issue-comment.png" class="img-thumbnail">


## Applications

A collection of best of breed software tools packaged as helm charts that come pre-integrated with Jenkins X such as: Nexus, ChartMuseum, Monocular, Prometheus, Grafana etc

### Addons

Some of these applications are baked in; like: Nexus, ChartMuseum, Monocular.  Others are provided as an `Addon`.

To install an addon then use the [jx create addon](/commands/jx_create_addon/) command. e.g.

```sh
jx create addon grafana
```
