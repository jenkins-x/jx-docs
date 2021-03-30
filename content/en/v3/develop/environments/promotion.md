---
title: Promotion
linktitle: Promotion
type: docs
description: How Apps are Promoted across Environments
weight: 400
---

When changes are merged to the main branch in the Jenkins X pipeline catalog a new versioned release is created (with a new image and helm chart). This new version is then promoted by creating Pull Requests on GitOps repositories.

## How it works

The release pipelines use the [jx promote --all](https://github.com/jenkins-x/jx-promote/blob/master/docs/cmd/jx-promote.md#jx-promote) command which creates Pull Requests on all Environments conigured in your `jx-requirements.yml` file (see the [Configuration](/v3/develop/environments/config/)) 

* every environment which is defined in `jx-requirements.yml` as `promotionStrategy` **Auto** or **Manual** is included in a Pull Request to promote the new version to that environment

  * **Auto** means the Pull Request will automatically merge if its successful (the Pull Request pipeline succeeds)

  * **Manual** means the Pull Request is a draft and won't automatically merge. i.e. the Pull Request needs to be manually approved (comment `/approve`) and taken off hold (comment `/hold cancel`). 

* all local Environments in your `jx-requirements.yml` of the promotion kind **Auto** are promoted using a single Pull Request so that all the promotions automatically merge if the pull request pipeline validates successfully.

* you can define multiple local or remote Environments for different system / integration testing environments.

## Changing Promotion

If you want to disable promotion Pull Requests on an environment just remove the entry in `jx-requirements.yml` or configure the `promotionStrategy` to be **Never**

If you want your application to promote to different environments to the defaults for your cluster you can always [modify your pipeline](/v3/develop/pipelines/#editing-pipelines) and change the promote step to use different [jx promote](https://github.com/jenkins-x/jx-promote/blob/master/docs/cmd/jx-promote.md#jx-promote) arguments; e.g. pass in the explicit environments or repositories you want to promote to in the pipeline step.

