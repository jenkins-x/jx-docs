---
title: jx gitops helm release
linktitle: release
type: docs
description: "Performs a release of all the charts in the charts folder"
aliases:
  - jx-gitops_helm_release
---

### Usage

```
jx gitops helm release
```

### Synopsis

Generate the kubernetes resources from a helm chart

### Examples

  ```bash
  # generates the resources from a helm chart
  jx-gitops step helm template

  ```
### Options

```
      --artifactory                use artifactory mode for publishing the chart which involves using an artifactory header and -T for pushing the chart
  -c, --charts-dir string          the directory to look for helm charts to release (default "charts")
      --dir string                 the root directory to look for .jx/requirements.yaml (default ".")
      --ghpage-url string          the github pages URL used if creating the first README.md in the github pages branch so we can link to how to add a chart repository
  -h, --help                       help for release
  -I, --ignore stringArray         the names of helm charts to not release (default [preview])
      --namespace string           the namespace to look for the dev Environment. Defaults to the current namespace
      --no-oci-login               disables using the 'helm registry login' command when using OCI
      --no-release                 disables publishing the release. Useful for a Pull Request pipeline
      --oci                        treat the repository as an OCI container registry. If not specified its defaulted from the cluster.chartOCI flag on the 'jx-requirements.yml' file
      --pages                      use github pages to release charts
  -n, --repo-name string           the name of the helm chart to release to. If not specified uses JX_CHART_REPOSITORY environment variable (default "release-repo")
      --repo-password string       the password to access the chart repository. If not specified defaults to the environment variable $JX_REPOSITORY_PASSWORD
  -u, --repo-url string            the URL to release to
      --repo-username string       the username to access the chart repository. If not specified defaults to the environment variable $JX_REPOSITORY_USERNAME
      --repository-branch string   the branch used if using GitHub Pages for the helm chart (default "gh-pages")
      --use-helm-plugin            uses the jx binary plugin for helm rather than whatever helm is on the $PATH
      --version string             specify the version to release
      --version-file string        the file to load the version from if not specified directly or via a $VERSION environment variable (default "VERSION")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
