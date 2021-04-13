---
title: jx secret verify
linktitle: verify
type: docs
description: "Verifies that the ExternalSecret resources have the required properties populated in the underlying secret storage ***Aliases**: get*"
aliases:
  - jx-secret_verify
---

## jx secret verify

Verifies that the ExternalSecret resources have the required properties populated in the underlying secret storage

***Aliases**: get*

### Usage

```
jx secret verify
```

### Synopsis

Verifies that the ExternalSecret resources have the required properties populated in the underlying secret storage

### Examples

  ```bash
  jx-secret verify

  ```
### Options

```
  -f, --filter string      the filter to filter on ExternalSecret names
  -h, --help               help for verify
  -n, --namespace string   the namespace to filter the ExternalSecret resources
  -s, --source string      the source location for the ExternalSecrets, valid values include filesystem or kubernetes (default "kubernetes")
```

