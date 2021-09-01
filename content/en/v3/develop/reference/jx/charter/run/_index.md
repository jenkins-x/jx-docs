---
title: jx charter run
linktitle: run
type: docs
description: "Runs the charter controller which watches helm Secrets and creates helm Chart CRDs"
aliases:
  - jx-charter_run
---

### Usage

```
jx charter run
```

### Synopsis

Runs the charter controller which watches helm Secrets and creates helm Chart CRDs

### Examples

  ```bash
  # watch for helm Secret resources and create/update the associated Chart CRDs
  jx-charter run

  ```

### Options

```
  -b, --batch-mode                 Runs in batch mode without prompting for user input
  -h, --help                       help for run
      --log-level string           Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string           The kubernetes namespace to watch for helm Secrets
      --port string                port the health endpoint should listen on (default "8080")
      --resync-interval duration   resync interval between full re-list operations (default 1m0s)
      --verbose                    Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-charter](https://github.com/jenkins-x-plugins/jx-charter)
