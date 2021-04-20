---
title: jx verify pods
linktitle: pods
type: docs
description: "Verifies that all pods start OK in the current namespace; killing any Pods which have ErrImagePull ***Aliases**: pod*"
aliases:
  - jx-verify_pods
---

### Usage

```
jx verify pods
```

### Synopsis

Verifies that all pods start OK in the current namespace; killing any Pods which have ErrImagePul

### Examples

  ```bash
  # populate the pods don't have missing images
  jx verify pods%!(EXTRA string=jx-verify)

  ```
### Options

```
  -c, --count int          The minimum Ready pod count required matching the selector before terminating (default 2)
  -h, --help               help for pods
  -n, --namespace string   The namespace to look for events
  -s, --selector string    The selector to query for all pods being running
```



### Source

[jenkins-x-plugins/jx-verify](https://github.com/jenkins-x-plugins/jx-verify)
