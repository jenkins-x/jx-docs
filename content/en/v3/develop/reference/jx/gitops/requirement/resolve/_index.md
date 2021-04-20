---
title: jx gitops requirement resolve
linktitle: resolve
type: docs
description: "Resolves any missing values in the jx-requirements.yml which can be detected"
aliases:
  - jx-gitops_requirement_resolve
---

### Usage

```
jx gitops requirement resolve
```

### Synopsis

Resolves any missing values in the jx-requirements.yml which can be detected.
  
For example if the provider is GKE then this step will automatically default the project, cluster name and location values if they are not in the 'jx-requirements.yml' file.

### Examples

  ```bash
  jx-gitops requirements resolve

  ```
### Options

```
  -d, --dir string         the directory to run the git push command from (default ".")
  -h, --help               help for resolve
      --namespace string   the namespace used to find the git operator secret for the git repository if running in cluster. Defaults to the current namespace
  -n, --no-commit          disables performing a git commit if there are changes
      --retries int        Specify the number of times the command should be reattempted on failure (default 3)
      --secret string      the name of the Secret to find the git URL, username and password for creating a git credential if running inside the cluster (default "jx-boot")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
