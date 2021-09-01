---
title: jx preview gc
linktitle: gc
type: docs
description: "Garbage collect Preview environments for closed or merged Pull Requests"
aliases:
  - jx-preview_gc
---

### Usage

```
jx preview gc
```

### Synopsis

Garbage collect Jenkins X preview environments.

If a pull request is merged or closed the associated preview environment will be deleted.

### Examples

  ```bash
  # garbage collect previews
  %s gc

  ```

### Options

```
  -h, --help   help for gc
```

### Source

[jenkins-x-plugins/jx-preview](https://github.com/jenkins-x-plugins/jx-preview)
