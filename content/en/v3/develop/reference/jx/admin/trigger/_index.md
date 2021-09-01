---
title: jx admin trigger
linktitle: trigger
type: docs
description: "triggers the latest boot Job to run again ***Aliases**: rerun*"
aliases:
  - jx-admin_trigger
---

### Usage

```
jx admin trigger
```

### Synopsis

Triggers the latest boot Job to run again

### Examples

* trigger the boot job again
  
  ```bash
  jx-admin trigger
  ```

### Options

```
  -b, --batch-mode          Runs in batch mode without prompting for user input
      --commit-sha string   the git commit SHA to filter jobs by
  -h, --help                help for trigger
      --log-level string    Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string    the namespace where the boot jobs run. If not specified it will look in: jx-git-operator and jx
  -s, --selector string     the selector of the boot Job pods (default "app=jx-boot")
      --verbose             Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-admin](https://github.com/jenkins-x-plugins/jx-admin)
