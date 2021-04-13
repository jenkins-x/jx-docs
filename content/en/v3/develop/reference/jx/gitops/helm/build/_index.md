---
title: jx gitops helm build
linktitle: build
type: docs
description: "Builds and lints any helm charts"
aliases:
  - jx-gitops_helm_build
---

## jx gitops helm build

Builds and lints any helm charts

### Usage

```
jx gitops helm build
```

### Synopsis

Builds and lints any helm charts

### Examples

  ```bash
  # generates the resources from a helm chart
  jx-gitops step helm template

  ```
### Options

```
  -n, --binary string       specifies the helm binary location to use. If not specified defaults to 'helm' on the $PATH
  -c, --charts-dir string   the directory to look for helm charts to release (default "charts")
  -h, --help                help for build
      --use-helm-plugin     uses the jx binary plugin for helm rather than whatever helm is on the $PATH
```

