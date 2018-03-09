---
title: Features
linktitle: Features
description: How Jenkins X can help you deliver continuously
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "about"
    weight: 20
weight: 20
sections_weight: 20
draft: false
aliases: [/about/features]
categories: [fundamentals]
toc: true
---


## Command Line

Jenkins X comes with a handy [jx](/commands/jx) command line tool to easily:

* [install Jenkins X](/getting-started/install) inside your existing kubernetes cluster
* [create a new kubernetes cluster](/getting-started/create-cluster) and install Jenkins X into it
* [import projects](/developing/import) into Jenkins X and their Continuous Delivery pipelines setup
* [create new Spring Boot applications](/developing/create-spring) which get imported into Jenkins X and their Continuous Delivery pipelines setup

## Pipelines

Rather than having to have deep knowledge of the internals of Jenkins Pipeline, Jenkins X will default awesome pipelines for your projects that implements fully CI and CD using [DevOps best practices](/about/concepts)

## Environments

An _environment_ is a place where applications get deployed. Developers often refer environments using a short name like `Testing, Staging/UAT or Production`.

With Jenkins X each _team_ gets its own Environments. By default Jenkins X creates a `Staging` and `Production` environment for each team but you can create new environments via [jx create environment](/commands/jx_create_environment).

We use GitOps to manage the configuration and version of the kubernetes resources which are deployed to each environment. So each Environment has its own git repository that contains all the Helm Charts, their versions and the configuration for the applications be run in the environment. 

An Environment maps to a namespace in a Kubernetes cluster. When Pull Requests are merged into the environments git repository the pipeline runs for the environment which then applies the  helm charts in git to the environments namespace.

This means both developers and operations can use the same git repository to manage all the configuration and versions of all the applications and resources for an environment in the same git repository and all changes to the environment are captured in git. So its easy to see who made changes when and more importantly its then easy to revert changes which cause bad things to happen.

## Promotion

Promotion is implemented with GitOps by generating a pull request on the Environment's git repository  so that all changes go through git for audit, approval and so that any change is easy to revert.

When a new change to an environments git repository is merged to master, the pipeline for the environment triggers which applies any changes to the resources via helm - using the source code from the git repository.

The CD Pipelines of Jenkins X automate the promotion of version changes through each Environment which is configured with a _promotion strategy_ property of `Auto`. By default the `Staging` environment uses automatic promotion and the `Production` environment uses `Manual` promotion. 

To manually promote a version of an application to an environment you can use [jx promote](/developing/promote) command.

<img src="/images/overview.png" class="img-thumbnail">

## Preview Environments

Jenkins X lets you spin up Preview Environments for your Pull Requests so you can get fast feedback before changes are merged to master. This gives you faster feedback for your changes before they are merged and released and allows you to avoid having human approval inside your release pipeline to speed up delivery of changes merged to master.

When the Preview Environment is up and running Jenkins X will comment on your Pull Request with details of where the preview can be tried out.


## Feedback

Jenkins X automatically comments on your Commits, Issues and Pull Requests with feedback as code is ready to be previewed, is promoted to environments or if Pull Requests are generated automatically to upgrade versions. 

## Applications

A collection of best of breed software tools packaged as helm charts that come pre-integrated with Jenkins X such as: Nexus, Artifactory, SonarQube, Prometheus, Elasticsearch, Grafana etc
upgrade versions.

 
