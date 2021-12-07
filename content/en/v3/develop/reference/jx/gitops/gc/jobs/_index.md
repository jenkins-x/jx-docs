---
title: jx gitops gc jobs
linktitle: jobs
type: docs
description: "garbage collection for jobs ***Aliases**: job*"
aliases:
  - jx-gitops_gc_jobs
---

### Usage

```
jx gitops gc jobs
```

### Synopsis

Garbage collect old Jobs that have completed or failed

### Examples

  ```bash
  # garbage collect old jobs of the default age
  jx gitops gc jobs
  
  # garbage collect jobs older than 10 minutes
  jx gitops gc jobs -a 10m
  
  # dry run mode
  jx gitops gc jobs --dry-run

  ```
### Options

```
  -a, --age duration       The minimum age of jobs to garbage collect. Any newer jobs will be kept (default 1h0m0s)
  -d, --dry-run            Dry run mode. If enabled just list the jobs that would be removed
  -h, --help               help for jobs
  -n, --namespace string   The namespace to look for the jobs. Defaults to the current namespace
  -s, --selector string    The selector to use to filter the jobs
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
