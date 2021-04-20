---
title: jx test gc
linktitle: gc
type: docs
description: "Garbage collects test resources"
aliases:
  - jx-test_gc
---

### Usage

```
jx test gc
```

### Synopsis

Garbage collects test resources

### Examples

  ```bash
  jx-test gc

  ```
### Options

```
  -d, --duration duration   The maximum age of a Terraform resource before it is garbage collected (default 2h0m0s)
  -h, --help                help for gc
  -n, --ns string           the namespace to query the Terraform resources
  -l, --selector string     the selector to find the Terraform resources to remove (default "kind=jx-test")
```



### Source

[jenkins-x-plugins/jx-test](https://github.com/jenkins-x-plugins/jx-test)
