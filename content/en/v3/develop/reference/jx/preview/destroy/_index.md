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
      --all               Select all the filters by default to remove
      --fail-on-helm      If enabled do not try to remove the namespace or Preview resource if we fail to destroy helmfile resources
  -f, --file string       Preview helmfile.yaml path to use. If not specified it is discovered in preview/helmfile.yaml and created from a template if needed
      --filter string     The filter to use to find a preview to delete
      --git-user string   The user name to git clone the environment repository
  -h, --help              help for destroy
```

### Source

[jenkins-x-plugins/jx-preview](https://github.com/jenkins-x-plugins/jx-preview)
