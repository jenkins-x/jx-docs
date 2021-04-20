---
title: jx pipeline wait
linktitle: wait
type: docs
description: "Waits for a pipeline to be imported and activated by the boot Job ***Aliases**: build,run*"
aliases:
  - jx-pipeline_wait
---

### Usage

```
jx pipeline wait
```

### Synopsis

Waits for a pipeline to be imported and activated by the boot Job

### Examples

  ```bash
  # Waits for the pipeline to be setup for the given repository
  jx pipeline wait --owner myorg --repo myrepo

  ```
### Options

```
  -b, --batch-mode             Runs in batch mode without prompting for user input
      --configmap string       The name of the Lighthouse ConfigMap to find the trigger configurations (default "config")
      --duration duration      Maximum duration to wait for one or more matching triggers to be setup in Lighthouse. Useful for when a new repository is being imported via GitOps (default 20m0s)
  -h, --help                   help for wait
      --log-level string       Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string       The namespace to look for the lighthouse configuration. Defaults to the current namespace
  -o, --owner string           The owner name to wait for
      --poll-period duration   Poll period when waiting for one or more matching triggers to be setup in Lighthouse. Useful for when a new repository is being imported via GitOps (default 2s)
  -r, --repo string            The repository name o wait for
      --verbose                Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
