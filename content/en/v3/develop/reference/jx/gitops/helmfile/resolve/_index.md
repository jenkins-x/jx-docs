---
title: jx gitops helmfile resolve
linktitle: resolve
type: docs
description: "Resolves any missing versions or values files in the helmfile.yaml file from the version stream"
aliases:
  - jx-gitops_helmfile_resolve
---

### Usage

```
jx gitops helmfile resolve
```

### Synopsis

Resolves the helmfile.yaml from the version stream to specify versions and helm values

### Examples

  ```bash
  # resolves the versions and values in the helmfile.yaml
  jx-gitops helmfile resolve

  ```
### Options

```
      --add-environment-pipelines   skips the custom upgrade step for adding .lighthouse folder
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --commit-message string       the git commit message used (default "chore: generated kubernetes resources from helm chart")
      --git-commit                  if set then the template command will git commit the modified helmfile.yaml files
      --helm-binary string          specifies the helm binary location to use. If not specified defaults to using the downloaded helm plugin
      --helmfile string             the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the dir
  -h, --help                        help for resolve
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --namespace string            the default namespace if none is specified in the helmfile.yaml (default "jx")
      --update                      updates versions from the version stream if they have changed
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --version-stream-dir string   the directory for the version stream. Defaults to 'versionStream' in the current --dir
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
