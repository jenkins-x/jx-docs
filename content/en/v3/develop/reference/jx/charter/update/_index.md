---
title: jx charter update
linktitle: update
type: docs
description: "Creates or Updates helm Chart CRDs from the helm Secrets"
aliases:
  - jx-charter_update
---

### Usage

```
jx charter update
```

### Synopsis

Creates or Updates helm Chart CRDs from the helm Secrets

### Examples

  ```bash
  # creates or updates any missing helm Chart resources from the helm Secrets
  jx-charter update

  ```
### Options

```
  -b, --batch-mode         Runs in batch mode without prompting for user input
  -h, --help               help for update
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string   The kubernetes namespace to look for helm Secrets
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-charter](https://github.com/jenkins-x-plugins/jx-charter)
