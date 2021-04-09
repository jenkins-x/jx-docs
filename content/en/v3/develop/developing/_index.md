---
title: Developing
linktitle: Developing
type: docs
description: How to work on code with git and CI/CD
weight: 450
---
    
So you or someone on your team has [setup Jenkins X on a kubernetes cluster](/v3/admin/). So how do you use it? 

Mostly you just use your IDE and git to change code in your usual way.

Though we prefer you submit code changes via [Pull Requests](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests) on your git providers (some git providers call these `merge requests`).

## Pull Requests

The pull request (PR) is the foundation of Jenkins X CI/CD pipeline execution. 

Using Pull Requests allows developers, reviewers and Jenkins X to:

* Verify changes
* Review PR code changes and their effects
* Approve or deny PRs or suggest changes
* Approve PRs and trigger automatic merge and promotion
* Manual promotion of PRs to production environments and software releases

Pull requests can be marked as work in progress, blocking auto-merging, either via making the PR a draft on GitHub, or by adding `WIP:`, `wip:`, `[wip]:`, or similar at the beginning of the PR title. 
The PR will be moved out of work-in-progress when no longer in draft or when the `WIP` prefix in the PR title has been removed.

### How Lighthouse merges a PR

There are some unique actions and behaviors when using [lighthouse](/v3/about/overview/#lighthouse) to implement ChatOps:

* The PR must have its required test contexts pass (by default, just `pr-build`).
* PRs must be set `/lgtm` and approved, or have the `updatebot` label on it.
* The PR must not have any merge conflicts.
* If multiple PRs are all in the merge pool at the same time, the lowest numbered PR will be merged first, then the next one will be rebuilt and then merged, etc.
          

### Using ChatOps

_ChatOps_ lets you interact with the Pull Request via special comments on the Pull Request via your git providers website.

See the [ChatOps Command Reference](/v3/develop/reference/chatops/)


