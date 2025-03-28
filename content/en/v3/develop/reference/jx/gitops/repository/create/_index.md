---
title: jx gitops repository create
linktitle: create
type: docs
description: "Creates any missing SourceRepository resources"
aliases:
  - jx-gitops_repository_create
---

### Usage

```
jx gitops repository create
```

### Synopsis

Creates any missing SourceRepository resources

### Options

```
  -c, --config string             the configuration file to load for the repository configurations. If not specified we look in ./.jx/gitops/source-config.yaml
  -d, --dir string                the directory look for the 'jx-requirements.yml` file (default ".")
  -h, --help                      help for create
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/tree/master/docs/kind_filters.md
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. --selector app=pusher-wave,heritage=Helm (default [])
      --selector-target string    sets which path in the Kubernetes resources to select on instead of metadata.labels.
  -s, --source-dir string         the directory to look for and generate the SourceConfig files
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
