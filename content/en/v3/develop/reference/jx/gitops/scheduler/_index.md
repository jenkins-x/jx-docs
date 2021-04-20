---
title: jx gitops scheduler
linktitle: scheduler
type: docs
description: "Generates the Lighthouse configuration from the SourceRepository and Scheduler resources ***Aliases**: schedulers,lighthouse*"
aliases:
  - jx-gitops_scheduler
---

### Usage

```
jx gitops scheduler
```

### Synopsis

Generates the Lighthouse configuration from the SourceRepository and Scheduler resources

### Examples

  ```bash
  # regenerate the lighthouse configuration from the Environment, Scheduler, SourceRepository resources
  jx-gitops scheduler --dir config-root/namespaces/jx -out src/base/namespaces/jx/lighthouse-config

  ```
### Options

```
  -d, --dir string                  the current working directory (default ".")
  -h, --help                        help for scheduler
      --in-repo-config              enables in repo configuration in lighthouse
  -n, --namespace string            the namespace for the SourceRepository and Scheduler resources (default "jx")
  -o, --out string                  the output directory for the generated config files. If not specified defaults to config-root/namespaces/$ns/lighthouse-config
      --repo-dir string             the directory to look for SourceRepository resources. If not specified defaults config-root/namespaces/$ns
      --scheduler-dir stringArray   the directory to look for Scheduler resources. If not specified defaults 'schedulers' and 'versionStream/schedulers'
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
