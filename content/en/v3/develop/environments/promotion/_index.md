---
title: Promotion
linktitle: Promotion
type: docs
description: How Apps are Promoted across Environments
weight: 250
---

When changes are merged to the main branch in the Jenkins X pipeline catalog a new versioned release is created (with a new image and helm chart). This new version is then promoted by creating Pull Requests on GitOps repositories.

## How it works

The release pipelines use the [jx promote --all](https://github.
com/jenkins-x/jx-promote/blob/master/docs/cmd/jx-promote.md#jx-promote) command which creates Pull Requests on all 
Environments configured in your `jx-requirements.yml` file and possibly `.jx/gitops/source-config.yaml` or 
`.jx/settings.yaml` (see the [Configuration](/v3/develop/environments/config/)).

* every environment which is defined as `promotionStrategy` **Auto** or **Manual** is included in a Pull Request to promote the new version to that environment

  * **Auto** means the Pull Request will automatically merge if its successful (the Pull Request pipeline succeeds)

  * **Manual** means the Pull Request is a draft and won't automatically merge. i.e. the Pull Request needs to be manually approved (comment `/approve`) and taken off hold (comment `/hold cancel`). 

* all local Environments of the promotion kind **Auto** are promoted using a single Pull Request so that all the promotions automatically merge if the pull request pipeline validates successfully.

* you can define multiple local or remote Environments for different system / integration testing environments.


## Disable Promotion

If you want to disable promotion Pull Requests on an environment just remove the entry or configure the 
`promotionStrategy` to be **Never**.

## Reuse pull requests

By default a new pull request is created for each promotion. You can instead make existing open pull requests for 
promoting an application be reused. 

Enabling reuse of pull requests for `jx promote` is done in `jx-requirements.yaml` by setting `reusePullRequest` to 
`true` for an environment. It can also be done in the same way when configuring environments others ways. See 
https://jenkins-x.io/v3/develop/environments/config/ for more details about configuring environments.

There are two main reasons why you would want to enable this:

To reduce conflicts: if a pull request is created before a previous pull request for upgrading the same application is 
merged there will be a conflict when the earlier pull request is merged. Since enabling reuse means that `jx 
promote` won't open more pull requests for an application this can't happen. 

The other reason is if you make use of the functionality to propagate application changelogs to cluster 
repositories. This is described in the blog post
[Improve your changelogs](/blog/2023/05/24/propagate-changelogs/#reuse-pull-requests).

## Synchronizing environments or namespaces

By default each release of each microservice creates a Pull Request to upgrade that specific microservice to a new version in each of your environments - e.g. `Staging` and `Production`.

When human approval is required in, say, `Production` you can end up with the `drift` between the 2 environments and want an easy way to bring them in sync.


The default with Jenkins X is for each new version of each microservice to be promoted immediately to `Staging`. You may want to test the combination of microservices together for a while beforethen choosing to promote changes to production and may want to do this in one atomic Pull Request and commit/merge.

If you wish to work in this way you can create a single Pull Request promoting all of the changes of apps between 2 environments or namespaces.

You can use the [jx updatebot sync](/v3/develop/reference/jx/updatebot/sync/) command to synchronise 2 environments or namespaces to reduce drift by creating a single Pull Request to add any missing applications or upgrade them.

```bash 
# synchronizes the apps in 2 of your environments (local or remote)
jx updatebot sync --source-env staging --target-env production
```

This works whether the environments are separate namespaces within the same kubernetes cluster or you are using [Multiple Cluster](/v3/admin/guides/multi-cluster/)

Note that if you are using [Multiple Clusters](/v3/admin/guides/multi-cluster/) make sure your terminal is connected to the development cluster before running [jx updatebot sync](/v3/develop/reference/jx/updatebot/sync/)
