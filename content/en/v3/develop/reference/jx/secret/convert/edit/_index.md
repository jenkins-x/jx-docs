---
title: jx secret convert edit
linktitle: edit
type: docs
description: "Edits the local 'secret-mappings.yaml' file"
aliases:
  - jx-secret_convert_edit
---

## jx secret convert edit

Edits the local 'secret-mappings.yaml' file

### Usage

```
jx secret convert edit
```

### Synopsis

Edits the local 'secret-mappings.yaml' file

### Examples

  ```bash
  # edits the local 'secret-mappings.yaml' file
  jx-secret secretsmapping edit --gcp-project-id foo --cluster-name

  ```
### Options

```
      --dir string   base directory containing '.jx/secret/mapping/secret-mappings.yaml' file
  -h, --help         help for edit
```

