---
title: Using ChatOps and PR commands
linktitle: ChatOps and PRs
description: Using ChatOps and managing pull requests with Jenkins X
weight: 20
---

_ChatOps_ are operating codes and GitOps commands sent via chat.
These actions are performed via commenting on Pull Requests on your git providers website.

## ChatOps Commands

| ChatOps Command | GitLab Command | Description |
|       :---      |       :---     |    :---     |
| `/lgtm` | `/lh-lgtm` | This PR looks good to me - this command can be from anyone with access to the repo |
| `/approve` | `\lh-approve` | This PR can be merged - must be someone in the repo `OWNERS` file |
| `/test this` | `\lh-test this` | Run the default test pipeline context for this PR |
| `/test (context)` | N/A | Run a specific test pipeline context by name |
| `/retest` | `/lh-retest` | Rerun any failed test pipeline contexts for this PR |
| `/override (context)` | `/lh-override (context)` | Override a failed pipeline context |
| `/hold` | `/lh-hold` | Set this PR to not automerge even if it has been set `lgtm` and approved |
| `/hold cancel` | `/lh-hold cancel` | remove the `\hold` on the automerge |
| `/assign (user)` | `/lh-assign (user)` | assign the PR to the given (`user`) |
| `/unassign (user)` |  `/lh-unassign (user)` | remove the `user` as assignee |
| `/cc (user)` |  `/lh-cc (user)` | add the given `user` as a reviewer for the PR |
| `/uncc (user)` |  `/lh-uncc (user)` | remove the `user` as a reviewer |
| `/ok-to-test` |  `/lh-ok-to-test` | If a `user` without write access to the repo opens a PR, the PR will not be built automatically. It receives the `needs-ok-to-test` label, until a user with rights enters `/ok-to-test`, at which point it gets be built |

## Pull Requests

The pull request (PR) is the foundation of Jenkins X CI/CD pipeline execution. 
In PRs, Jenkins X allows developers and reviewers to:

* Verify changes
* Review PR code changes and their effects
* Approve or deny PRs or suggest changes
* Approve PRs and trigger automatic merge and promotion
* Manual promotion of PRs to production environments and software releases

Pull requests can be marked as work in progress, blocking automerging, either via making the PR a draft on GitHub, or by adding `WIP:`, `wip:`, `[wip]:`, or similar at the beginning of the PR title. 
The PR will be moved out of work-in-progress when no longer in draft or when the `WIP` prefix in the PR title has been removed.

### How Lighthouse merges a PR

There are some unique actions and behaviors when using lighthouse as the webhook handler for Jenkins X:

* The PR must have its required test contexts pass (by default, just `pr-build`).
* PRs must be set `/lgtm` and approved, or have the `updatebot` label on it.
* The PR must not have any merge conflicts.
* If multiple PRs are all in the merge pool at the same time, the lowest numbered PR will be merged first, then the next one will be rebuilt and then merged, etc.
