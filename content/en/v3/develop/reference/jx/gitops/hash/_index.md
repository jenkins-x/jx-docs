---
title: jx gitops hash
linktitle: hash
type: docs
description: "Annotates the given files with a hash of the given source files for ConfigMaps/Secrets"
aliases:
  - jx-gitops_hash
---

## jx gitops hash

Annotates the given files with a hash of the given source files for ConfigMaps/Secrets

### Usage

```
jx gitops hash
```

### Synopsis

Annotates the given files with a hash of the given source files for ConfigMaps/Secrets

### Examples

  ```bash
  # annotates the Deployments in a dir from some source ConfigMaps
  jx-gitops hash -s foo/configmap.yaml -s another/configmap.yaml -d someDir

  ```
### Options

```
  -a, --annotation string         the annotation for the hash to add to the files (default "jenkins-x.io/hash")
  -d, --dir string                the directory to recursively look for the *.yaml or *.yml files (default ".")
  -h, --help                      help for hash
  -k, --kind stringArray          adds Kubernetes resource kinds to filter on to annotate. For kind expressions see: https://github.com/jenkins-x-plugins/jx-gitops/tree/master/docs/kind_filters.md (default [Deployment])
      --kind-ignore stringArray   adds Kubernetes resource kinds to exclude. For kind expressions see: https://github.com/jenkins-x-plugins/jx-gitops/tree/master/docs/kind_filters.md
  -p, --pod-spec                  annotate the PodSpec in spec.templates.metadata.annotations rather than the top level annotations
  -s, --source stringArray        the source files to hash
```

