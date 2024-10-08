---
title: jx gitops label
linktitle: label
type: docs
description: "Labels all kubernetes resources in the given directory tree"
aliases:
  - jx-gitops_label
---

### Usage

```
jx gitops label
```

### Synopsis

Labels all kubernetes resources in the given directory tree

### Examples

  ```bash
  # updates recursively labels all resources in the current directory
  jx-gitops label mylabel=cheese another=thing
  # updates recursively all resources
  jx-gitops label --dir myresource-dir foo=bar
  # remove labels
  jx-gitops label mylabel- another-

  ```
### Options

```
      --dir string                the directory to recursively look for the *.yaml or *.yml files (default ".")
  -h, --help                      help for label
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
      --overwrite                 Set to false to not overwrite any existing value (default true)
  -p, --pod-spec                  label the PodSpec in spec.template.metadata.labels (or spec.jobTemplate.spec.template.metadata.labels for CronJobs) rather than the top level labels
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. --selector app=pusher-wave,heritage=Helm (default [])
      --selector-target string    sets which path in the Kubernetes resources to select on instead of metadata.labels.
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
