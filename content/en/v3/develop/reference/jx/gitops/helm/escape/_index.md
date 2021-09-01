---
title: jx gitops helm escape
linktitle: escape
type: docs
description: "Escapes any {{ or }} characters in the YAML files so they can be included in a helm chart"
aliases:
  - jx-gitops_helm_escape
---

### Usage

```
jx gitops helm escape
```

### Synopsis

Escapes any {{ or }} characters in the YAML files so they can be included in a helm chart

### Examples

  ```bash
  # escapes any yaml files so they can be included in a helm chart
  jx-gitops helm escape --dir myyaml

  ```

### Options

```
  -d, --dir string   the directory to recursively look for the *.yaml or *.yml files (default ".")
  -h, --help         help for escape
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
