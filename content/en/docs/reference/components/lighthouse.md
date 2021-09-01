---
title: Lighthouse
linktitle: Lighthouse
description: Lightweight webhook and [ChatOps](/docs/resources/faq/using/chatops/) handling for multiple Git providers
weight: 41
aliases:
  - /docs/resources/guides/managing-jx/common-tasks/lighthouse
  - /architecture/lighthouse
---

[Lighthouse](https://github.com/jenkins-x/lighthouse) is a lightweight [ChatOps](/docs/resources/faq/using/chatops/) based webhook handler which can trigger [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) on webhooks from multiple git providers such as: GitHub, GitHub Enterprise, GitLab, and BitBucket Server. It is a successor to [Prow](/docs/reference/components/prow/), providing support for more SCM providers, a smaller footprint, and an easier path to adding features going forward. Lighthouse has been the default webhook handler in Jenkins X since early May, 2020.

Currently Lighthouse is focused on using [Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with tekton.

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

Lighthouse is based on a fork of Prow's source code, including most of the built-in [plugins from prow](https://github.com/jenkins-x/lighthouse/tree/master/pkg/plugins)

The most noteworthy differences are:

* In order to support multiple SCM providers, Lighthouse uses [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) as an abstraction layer, allowing additional provider support to be implemented without needing significant changes within Lighthouse itself.
* Lighthouse has less moving parts and potential configuration than Prow, resulting in only four pods being run for Lighthouse: two webhook receiver replicas, a Keeper pod, which handles deciding when to merge and actually merging pull requests, and a Foghorn pod, which handles reporting commit statuses back to the provider.

## Porting Prow commands

If there are any Prow commands you want which we've not yet ported over, it's relatively easy to port Prow plugins.

We've reused the Prow plugin code and configuration code as the basis for Lighthouse; so its mostly a case of switching imports of `k8s.io/test-infra/prow` to `github.com/jenkins-x/lighthouse` - then modifying the github client structs from, say, `github.PullRequest` to `scm.PullRequest`.

Most of the GitHub structs map 1-1 with the [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) equivalents (e.g. Issue, Commit, PullRequest) though the go-scm API does tend to return slices to pointers to resources by default. There are some naming differences at different parts of the API though.

e.g. compare the `githubClient` API for the [Prow lgtm](https://github.com/kubernetes/test-infra/blob/344024d30165cda6f4691cc178f25b16f1a1f5af/prow/plugins/lgtm/lgtm.go#L134-L150) versus the `scmProviderClient` API for the [Lighthouse lgtm](https://github.com/jenkins-x/lighthouse/blob/b2090082db828fb2d4c11095c5e59bf4a828c8de/pkg/plugins/lgtm/lgtm.go#L135-L151).

All the Prow-descended plugin related code lives in the [pkg/plugins](https://github.com/jenkins-x/lighthouse/tree/master/pkg/plugins) tree of packages. Mostly all we've done is switch to using [jenkins-x/go-scm](https://github.com/jenkins-x/go-scm) and switch out the current Prow agents and instead use a single `tekton` agent using the [PipelineLauncher](https://github.com/jenkins-x/lighthouse/blob/master/pkg/launcher/interface.go#L12) to trigger pipelines.

## Environment variables

The following environment variables are used:

| Name  |  Description |
| ------------- | ------------- |
| `GIT_KIND` | the kind of git server: `github, bitbucket, gitea, stash` |
| `GIT_SERVER` | the URL of the server if not using the public hosted git providers: <https://github.com> or <https://bitbucket.org> <https://gitlab.com> |
| `GIT_USER` | the git user (bot name) to use on git operations |
| `GIT_TOKEN` | the git token to perform operations on git (add comments, labels etc) |
| `HMAC_TOKEN` | the token sent from the git provider in webhooks |
| `JX_SERVICE_ACCOUNT` | the service account to use for generated pipelines |
