---
title: jx admin log
linktitle: log
type: docs
description: "views the boot Job logs in the cluster ***Aliases**: logs*"
aliases:
  - jx-admin_log
---

### Usage

```
jx admin log
```

### Synopsis

Views the boot Job logs in the cluster

### Examples

  * views the current boot logs
  
  ```bash
  jx-admin log
  ```

### Options

```
  -b, --batch-mode                     Runs in batch mode without prompting for user input
      --commit-sha string              the git commit SHA of the git repository to query the boot Job for
  -c, --container string               the name of the container in the boot Job to log (default "job")
  -d, --duration duration              how long to wait for a Job to be active and a Pod to be ready (default 30m0s)
  -g, --git-operator-selector string   the selector of the git operator pod (default "app=jx-git-operator")
  -h, --help                           help for log
      --log-level string               Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string               the namespace where the boot jobs run. If not specified it will look in: jx-git-operator and jx
      --poll duration                  duration between polls for an active Job or Pod (default 1s)
  -s, --selector string                the selector of the boot Job pods (default "app=jx-boot")
      --sha-mode                       if --commit-sha is not specified then default the git commit SHA from $ and fail if it could not be found
      --verbose                        Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -w, --wait                           wait for the next active Job to start
```



### Source

[jenkins-x-plugins/jx-admin](https://github.com/jenkins-x-plugins/jx-admin)
