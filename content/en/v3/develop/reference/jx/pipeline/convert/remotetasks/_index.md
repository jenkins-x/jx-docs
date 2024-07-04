---
title: jx pipeline convert remotetasks
linktitle: remotetasks
type: docs
description: "Converts the pipelines to use native Tekton syntax"
aliases:
  - jx-pipeline_convert_remotetasks
---

### Usage

```
jx pipeline convert remotetasks
```

### Synopsis

Converts the pipelines from the 'image: uses:sourceURI' mechanism to native Tekton. 

Existing PipelineRuns are converted into either a new PipelineRun, that uses the Tekton git resolver to pull tasks from the sourceURI, or to explicit Tasks based on whether existing PipelineRun has a parent in it's in it's stepTemplate. 

Existing Tasks have the default lighthouse params/envVars (PULL NUMBER, REPO NAME etc) appended to them. 

As existing steps are being migrated to tasks a workspace volume needs to be mounted to the tasks. By default the size of the workspace is calculated based on the size of the repository + a 300Mi buffer. This can be overridden by setting --calculate-workspace-volume=false & --workspace-volume= <size>(if no value is given it defaults to 1Gi)

### Examples

  ```bash
  # Convert a repository created using uses: syntax to use the new native Tekton syntax
  jx pipeline convert remotetasks

  ```
### Options

```
  -b, --batch-mode                   Runs in batch mode without prompting for user input
  -c, --calculate-workspace-volume   Calculate the workspace volume size based on the size of the repository + a 300Mi buffer. This will override the value set in --workspace-volume (default true)
  -d, --dir string                   The directory to look for the pipeline files. Defaults to the current directory (default ".")
  -h, --help                         help for remotetasks
      --log-level string             Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -s, --sha string                   Overrides the SHA taken from "image:uses:" with the given value
      --verbose                      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -v, --workspace-volume string      The size of the workspace volume that backs the pipelines.
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
