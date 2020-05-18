---
title: Lighthouse
linktitle: Lighthouse
description: lightweight webhook and [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) handling for multiple git providers
weight: 41
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/lighthouse
  - /architecture/lighthouse
---

[Prow](/docs/reference/components/prow/) is a great way to do [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) with [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) though unfortunately its only supported for GitHub.com and is quite heavy and complex. To work around this we've created [Lighthouse](https://github.com/jenkins-x/lighthouse).

[Lighthouse](https://github.com/jenkins-x/lighthouse) is a lightweight [ChatOps](/docs/resources/guides/using-jx/faq/chatops/) based webhook handler which can trigger [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) on webhooks from multiple git providers such as: GitHub, GitHub Enterprise, BitBucket Server, BitBucket Cloud, GitLab, Gogs and Gitea.

Currently Lighthouse is focussed on using [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with tekton though longer term it could be reused with tekton orchestrating Jenkins pipelines via the [Custom Jenkins Server App](/docs/resources/guides/managing-jx/common-tasks/custom-jenkins/)

## Features

Currently Lighthouse supports the common [prow plugins](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow/plugins) and handles push webhooks to branches & Pull Request webhooks to then trigger Jenkins X pipelines.

Lighthouse uses the same `config.yaml` and `plugins.yaml` file structure from Prow so that we can easily migrate from `prow <-> lighthouse`.

This also means we get to reuse the clean generation of Prow configuration from the `SourceRepository`, `SourceRepositoryGroup` and `Scheduler` CRDs integrated into [jx boot](/docs/reference/boot/). e.g. here's the [default scheduler configuration](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/templates/default-scheduler.yaml) which is used for any project imported into your Jenkins X cluster; without you having to touch the actual prow configuration files. You can create many schedulers and associate them to different `SourceRepository` resources.

We can also reuse Prow's capability of defining many separate pipelines on a repository (for PRs or releases) via having separate `contexts`. Then on a Pull Request we can use `/test something` or `/test all` to trigger pipelines and use the `/ok-to-test` and `/approve` or `/lgtm` commands


## Using Lighthouse with boot

We have integrated [lighthouse](https://github.com/jenkins-x/lighthouse) into [jx boot](/docs/reference/boot/). To switch to `lighthouse` from `prow` you need to add something like this to your `jx-requirements.yml` file:

```yaml
webhook: lighthouse
```

Once you have modified your `jx-requirements.yml` file you just need to run `jx boot`.

If you are using something else other than github.com as your git provider you will also require some extra YAML to configure the git provider. Here are some examples:

## GitHub Enterprise

```yaml
cluster:
  provider: gke
  zone: europe-west1-c
  environmentGitOwner: myowner
  gitKind: github
  gitName: ghe
  gitServer: https://my-github.com
webhook: lighthouse
```

## BitBucket Server

```yaml
cluster:
  provider: gke
  environmentGitOwner: myowner
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://my-bitbucket-server.com
webhook: lighthouse
```

## GitLab

```yaml
cluster:
  provider: gke
  environmentGitOwner: myowner
  gitKind: gitlab
  gitName: gitlab
  gitServer: https://my-gitlab-server.com
webhook: lighthouse
```

## Comparisons to Prow

Lighthouse is very prow-like and currently reuses the Prow plugin source code and a bunch of [plugins from prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow/plugins)

Its got a few differences though:

* rather than be GitHub specific lighthouse uses [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) so it can support any git provider
* lighthouse is mostly like `hook` from Prow; an auto scaling webhook handler - to keep the footprint small. This also means if anything goes wrong handling webhooks you only have one pod to look into.
* lighthouse is also very light. In Jenkins X we have about 10 pods related to prow; with lighthouse we have just 1 along with the tekton controller itself. That one lighthouse pod could easily be auto scaled too from 0 to many as it starts up very quickly.
* lighthouse focuses purely on Tekton pipelines so it does not require a `ProwJob` CRD; instead a push webhook to a release or pull request branch can trigger zero to many `PipelineRun` CRDs instead



## Porting Prow commands

If there are any prow commands you want which we've not yet ported over, its relatively easy to port prow plugins.

We've reused the prow plugin code and configuration code; so its mostly a case of switching imports of `k8s.io/test-infra/prow` to `github.com/jenkins-x/lighthouse/pkg/prow` - then modifying the github client structs from, say, `github.PullRequest` to `scm.PullRequest`.

Most of the github structs map 1-1 with the [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) equivalents (e.g. Issue, Commit, PullRequest) though the go-scm API does tend to return slices to pointers to resources by default. There are some naming differences at different parts of the API though.

e.g. compare the `githubClient` API for the [prow lgtm](https://github.com/kubernetes/test-infra/blob/344024d30165cda6f4691cc178f25b16f1a1f5af/prow/plugins/lgtm/lgtm.go#L134-L150) versus the [lighthouse lgtm](https://github.com/jenkins-x/lighthouse/blob/master/pkg/prow/plugins/lgtm/lgtm.go#L135-L150).

All the prow plugin related code lives in the [pkg/prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/prow) tree of packages. Mostly all we've done is switch to using [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) and switch out the current prow agents and instead use a single `tekton` agent using the [PlumberClient](https://github.com/jenkins-x/lighthouse/blob/master/pkg/plumber/interface.go#L3-L6) to trigger pipelines.


## Environment variables

The following environment variables are used:

| Name  |  Description |
| ------------- | ------------- |
| `GIT_KIND` | the kind of git server: `github, bitbucket, gitea, stash` |
| `GIT_SERVER` | the URL of the server if not using the public hosted git providers: https://github.com or https://bitbucket.org https://gitlab.com |
| `GIT_USER` | the git user (bot name) to use on git operations |
| `GIT_TOKEN` | the git token to perform operations on git (add comments, labels etc) |
| `HMAC_TOKEN` | the token sent from the git provider in webhooks |
| `JX_SERVICE_ACCOUNT` | the service account to use for generated pipelines |
