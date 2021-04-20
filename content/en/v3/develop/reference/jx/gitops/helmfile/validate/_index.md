---
title: jx gitops helmfile validate
linktitle: validate
type: docs
description: "Validates helmfile.yaml against a jx canonical tree of helmfiles"
aliases:
  - jx-gitops_helmfile_validate
---

### Usage

```
jx gitops helmfile validate
```

### Synopsis

Parses a helmfile and any nested helmfiles and validates they conform to a canonical directory structure for jx based around namespace

### Examples

  ```bash
  # Validates helmfile.yaml within the current directory
  jx-gitops helmfile validate%!(EXTRA string=jx-gitops)

  ```
### Options

```
  -d, --dir string        the directory that contains helmfile.yml (default ".")
      --helmfile string   the helmfile to template. Defaults to 'helmfile.yaml' in the directory
  -h, --help              help for validate
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
