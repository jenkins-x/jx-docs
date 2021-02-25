---
title: Git
linktitle: Git
type: docs
description: Changing your git provider
weight: 80
---


Jenkins X supports a number of different Git providers. You can specify the Git provider you wish to use and the organisation to use for the Git providers for each environment in your [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements)

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
```

### Bitbucket Server

For this specify the URL of the `gitServer` and `gitKind: bitbucketserver`.

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
```

### Bitbucket Cloud

For this specify`gitKind: bitbucketcloud`. 

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
```

### GitLab

For this specify the URL of the `gitServer` and `gitKind: gitlab`.

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
```
