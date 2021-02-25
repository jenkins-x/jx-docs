---
title: General
linktitle: General
type: docs
description: General questions on configuration
weight: 100
---

## What is the directory layout?

To understand the directory layout see [this document](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md) and the [file reference](/v3/develop/reference/files/)
       

## How do I add an Environment

With v3 everything is done via GitOps - so if in doubt the answer is to modify git. 

You can create new environments by adding to the `environments:` section of [jx-requirements.yml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L18)
     
## How do I specify DOCKER_REGISTRY_ORG?

If you need to you can override in a specific repository (via a `.jx/settings.yaml` in your repository) but usually its common to all repos and is inherited from your `jx-requirements.yml` in your development environment repository

See the [file reference](/v3/develop/reference/files/)

## If I add a file to `config-root` it gets deleted, why?

The `config-root` directory is regenerated on every boot job - basically every time you promote an application or merge a change into the main branch of your git dev cluster git repository.  For background see the [dev git repository layout docs](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md))

To add a new chart add to the `helmfiles/mynamespace/helmfile.yaml` file follow the [add chart guide](/v3/develop/apps/#adding-charts).

To add a new kubernetes resource [follow the add resources guide](/v3/develop/apps/#adding-resources).
      
