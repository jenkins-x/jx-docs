---
title: jx secret wait
linktitle: wait
type: docs
description: "Waits for the mandatory Secrets to be populated from their External Secrets"
aliases:
  - jx-secret_wait
---

### Usage

```
jx secret wait
```

### Synopsis

Waits for the mandatory Secrets to be populated from their External Secrets

### Examples

  ```bash
  jx-secret wait

  ```
### Options

```
  -h, --help               help for wait
  -n, --ns string          the namespace to filter the ExternalSecret resources
  -p, --poll duration      the polling period to check if the secrets are valid (default 2s)
  -t, --timeout duration   the maximum amount of time to wait for the secrets to be valid (default 30m0s)
```



### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
