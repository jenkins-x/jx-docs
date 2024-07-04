---
title: jx pipeline convert
linktitle: convert
type: docs
description: "commands for converting pipelines"
aliases:
  - jx-pipeline_convert
---

### Usage

```
jx pipeline convert
```

### Synopsis

Convert one or more pipelines.

### Examples

  ```bash
  # Convert a pipeline to use "image:uses:"
  jx pipeline convert uses
  # Convert a pipeline to use native Tekton
  jx pipeline convert remotetasks

  ```
### Options

```
  -h, --help   help for convert
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
