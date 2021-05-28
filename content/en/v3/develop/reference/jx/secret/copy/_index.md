---
title: jx secret copy
linktitle: copy
type: docs
description: "Copies secrets with the given selector or name to a destination namespace"
aliases:
  - jx-secret_copy
---

### Usage

```
jx secret copy
```

### Synopsis

Copies secrets with the given selector or name to a destination namespace

### Examples

  ```bash
  # copy secrets by label from the current namespace
  jx secret copy --selector mylabel=cheese --to my-preview-ns
  
  # copy secrets by name from the current namespace
  jx secret copy --name my-awesome-secret --to my-preview-ns%!(EXTRA string=jx-secret)

  ```
### Options

```
      --create-namespace    create the to Namespace if it does not already exist
  -h, --help                help for copy
      --ignore-missing-to   ignore this command if the target namespace does not exist
      --name string         the name of the Secret to copy
  -n, --ns string           the namespace to filter the Secret resources
  -l, --selector string     the label selector to find the secrets to copy
  -t, --to string           the namespace to copy the secrets to
```



### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
