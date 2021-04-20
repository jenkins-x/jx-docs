---
title: jx gitops jenkins add
linktitle: add
type: docs
description: "Adds a new Jenkins server to the git repository ***Aliases**: create,new*"
aliases:
  - jx-gitops_jenkins_add
---

### Usage

```
jx gitops jenkins add
```

### Synopsis

Adds a new Jenkins server to the git repository

### Examples

  ```bash
  # adds a new jenkins server to the git repository
  jx-gitops jenkins add --name myjenkins

  ```
### Options

```
  -c, --chart string        the jenkins helm chart to use (default "jenkinsci/jenkins")
  -h, --help                help for add
  -n, --name string         the name of the jenkins server to add
  -r, --repository string   the helm chart repository URL of the chart (default "https://charts.jenkins.io")
  -v, --version string      the version of the helm chart. If not specified the versionStream will be checked otherwise the latest version is used
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
