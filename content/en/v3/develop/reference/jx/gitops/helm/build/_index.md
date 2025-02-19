---
title: jx gitops helm build
linktitle: build
type: docs
description: "Builds and lints any helm charts"
aliases:
  - jx-gitops_helm_build
---

### Usage

```
jx gitops helm build
```

### Synopsis

Builds and lints any helm charts

### Examples

  ```bash
  # generates the resources from a helm chart
  jx-gitops step helm template

  ```
### Options

```
  -n, --binary string            specifies the helm binary location to use. If not specified defaults to 'helm' on the $PATH
  -c, --charts-dir string        the directory to look for helm charts to release (default "charts")
  -h, --help                     help for build
      --oci                      using OCI charts
      --registry-config string   the path to the registry config for OCI login (default "/tekton/creds-secrets/tekton-container-registry-auth/.dockerconfigjson")
      --repo-password string     the password to access the chart repository. If not specified defaults to the environment variable $JX_REPOSITORY_PASSWORD
      --repo-username string     the username to access the chart repository. If not specified defaults to the environment variable $JX_REPOSITORY_USERNAME
      --use-helm-plugin          uses the jx binary plugin for helm rather than whatever helm is on the $PATH
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
