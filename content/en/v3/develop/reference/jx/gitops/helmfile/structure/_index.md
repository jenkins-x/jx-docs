---
title: jx gitops helmfile structure
linktitle: structure
type: docs
description: "Runs 'helmfile structure' on the helmfile in specified directory which will split in to multiple helmfiles based around namespace"
aliases:
  - jx-gitops_helmfile_structure
---

### Usage

```
jx gitops helmfile structure
```

### Synopsis

Runs 'helmfile structure' on the helmfile in specified directory which will split in to multiple helmfiles based around namespace

### Examples

  ```bash
  # splits the helmfile.yaml into separate files for each namespace
  jx-gitops helmfile structure --dir /path/to/gitops/repo

  ```
### Options

```
  -d, --dir string   the directory to run the commands inside (default ".")
  -h, --help         help for structure
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
