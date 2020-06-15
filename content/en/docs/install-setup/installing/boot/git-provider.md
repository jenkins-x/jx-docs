---
title: Git Provider
linktitle: Git Provider
description: Configure Git providers
keywords: [git]
weight: 40
---

## Git

Jenkins X supports a number of different Git providers.
You can specify the Git provider you wish to use and the organisation to use for the Git providers for each environment in your [jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) file.

### GitHub

This is the default Git provider if you don't specify one.

```yaml
cluster:
  environmentGitOwner: myorg
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### GitHub Enterprise

The configuration is similar to the above but you need to specify the URL of the `gitServer` (if it differs from https://github.com) and `gitKind: github`

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: github
  gitName: ghe
  gitServer: https://github.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Server

For Bitbucket Server specify the URL of the `gitServer` and `gitKind: bitbucketserver`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [Lighthouse webhook](/docs/install-setup/installing/boot/webhooks/#lighthouse) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://bitbucket.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Cloud

For Bitbucket Cloud specify`gitKind: bitbucketcloud`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [lighthouse webhook](/docs/install-setup/installing/boot/webhooks/#lighthouse) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
  gitName: bc
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### GitLab

For GitLab specify the URL of the `gitServer` and `gitKind: gitlab`.
If you want to use [Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) with [Tekton](https://tekton.dev/) then make sure you specify the [Lighthouse webhook](/docs/install-setup/installing/boot/webhooks/#lighthouse) via `webhook: lighthouse`.

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: gitlab
  gitName: gl
  gitServer: https://gitlab.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```
