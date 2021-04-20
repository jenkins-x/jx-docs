---
title: jx gitops copy
linktitle: copy
type: docs
description: "Copies resources (by default confimaps) with the given selector or name from a source namespace to a destination namespace"
aliases:
  - jx-gitops_copy
---

### Usage

```
jx gitops copy
```

### Synopsis

Copies kubernetes resources (by default confimaps) from a namespace to the current namespace

### Examples

  ```bash
  # copies the config map with named beer to a namespace
  jx-gitops copy --name beer --to=foo
  
  # copies config maps with a selector to a namespace
  jx-gitops copy -l mylabel=something --to=foo
  
  # copies resources matching a selector and kind
  jx-gitops copy --kind ingresses -l mylabel=something --to=foo

  ```
### Options

```
      --create-namespace   create the to Namespace if it does not already exist
  -g, --group string       the API group such as 'apps' for Deployemnts
  -h, --help               help for copy
  -k, --kind string        the kind name (default "configmaps")
      --name string        the name of the resource to copy instead of a selector
  -n, --ns string          the namespace to find the resources to copy. Defaults to the current namespace
  -l, --selector string    the label selector to find the resources to copy
  -t, --to string          the namespace to copy the secrets to
      --version string     the API version of the resources to copy (default "v1")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
