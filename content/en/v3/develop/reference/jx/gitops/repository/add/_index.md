---
title: jx gitops repository add
linktitle: add
type: docs
description: "Add one or more git URLs to the source configuration"
aliases:
  - jx-gitops_repository_add
---

### Usage

```
jx gitops repository add
```

### Synopsis

Add one or more repositories to the SourceConfig

### Examples

  ```bash
  # creates any missing SourceConfig resources
  jx-gitops repository add https://github.com/myorg/myrepo.git%!(EXTRA string=jx-gitops)

  ```

### Options

```
  -c, --config string             the configuration file to load for the repository configurations. If not specified we look in .jx/gitops/source-repositories.yaml
  -d, --dir string                the directory look for the 'jx-requirements.yml` file (default ".")
  -e, --explicit                  Explicit mode: always populate all the fields even if they can be deduced. e.g. the git URLs for each repository are not absolutely necessary and are omitted by default are populated if this flag is enabled
  -h, --help                      help for add
      --invert-selector           inverts the effect of selector to exclude resources matched by selector
  -j, --jenkins string            the name of the Jenkins server to add the repository to
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x/jx-helpers/v3/tree/master/docs/kind_filters.md
      --namespace string          the namespace to discover SourceRepository resources to default the GitKind. If not specified then use the current namespace
  -s, --scheduler string          the name of the Scheduler to use for the repository
      --selector stringToString   adds Kubernetes label selector to filter on, e.g. -s app=pusher-wave,heritage=Helm (default [])
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
