---
title: jx secret export
linktitle: export
type: docs
description: "Exports the current populated values to a YAML file"
aliases:
  - jx-secret_export
---

### Usage

```
jx secret export
```

### Synopsis

Exports the current populated values to a YAML file

### Examples

  ```bash
  jx-secret export

  ```
### Options

```
  -c, --console       display the secrets on the console instead of a file
  -f, --file string   the file to use to save the secrets to
  -h, --help          help for export
  -n, --ns string     the namespace to filter the ExternalSecret resources
```



### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
