---
title: jx secret vault portforward
linktitle: portforward
type: docs
description: "Runs a port forward process so you can access the vault in a kubernetes cluster ***Aliases**: portfwd,port-forward*"
aliases:
  - jx-secret_vault_portforward
---

## jx secret vault portforward

Runs a port forward process so you can access the vault in a kubernetes cluster

***Aliases**: portfwd,port-forward*

### Usage

```
jx secret vault portforward
```

### Synopsis

Runs a port forward process so you can access the vault in a kubernetes cluster

### Examples

  ```bash
  jx-secret vault portforward

  ```
### Options

```
  -d, --duration duration   the maximum time period to wait for vault to be ready (default 5m0s)
  -h, --help                help for portforward
  -n, --ns string           the namespace where vault is running (default "jx-vault")
  -p, --pod string          the name of the vault pod which needs to be running before the port forward can take place (default "vault-0")
      --poll duration       the polling period to check if the secrets are valid (default 2s)
```

