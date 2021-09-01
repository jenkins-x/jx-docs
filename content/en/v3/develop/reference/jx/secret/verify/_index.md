---
title: jx secret verify
linktitle: verify
type: docs
description: "Verifies that the ExternalSecret resources have the required properties populated in the underlying secret storage ***Aliases**: get*"
aliases:
  - jx-secret_verify
---

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
  -b, --batch-mode         Runs in batch mode without prompting for user input
  -f, --filter string      the filter to filter on ExternalSecret names
  -h, --help               help for verify
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string   the namespace to filter the ExternalSecret resources
  -s, --source string      the source location for the ExternalSecrets, valid values include filesystem or kubernetes (default "kubernetes")
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-secret](https://github.com/jenkins-x-plugins/jx-secret)
