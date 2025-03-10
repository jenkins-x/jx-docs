---
title: jx gitops repository export
linktitle: export
type: docs
description: "Exports the 'source-config.yaml' file from the kubernetes resources in the current cluster"
aliases:
  - jx-gitops_repository_export
---

### Usage

```
jx gitops repository export
```

### Synopsis

"Exports the 'source-config.yaml' file from the kubernetes resources in the current cluster

### Examples

  ```bash
  # creates/populates the .jx/gitops/source-config.yaml file with any SourceRepository resources in the current cluster
  jx-gitops repository export

  ```
### Options

```
  -c, --config string             the configuration file to load for the repository configurations. If not specified we look in ./.jx/gitops/source-repositories.yaml
  -d, --dir string                the directory look for the 'jx-requirements.yml` file (default ".")
  -e, --explicit                  Explicit mode: always populate all the fields even if they can be deduced. e.g. the git URLs for each repository are not absolutely necessary and are omitted by default are populated if this flag is enabled
  -h, --help                      help for export
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
  -n, --namespace string          the namespace to look for SourceRepository, SourceRepositoryGroup and Scheduler resources
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. --selector app=pusher-wave,heritage=Helm (default [])
      --selector-target string    sets which path in the Kubernetes resources to select on instead of metadata.labels.
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
