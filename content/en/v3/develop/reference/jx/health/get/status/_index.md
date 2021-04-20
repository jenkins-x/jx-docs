---
title: jx health get status
linktitle: status
type: docs
description: "Gets health statuses ***Aliases**: statuses*"
aliases:
  - jx-health_get_status
---

### Usage

```
jx health get status
```

### Synopsis

Prints health statuses in a table

### Examples

  ```bash
  # prints all health statuses for the current namespace in a table
  jx-health get status
  
  # prints all health statuses for a specific namespace
  jx-health get status --namespace
  
  # prints all health statuses for all accessible namespace
  jx-health get status --all-namespaces
  
  # watch health statuses
  jx-health get status --watch

  ```
### Options

```
  -A, --all-namespaces     if present, list the requested object(s) across all namespaces.
                           Namespace in current context is ignored even if specified with --namespace.
  -h, --help               help for status
      --info               provide information links for checks
  -n, --namespace string   namespace to get status checks, defaults to current namespace
  -w, --watch              after listing/getting the requested object, watch for changes
```



### Source

[jenkins-x-plugins/jx-health](https://github.com/jenkins-x-plugins/jx-health)
