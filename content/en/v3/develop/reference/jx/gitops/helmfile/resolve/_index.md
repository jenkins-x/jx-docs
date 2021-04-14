---
title: jx gitops helmfile resolve
linktitle: resolve
type: docs
description: "Resolves any missing versions or values files in the helmfile.yaml file from the version stream"
aliases:
  - jx-gitops_helmfile_resolve
---

## jx gitops helmfile resolve

Resolves any missing versions or values files in the helmfile.yaml file from the version stream

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
      --commit-message string       the git commit message used (default "chore: generated kubernetes resources from helm chart")
      --git-commit                  if set then the template command will git commit the modified helmfile.yaml files
      --helmfile string             the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the dir
      --helmfile-binary string      specifies the helmfile binary location to use. If not specified defaults to using the downloaded helmfile plugin
  -h, --help                        help for resolve
      --namespace string            the default namespace if none is specified in the helmfile.yaml (default "jx")
      --update                      updates versions from the version stream if they have changed
      --version-stream-dir string   the directory for the version stream. Defaults to 'versionStream' in the current --dir
```

