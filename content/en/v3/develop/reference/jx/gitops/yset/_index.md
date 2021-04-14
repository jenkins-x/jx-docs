---
title: jx gitops yset
linktitle: yset
type: docs
description: "Modifies a value in a YAML file at a given path"
aliases:
  - jx-gitops_yset
---

## jx gitops yset

Modifies a value in a YAML file at a given path

### Usage

```
jx gitops yset
```

### Synopsis

Modifies one or more yaml files using a path expression

### Examples

  ```bash
  # sets the foo.bar=abc in the file foo.yaml
  jx gitops yset --file foo.yaml --path foo.bar --value abc%!(EXTRA string=jx-gitops, string=jx-gitops)

  ```
### Options

```
  -f, --file stringArray   the file(s) to process
  -h, --help               help for yset
  -p, --path string        the path expression to modify (separated by dots)
  -v, --value string       the value to modify
```

