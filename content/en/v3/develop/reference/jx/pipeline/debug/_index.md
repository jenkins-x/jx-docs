---
title: jx pipeline debug
linktitle: debug
type: docs
description: "Add or remove pipeline breakpoints for debugging pipeline steps ***Aliases**: bp,breakpoint*"
aliases:
  - jx-pipeline_debug
---

### Usage

```
jx pipeline debug
```

### Synopsis

Add or remove pipeline breakpoints for debugging pipeline steps.

### Examples

  ```bash
  # add or remove a breakpoint
  jx pipeline breakpoint

  ```
### Options

```
  -b, --batch-mode                Runs in batch mode without prompting for user input
  -p, --breakpoints stringArray   The breakpoint names to use when creating a new breakpoint (default [onFailure])
  -h, --help                      help for debug
      --log-level string          Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string          The kubernetes namespace to use. If not specified the default namespace is used
      --verbose                   Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
