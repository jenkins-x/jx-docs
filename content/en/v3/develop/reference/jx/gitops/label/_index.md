---
title: jx gitops label
linktitle: label
type: docs
description: "Updates all kubernetes resources in the given directory tree to add/override the given label"
aliases:
  - jx-gitops_label
---

### Usage

```
jx gitops label
```

### Synopsis

Updates all kubernetes resources in the given directory tree to add/override the given label

### Examples

  ```bash
  # updates recursively labels all resources in the current directory
  jx-gitops label mylabel=cheese another=thing
  # updates recursively all resources
  jx-gitops label --dir myresource-dir foo=bar

  ```

### Options

```
      --dir string                the directory to recursively look for the *.yaml or *.yml files (default ".")
  -h, --help                      help for label
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. -s app=pusher-wave,heritage=Helm (default [])
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
