---
title: jx secret import
linktitle: import
type: docs
description: "Imports a YAML file of secret values"
aliases:
  - jx-secret_import
---

### Usage

```
jx secret import
```

### Synopsis

Imports a YAML of secret values into the underlying secret store

### Examples

  ```bash
  jx-secret import -f mysecrets.yaml

  ```
### Options

```
      --fail-on-unknown-key   should the command fail if a key from the YAML file is unknown
  -f, --file string           the name of the file to import
  -h, --help                  help for import
  -n, --ns string             the namespace to filter the ExternalSecret resources
```



### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
