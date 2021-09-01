---
title: jx gitops annotate
linktitle: annotate
type: docs
description: "Annotates all kubernetes resources in the given directory tree"
aliases:
  - jx-gitops_annotate
---

### Usage

```
jx gitops annotate
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
      --dir string                the directory to recursively look for the *.yaml or *.yml files (default ".")
  -h, --help                      help for annotate
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
  -p, --pod-spec                  annotate the PodSpec in spec.templates.metadata.annotations rather than the top level annotations
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. -s app=pusher-wave,heritage=Helm (default [])
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
