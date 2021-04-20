---
title: jx pipeline get
linktitle: get
type: docs
description: "Display one or more pipelines ***Aliases**: list,ls*"
aliases:
  - jx-pipeline_get
---

### Usage

```
jx pipeline get
```

### Synopsis

Display one or more pipelines.

### Examples

  ```bash
  # list all pipelines
  jx pipeline get

  ```
### Options

```
  -b, --batch-mode         Runs in batch mode without prompting for user input
      --configmap string   The name of the Lighthouse ConfigMap to find the trigger configurations (default "config")
  -f, --format string      The output format such as 'yaml' or 'json'
  -h, --help               help for get
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string   The kubernetes namespace to use. If not specified the default namespace is used
      --postsubmit         Views the available lighthouse postsubmit triggers rather than just the current PipelineRuns
      --presubmit          Views the available lighthouse presubmit triggers rather than just the current PipelineRuns
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
