---
title: jx secret vault shell
linktitle: shell
type: docs
description: "Runs a shell so you can access the vault in a kubernetes cluster ***Aliases**: sh*"
aliases:
  - jx-secret_vault_shell
---

### Usage

```
jx secret vault shell
```

### Synopsis

Runs a shell so you can access the vault in a kubernetes cluster

### Examples

  ```bash
  jx-secret vault shell
  
  jx-secret vault shell bash
  
  jx-secret vault shell -- bash -i

  ```
### Options

```
  -d, --duration duration   the maximum time period to wait for vault to be ready (default 5m0s)
  -h, --help                help for shell
  -n, --ns string           the namespace where vault is running (default "jx-vault")
  -p, --pod string          the name of the vault pod which needs to be running before the port forward can take place (default "vault-0")
      --poll duration       the polling period to check if the secrets are valid (default 2s)
```



### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
