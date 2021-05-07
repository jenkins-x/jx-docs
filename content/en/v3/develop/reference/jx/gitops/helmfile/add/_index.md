---
title: jx gitops helmfile add
linktitle: add
type: docs
description: "Adds a chart to the local 'helmfile.yaml' file"
aliases:
  - jx-gitops_helmfile_add
---

### Usage

```
jx gitops helmfile add
```

### Synopsis

Adds a chart to the local 'helmfile.yaml' file

### Examples

  ```bash
  # adds a chart using the currently known repositories in the verison stream or helmfile.yaml
  jx-gitops helmfile add --chart somerepo/mychart
  
  # adds a chart using a new repository URL with a custom version and namespace
  jx-gitops helmfile add --chart somerepo/mychart --repository https://acme.com/myrepo --namespace foo --version 1.2.3

  ```
### Options

```
  -b, --batch-mode                  Runs in batch mode without prompting for user input
  -c, --chart string                the name of the helm chart to add
      --commit-message string       the git commit message used (default "chore: generated kubernetes resources from helm chart")
  -d, --dir string                  the directory that contains the jx-requirements.yml (default ".")
      --git-commit                  if set then the template command will git commit the modified helmfile.yaml files
      --helmfile string             the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the dir
  -h, --help                        help for add
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --name string                 the name of the helm release
  -n, --namespace string            the namespace to install the chart (default "jx")
  -r, --repository string           the helm chart repository URL of the chart
      --values stringArray          the values files to add to the chart
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -v, --version string              the version of the helm chart. If not specified the versionStream will be checked otherwise the latest version is used
      --version-stream-dir string   the directory for the version stream. Defaults to 'versionStream' in the current --dir
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
