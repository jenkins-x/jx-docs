---
title: ChatOps
linktitle: ChatOps
type: docs
description: ChatOps commands
weight: 450
---

You can type the following _ChatOps_ commands on Pull Requests as comments:

## ChatOps Commands

| ChatOps Command | Description |
|       :---      |    :---     |
| `/lgtm` | This PR looks good to me - this command can be from anyone with access to the repo who is in the `OWNERS` file |
| `/approve` | This PR can be merged - must be someone in the repo `OWNERS` file |
| `/test this` | Run the default test pipeline context for this PR |
| `/test (context)` | Run a specific test pipeline context by name |
| `/retest` | Rerun any failed test pipeline contexts for this PR |
| `/override (context)` | Override a failed pipeline context |
| `/hold` | Set this PR to not automerge even if it has been set `lgtm` and approved |
| `/hold cancel` | remove the `hold` label from the PR, allowing automerge |
| `/assign (user)` | assign the PR to the given (`user`) |
| `/unassign (user)` | remove the `user` as assignee |
| `/cc (user)` | add the given `user` as a reviewer for the PR |
| `/uncc (user)` | remove the `user` as a reviewer |
| `/ok-to-test` | If a `user` without write access to the repo opens a PR, the PR will not be built automatically. It receives the `needs-ok-to-test` label, until a user with rights enters `/ok-to-test`, at which point it gets be built |
