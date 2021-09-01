---
title: jx pipeline set
linktitle: set
type: docs
description: "Sets a property on the given Pipeline / PipelineRun / Task files"
aliases:
  - jx-pipeline_set
---

### Usage

```
jx pipeline set
```

### Synopsis

Sets a property on the given Pipeline / PipelineRun / Task files.

### Examples

  ```bash
  # Modifies one or more Pipeline / PipelineRun / Tasks in the given folder
  jx pipeline set --dir tasks --template-env FOO=bar

  ```

### Options

```
  -d, --dir string                 Directory to look for YAML files (default ".")
  -f, --filter string              Text filter to filter the YAML files to modify
  -h, --help                       help for set
  -t, --template-env stringArray   List of environment variables to set of the form 'NAME=value' on the step template
```

### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
