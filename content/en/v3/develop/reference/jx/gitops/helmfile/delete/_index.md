---
title: jx gitops helmfile delete
linktitle: delete
type: docs
description: "Deletes a chart from the helmfiles in one or all namespaces ***Aliases**: remove,rm,del*"
aliases:
  - jx-gitops_helmfile_delete
---

### Usage

```
jx gitops helmfile delete
```

### Synopsis

Deletes a chart from the helmfiles in one or all namespaces

### Examples

  ```bash
  # deletes the chart from all namespaces
  jx gitops helmfile delete --chart my-chart
  
  # deletes the chart from a specific namespace
  jx gitops helmfile delete --chart my-chart --namespace jx-staging
  
  # deletes the chart with the repo prefix from a specific namespace
  jx gitops helmfile delete --chart myrepo/my-chart --namespace jx-staging

  ```
### Options

```
  -b, --batch-mode              Runs in batch mode without prompting for user input
  -c, --chart string            the name of the helm chart to remove
      --commit-message string   the git commit message used (default "chore: generated kubernetes resources from helm chart")
  -d, --dir string              the directory that contains the helmfile.yaml and helmfiles directory (default ".")
      --git-commit              if set then the template command will git commit the modified helmfile.yaml files
      --helmfile string         the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the dir
  -h, --help                    help for delete
      --log-level string        Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string        the namespace to remove the chart from. If blank then remove from all namespaces
      --verbose                 Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
