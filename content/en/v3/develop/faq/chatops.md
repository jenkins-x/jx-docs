---
title: ChatOps
linktitle: ChatOps
type: docs
description: Using ChatOps with Jenkins X
weight: 220
aliases:
  - /resources/guides/using-jx/faq/chatops/
---

## What is ChatOps?

We use the phrase _ChatOps_ to mean operating code changes, pipelines and GitOps promotion via chat. More specifically this usually is done via commenting on Pull Requests on your git providers website; though in the future this could be via Slack or web consoles too.

## What are the benefits of ChatOps?

ChatOps helps developers collaborate on Pull Requests and speeds up merging of Pull Requests. We want to be able to merge changes as quickly as possible into master so that we continuously integrate code which minimises the downsides of long term feature branching and merge hell.

ChatOps  (and [lighthouse in particular](#what-does-lighthouse-do) also helps automate and speeds up tasks:

* developers don't have to keep hitting reload on a Pull Request page waiting for all the tests to pass so that they can click `Merge`. Just add a `/lgtm` comment or approve the code review and the Pull Request will automatically get merged once its tests go green. This also avoids developers accidentally hitting `Merge` before all the test pass!
* all Pull Request are automatically rebased and tested against master before merging - further ensuring we don't accidentally break master
* batch merging of Pull Requests is supported to speed up merging Pull Requests.

For more details see [what does lighthouse do](#what-does-lighthouse-do).

## Which kinds of webhook support ChatOps?

[Lighthouse](/v3/about/overview/#lighthouse) support these [ChatOps commands](/v3/develop/reference/chatops/)

## How do I re-trigger a PR pipeline?

If a pipeline fails due to some compile error or failing test - fix the code and push your changes and the Pull Request pipeline will rerun.

If you think the pipeline failed due to some temporary infrastructure reason then you can use ChatOps to re-trigger the pipeline via commenting on the Pull Request:

* `/retest` reruns only failed pipelines
* `/test all` reruns all failed pipelines.
* `/test foo` reruns the pipeline called `foo` only

Note that you need to be in the `OWNERS` file as an [approver for this to work](#why-did-a-pullrequest-have-no-pipeline-triggered).

See the [ChatOps commands](/v3/develop/reference/chatops/)

## How do I add multiple parallel pipelines to a project?

It can be useful to have multiple pipelines to perform different kinds of long running tests on Pull Requests. e.g. running the same test suite using different databases, microservice configurations or underlying infrastructure.

In Jenkins X you can create a custom `Scheduler` resource in your [jx boot](/docs/getting-started/setup/boot/) configuration (in `env/templates/myscheduler.yaml`) which you can add multiple named contexts in the `presubmits` section. Then for each context name make sure you have a file called `jenkins-x-${context}.yml` in your project.

Then Jenkins X will invoke each context on demand via `/test mycontext` or automatically if you enable `alwaysRun: true`.

You can see how we define lots of [parallel testing contexts in the version stream here](https://github.com/jenkins-x/environment-tekton-weasel-dev/blob/f377a72498282de9ee49b807b4d5ba74321a4fab/env/templates/jx-versions-scheduler.yaml#L18) which all run in parallel and report their status on each pull request on the [version stream](/about/concepts/version-stream/)

See also [How do I map SourceRepository to a custom Scheduler?](/docs/resources/faq/setup/#how-do-i-map-sourcerepository-to-a-custom-scheduler)

## What does lighthouse do?

Lighthouse handles webhooks and implements these [ChatOps commands](/v3/develop/reference/chatops/)

To see what each of the parts of lighthouse do please refer to the [lighthouse components overview](/v3/about/overview/#lighthouse)

## How can I make ChatOps HA?

To make ChatOps highly available scale up the [lighthouse webhook deployment](/v3/about/overview/#lighthouse)  which listen for http requests to, say, 3 replicas.

## How to handle a flaky/broken pipeline

If you have a pending Pull Request which is blocked on a flaky test or an incorrectly failing lint or code review; you can use ChatOps to override its status via the ChatOps command: `/override nameOfPipeline`

## Why did a PullRequest have no pipeline triggered?

[Lighthouse](/v3/about/overview/#lighthouse) use an `OWNERS` file stored in each git repository to define which developers are allowed to review and approve changes. You can even limit those roles to different folders.

If a non-reviewer submits a Pull Request it won't trigger CI pipelines by default until a reviewer adds an `/ok-to-test` comment on the Pull Request.

If you have public git repositories this also avoids the security issue of a non-approver submitting a Pull Request to change the pipeline to email them your security credentials in the CI pipeline ;)

## How do I configure multiple approvers

You may want to use multiple people to approve pull requests. e.g. to approve promotion Pull Requests on your Production cluster git repository

If so you could let github perform the approval and auto-merge for you.

You can then use the `review_approved_required` property in the `Scheduler` to disable keeper from trying to automatically merge pull requests.

The version stream comes with a scheduler configured for this called [environment-review-required.yaml](https://github.com/jenkins-x/jx3-versions/blob/master/schedulers/environment-review-required.yaml) so just modify your `.jx/gitops/source-config.yaml` file to specify `scheduler: environment-review-required` for the repository in question like this:

```yaml
apiVersion: gitops.jenkins-x.io/v1alpha1
kind: SourceConfig
metadata:
  creationTimestamp: null
spec:
  groups:
  - owner: myorg
    provider: https://github.com
    providerKind: github
    repositories:
    - name: some-env-repo
      scheduler: environment-review-required
    scheduler: in-repo
```
