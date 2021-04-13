---
title: jx gitops requirement merge
linktitle: merge
type: docs
description: "Merges values from the given file to the local jx-requirements.yml file"
aliases:
  - jx-gitops_requirement_merge
---

## jx gitops requirement merge

Merges values from the given file to the local jx-requirements.yml file

### Usage

```
jx gitops requirement merge
```

### Synopsis

Merges values from the given file to the local jx-requirements.yml file
  
This lets you take requirements from, say, the output of a terraform plan and merge with any other changes inside your GitOps repository

### Examples

  ```bash
  # merge requirements from a file
  jx-gitops requirements merge -f /tmp/jx-requirements.yml
  
  # merge requirements from a ConfigMap called 'terraform-jx-requirements' in the default namespace
  jx-gitops requirements merge

  ```
### Options

```
  -c, --configmap string   the name of the ConfigMap to find the requirements to merge if not specifying a requirements file via --file (default "terraform-jx-requirements")
  -d, --dir string         the source directory to merge changes into (default ".")
  -f, --file string        the requirements file to merge into the source directory
  -h, --help               help for merge
      --namespace string   the namespace used to find the ConfigMap if using the ConfigMap mode (default "default")
      --retries int        Specify the number of times the command should be reattempted on failure (default 3)
```

