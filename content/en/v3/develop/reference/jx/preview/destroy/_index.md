---
title: jx preview destroy
linktitle: destroy
type: docs
description: "Destroys a preview environment ***Aliases**: delete,remove*"
aliases:
  - jx-preview_destroy
---

### Usage

```
jx preview destroy
```

### Synopsis

Destroys a preview environment

### Examples

  ```bash
  # destroys a preview environment
  jx-preview destroy jx-myorg-myapp-pr-4

  ```
### Options

```
      --all             Select all the previews that match filter by default
      --dir string      The directory where to run the delete preview command - a git clone will be done on a temporary jx-git-xxx directory if this parameter is empty
      --fail-on-helm    If enabled do not try to remove the namespace or Preview resource if we fail to destroy helmfile resources
      --filter string   The filter to use to find previews to delete
  -h, --help            help for destroy
```



### Source

[jenkins-x-plugins/jx-preview](https://github.com/jenkins-x-plugins/jx-preview)
