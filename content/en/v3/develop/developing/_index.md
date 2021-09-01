---
title: Developing
linktitle: Developing
type: docs
description: How to work on code with git and CI/CD
weight: 90
---
    
Someone on your team has [setup Jenkins X on a kubernetes cluster](/v3/admin/). So how do you use it?

Mostly you just use your IDE and git to change code in your usual way.

Though we do prefer you submit code changes via [Pull Requests](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests) to then trigger CI and [Preview Environment](/v3/develop/environments/preview/) for each Pull Request.

## Demo

To see how to create a [Preview Environment](/v3/develop/environments/preview/) on a Pull Request see this demo:

<iframe width="560" height="315" src="https://www.youtube.com/embed/x-GtKmmhDSI" title="Demo of creating Preview Environments on Pull Requestss with Jenkins X" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

### Creating a project

To see how to [create a new project](/v3/develop/create-project/) and get started developing with Jenkins X check out this demo:

<iframe width="560" height="315" src="https://www.youtube.com/embed/4wqwulEzseM?t=279s" title="Demo of developing with Jenkins X" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Pull Requests

The pull request (PR) is the foundation of Jenkins X CI/CD pipeline execution.

Note that some git providers call these `merge requests` instead of `pull requests`.

Using Pull Requests allows developers, reviewers and Jenkins X to:

* Verify changes are valid: unit tests still pass, code is linted and so forth
* Review PR code changes and their effects
* Approve or deny PRs or suggest changes
* Approve PRs and trigger automatic merge and promotion
* Manual promotion of PRs to production environments and software releases

### Preview Environments

The other advantage of working with Pull Requests is the automated CI/CD in Jenkins X creates a [Preview Environment](/v3/develop/environments/preview/) for each Pull Request

### Work in progress (WIP)

Pull requests can be marked as work in progress, blocking auto-merging, either via making the PR a draft on GitHub, or by adding `WIP:`, `wip:`, `[wip]:`, or similar at the beginning of the PR title.
The PR will be moved out of work-in-progress when no longer in draft or when the `WIP` prefix in the PR title has been removed.

### How Lighthouse merges a PR

There are some unique actions and behaviors when using [lighthouse](/v3/about/overview/#lighthouse) to implement ChatOps:

* The PR must have its required test contexts pass (by default, just `pr-build`).
* PRs must be set `/lgtm` and approved, or have the `updatebot` label on it.
* The PR must not have any merge conflicts.
* If multiple PRs are all in the merge pool at the same time, the lowest numbered PR will be merged first, then the next one will be rebuilt and then merged, etc.

### After Pull Requests merge

Once your pull request merges a new release is created for your application, creating new artifacts, images, helm charts etc

Then automatic [Promotion Pull Requests](/v3/develop/environments/promotion/) are triggered.

By default your new version is promoted to the `Staging` environment. Though you need to manually approve the Pull Request to promote to `Production`.

You can [Configure promotion to behave differently if you need it](/v3/develop/environments/config/)

### Using ChatOps

_ChatOps_ lets you interact with the Pull Request via special comments on the Pull Request via your git providers website.

See the [ChatOps Command Reference](/v3/develop/reference/chatops/)
