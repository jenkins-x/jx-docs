---
title: jx secret vault wait
linktitle: wait
type: docs
description: "Waits for vault to be ready for use"
aliases:
  - jx-secret_vault_wait
---

## jx secret vault wait

Waits for vault to be ready for use

### Usage

```
jx secret vault wait
```

### Synopsis

Waits for vault to be ready for use

### Examples

  ```bash
  jx-secret vault wait

  ```
### Options

```
  -d, --duration duration   the maximum time period to wait for vault to be ready (default 5m0s)
  -h, --help                help for wait
  -n, --ns string           the namespace where vault is running (default "jx-vault")
  -p, --pod string          the name of the vault pod which needs to be running before the port forward can take place (default "vault-0")
      --poll duration       the polling period to check if the secrets are valid (default 2s)
```

