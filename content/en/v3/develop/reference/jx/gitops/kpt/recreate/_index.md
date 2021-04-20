---
title: jx gitops kpt recreate
linktitle: recreate
type: docs
description: "Recreates the kpt packages in the given directory"
aliases:
  - jx-gitops_kpt_recreate
---

### Usage

```
jx gitops kpt recreate
```

### Synopsis

Updates the kpt packages in the given directory

### Examples

  ```bash
  # updates the kpt of all the yaml resources in the given directory
  jx-gitops kpt --dir .

  ```
### Options

```
  -d, --dir string       the directory to recursively look for the *.yaml or *.yml files (default ".")
      --dry-run          just output the commands to be executed
  -h, --help             help for recreate
  -i, --ignore-errors    if enabled we continue processing on kpt errors
  -o, --out-dir string   the output directory to generate the output
      --version string   if specified overrides the versions used in the kpt packages (e.g. to 'master')
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
