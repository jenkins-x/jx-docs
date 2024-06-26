---
title: jx verify install
linktitle: install
type: docs
description: "Verifies the installation is ready"
aliases:
  - jx-verify_install
---

### Usage

```
jx verify install
```

### Synopsis

Verifies the installation is ready

### Examples

  ```bash
  # populate the ingress domain if not using a configured 'ingress.domain' setting
  jx verify install%!(EXTRA string=jx-verify)

  ```
### Options

```
  -b, --batch-mode               Runs in batch mode without prompting for user input
  -h, --help                     help for install
      --include-build            Include build pods
      --log-level string         Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string         if not specified uses the default namespace
  -w, --pod-wait-time duration   The default wait time to wait for the pods to be ready (default 2m0s)
  -p, --poll duration            The period between polls (default 10s)
  -l, --selector string          Custom selector (label query) for pods
      --verbose                  Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-verify](https://github.com/jenkins-x-plugins/jx-verify)
