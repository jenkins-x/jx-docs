---
title: jx gitops patch
linktitle: patch
type: docs
description: "Patches the given resources"
aliases:
  - jx-gitops_patch
---

### Usage

```
jx gitops patch
```

### Synopsis

Annotates all kubernetes resources in the given directory tree

### Examples

  ```bash
  # updates recursively annotates all resources in the current directory
  jx-gitops annotate myannotate=cheese another=thing
  # updates recursively all resources
  jx-gitops annotate --dir myresource-dir foo=bar

  ```

### Options

```
  -d, --data string       the patch data to apply as json or yaml
  -g, --group string      the API group such as 'apps' for Deployemnts (default "apps")
  -h, --help              help for patch
  -k, --kind string       the kind name (default "deployments")
      --name string       the name of the resource to copy instead of a selector
  -n, --ns string         the namespace to find the resources to copy. Defaults to the current namespace
  -l, --selector string   the label selector to find the resources to copy
      --type string       the patch type such as 'yaml' or 'json'
      --version string    the API version of the resources to copy (default "v1")
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
