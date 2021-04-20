---
title: jx gitops apply
linktitle: apply
type: docs
description: "Performs a GitOps regeneration and apply on a cluster git repository"
aliases:
  - jx-gitops_apply
---

### Usage

```
jx gitops apply
```

### Synopsis

Performs a gitops regeneration and apply on a cluster git repository 

If the last commit was a merge from a pull request the regeneration is skipped. 

Also the process detects if an ingress has changed (or similar changes) and retriggers another regeneration which typically is only required when installing for the first time or if no explicit domain name is being used and the LoadBalancer service has been removed.

### Examples

  ```bash
  # performs a regeneration and apply
  jx-gitops apply

  ```
### Options

```
  -d, --dir string     the directory to the git and make commands (default ".")
  -h, --help           help for apply
      --pull-request   specifies to apply the pull request contents into the PR branch
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
