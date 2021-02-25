---
title: General
linktitle: General
type: docs
description: General questions on configuration
weight: 100
---

## How do I add an Environment

With v3 everything is done via GitOps - so if in doubt the answer is to modify git. 

You can create new environments by adding to the `environments:` section of [jx-requirements.yml](https://github.com/jx3-gitops-repositories/jx3-kubernetes/blob/master/jx-requirements.yml#L18)
     
## How do I specify DOCKER_REGISTRY_ORG?

If you need to you can override in a specific repository (via a `.jx/settings.yaml` in your repository) but usually its common to all repos and is inherited from your `jx-requirements.yml` in your development environment repository

See the [file reference](/v3/develop/reference/files/)
