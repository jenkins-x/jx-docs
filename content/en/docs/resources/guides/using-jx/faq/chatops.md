---
title: ChatOps
linktitle: ChatOps
description: Using ChatOps with Jenkins X
weight: 20
---

## What is ChatOps?

We use the phrase _ChatOps_ to mean operating code changes and GitOPs promotion via chat. More specifically this usually is done via commenting on Pull Requests on your git providers website; though in the future this could be via Slack or web consoles too.

## What are the benefits of ChatOps?

ChatOps helps developers collaborate on Pull Requests and speeds up merging of Pull Requests. We want to be able to merge changes as quickly as possible into master so that we continuously integrate code which minimises the downsides of long term feature branching and merge hell.

ChatOps (and [tide in particular](#what-does-hook-do)) also helps automate and speeds up tasks e.g.

* developers don't have to keep hitting reload on a Pull Request page waiting for all the tests to pass so that they can click `Merge`. Just add a `/lgtm` comment or approve the code review and the Pull Request will automatically get merged once its tests go green. This also avoids developers accidentally hitting `Merge` before all the test pass!
* all Pull Request are automatically rebased and tested against master before merging - further ensuring we don't accidentally break master
* batch merging of Pull Request is supported to speed up merging Pull Requests.

For more detail see [what does tide do](#what-does-hook-do)

## Which kinds of webhook support ChatOps?

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) support both webhooks and [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) whereas Jenkins just supports webhooks only.

## How do I re-trigger a PR pipeline?

If a pipeline fails due to some compile error or failing test - fix the code and push your changes and the Pull Request pipeline will rerun.

If you think the pipeline failed due to some temporary infrastructure reason then you can use ChatOps to re-trigger the pipeline via commenting on the Pull Request:

* `/retest` reruns only failed pipelines
* `/test all` reruns all failed pipelines.
* `/test foo` reruns the pipeline called `foo` only

Note that you need to be in the `OWNERS` file as an [approver for this to work](#why-did-a-pullrequest-have-no-pipeline-triggered). 

## How do I add multiple parallel pipelines to a project?

It can be useful to have multiple pipelines to perform different kinds of long running tests on Pull Requests. e.g. running the same test suite using different databases, microsevice configurations or underlying infrastructure.

In Jenkins X you can create a custom `Scheduler` resource in your [jx boot](/docs/getting-started/setup/boot/) configuration (in `env/templates/myscheduler.yaml`) which you can add multiple named contexts in the `presubmits` section. Then for each context name make sure you have a file called `jenkins-x-${context}.yml` in your project. 

Then Jenkins X will invoke each context on demand via `/test mycontext` or automatically if you enable `alwaysRun: true`.

You can see how we define lots of [parallel testing contexts in the version stream here](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/f377a72498282de9ee49b807b4d5ba74321a4fab/env/templates/jx-versions-scheduler.yaml#L18) which all run in parallel and report their status on each pull request on the [version stream](/about/concepts/version-stream/)

See also [How do I map SourceRepository to a custom Scheduler?](/docs/resources/faq/boot/#how-do-i-map-sourcerepository-to-a-custom-scheduler)

## What does hook do?

`hook` is the name of the microservice in [Prow](/docs/reference/components/prow/) and the http endpoint in [Lighthouse](/architecture/lighthouse/) which listens to webhooks coming in from your git provider which then gets processed as either a ChatOps command or a trigger of a pipeline.

## What does tide do?

`tide` is a microservice in  [Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) which periodically queries open pull requests on the repositories you have imported into Jenkins X. Then it performs the following logic:

* if a Pull Request has passed all of its review + CI tests (e.g. its got the `approved` and/or `lgtm` labels applied or has passed a github code review) and is green and is based off of master it is automatically merged.
* if a Pull Request has passed all of its review + CI tests but is not based off of master its pipelines are re-triggered based off of master to ensure the Pull Request will be valid if it were merged.
* if batching is enabled and there are multiple pending Pull Requests which are approved and green, a batch pipeline is triggered which combines multiple Pull Requests together into a single change - if all those pipelines go green then all the PRs are merged together at once and closed. This greatly speeds up getting multiple Pull Requests merged together (as it avoids re-triggering each PR's tests after each one is merged).

## How can I make ChatOps HA?

To make ChatOps highly avialable scale up the deployments which listen for http requests to, say, 3 replicas.

When using [Lighthouse](/architecture/lighthouse/) that just means modifying the replicas for the `lighthouse` deployment. e.g. in your [boot](/docs/getting-started/setup/boot/) git repository try changing `env/lighthouse/values.tmpl.yaml` to:

```yaml
replicaCount: 3
```


When using [Prow](/docs/reference/components/prow/) you need to scale up `hook` and `pipelinerunner`. e.g. in your [boot](/docs/getting-started/setup/boot/) git repository try changing `env/prow/values.tmpl.yaml` to:

```yaml
hook:
  replicaCount: 3
pipelinerunner:
  replicaCount: 3
```


## Should I use prow or lighthouse?

If you are using a git server other than https://github.com then we recommend [Lighthouse](/architecture/lighthouse/).

If you are using https://github.com then for your git server then for now we recommend [Prow](/docs/reference/components/prow/) as it has had more testing than [Lighthouse](/architecture/lighthouse/).

Though [Lighthouse](/architecture/lighthouse/) is our strategic direction. We are starting to incrementally move our open source repositories over to [Lighthouse](/architecture/lighthouse/). At some point in the future once we've been using [Lighthouse](/architecture/lighthouse/) in production for all of our open source and commercial repositories [Lighthouse](/architecture/lighthouse/) will become our recommended solution for all git providers so that we can have a single, simpler & smaller codebase to maintain.

## How to handle a flaky/broken pipeline

If you have a pending Pull Request which is blocked on a flaky test or an incorrectly failing lint or code review; you can use ChatOps to override its status via the ChatOps command: `/override nameOfPipeline`

## Why did a PullRequest have no pipeline triggered?

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) use an `OWNERS` file stored in each git repository to define which developers are allowed to review and approve changes. You can even limit those roles to different folders.

If a non-reviewer submits a Pull Request it won't trigger CI pipelines by default until a reviewer adds an `/ok-to-test` comment on the Pull Request.

If you have public git repositories this also avoids the security issue of a non-approver submitting a Pull Request to change the pipeline to email them your security credentials in the CI pipeline ;)

