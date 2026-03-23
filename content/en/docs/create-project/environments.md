---
title: Environments
linktitle: Environments
description: Working with Jenkins X environments
weight: 30
---

An _environment_ is a place where applications get deployed. Developers often refer to environments using a short name like `Testing, Staging/UAT or Production`.

With Jenkins X each _team_ gets its own Environments. By default Jenkins X creates a `Staging` and `Production` environment for each team but you can create new environments via [jx create environment](/commands/jx_create_environment/).

There is also the `Dev` environment which is where tools like Tekton, Nexus or Prow are installed and where CI/CD pipelines run.

We use GitOps to manage the configuration and version of the kubernetes resources which are deployed to each environment. So each Environment has its own git repository that contains all the Helm Charts, their versions and the configuration for the applications be run in the environment.

An Environment maps to a namespace in a Kubernetes cluster. When Pull Requests are merged into the environments git repository the pipeline runs for the environment which then applies the helm charts in git to the environments namespace.

This means both developers and operations can use the same git repository to manage all the configuration and versions of all the applications and resources for an environment in the same git repository and all changes to the environment are captured in git. So its easy to see who made changes when and more importantly its then easy to revert changes which cause bad things to happen.

<img src="/images/gitops.png" class="img-thumbnail">