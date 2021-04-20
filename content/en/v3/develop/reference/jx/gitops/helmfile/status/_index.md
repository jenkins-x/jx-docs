---
title: jx gitops helmfile status
linktitle: status
type: docs
description: "Updates the git deployment status after a release"
aliases:
  - jx-gitops_helmfile_status
---

### Usage

```
jx gitops helmfile status
```

### Synopsis

Updates the git deployment status after a release

### Examples

  ```bash
  # update the status in git after a release
  jx-gitops helmfile status

  ```
### Options

```
  -d, --dir string   the directory that contains the content (default ".")
  -f, --fail         if enabled then fail the boot pipeline if we cannot report the deployment status
  -h, --help         help for status
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
