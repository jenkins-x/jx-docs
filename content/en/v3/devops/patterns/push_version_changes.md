---
title: Push Version Changes
linktitle: Push Version Changes
description: Push Version Changes into dependent repositories
type: docs
weight: 35
---

When you [Version Everything](/v3/devops/patterns/version_everything) you need a way to pull dependent versions into your git repositories.

Using the **push** model means that as you create a new versioned release of an artifact (library, binary, image, chart or whatever) you generate the necessary Pull Requests in your downstream repositories to upgrade to use this version.

We do this in Jenkins X using the [updatebot plugin](https://github.com/jenkins-x-plugins/jx-updatebot) as part of a release pipeline. The [go-plugin release pipelines](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/packs/go-plugin/.lighthouse/jenkins-x/release.yaml#L38) pipelines have a `promote-release` which uses the updatebot plugin to promote the new version to other git repositories. Here are some examples:

* the [jenkins-x/lighthouse](https://github.com/jenkins-x/lighthouse)  repository has this [.jx/updatebot.yaml](https://github.com/jenkins-x/lighthouse/blob/master/.jx/updatebot.yaml) to update the version stream on a release
* the [jx-gitops](https://github.com/jenkins-x/jx-gitops) repository has this  [.jx/updatebot.yaml](https://github.com/jenkins-x/jx-gitops/blob/master/.jx/updatebot.yaml) to update the plugin in the jx cli repository

Creating Pull Requests to modify versions means the team looking after the repository can decide when and how to merge the Pull Request; e.g. periodically or in quiet times when there are no serious production issues to resolve.
