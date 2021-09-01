---
title: jx updatebot flux promote
linktitle: promote
type: docs
description: "Promotes a new HelmRelease version in a FluxCD git repository"
aliases:
  - jx-updatebot_flux_promote
---

### Usage

```
jx updatebot flux promote
```

### Synopsis

Promotes a new HelmRelease version in a FluxCD git repository

This command will use the given chart name and version along with an optional sourceRefName of the helm or git repository or bucket to find the HelmRelease resource in the target git repository and create a Pull Request if the version is different. This lets you push promotion pull requests into FluxCD repositories as part of your CI release pipeline.

If you don't supply a version the $VERSION or VERSION file will be used. If you don't supply a chart the current folder name is used.

### Examples

  ```bash
  # lets promote a specific version of a chart with a source ref (repository) name to a git repo
  jx updatebot flux promote --version v1.2.3 --chart mychart --source-ref-name myrepo --target-git-url https://github.com/myorg/my-flux-repo.git
  
  # lets use the $VERSION env var or a VERSION file in the current dir and detect the chart name from the current folder
  jx updatebot flux promote --target-git-url https://github.com/myorg/my-flux-repo.git

  ```

### Options

```
      --auto-merge                  should we automatically merge if the PR pipeline is green
  -c, --chart string                the name of the chart to promote. If not specified defaults to the current directory name
      --commit-message string       the commit message
      --commit-title string         the commit title
  -d, --dir string                  the directory look for the VERSION file (default ".")
      --git-kind string             the kind of git server to connect to
      --git-server string           the git server URL to create the scm client
      --git-token string            the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string         the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                        help for promote
      --labels strings              a list of labels to apply to the PR (default [promote])
      --pull-request-body string    the PR body
      --pull-request-title string   the PR title (default "chore: upgrade the cluster git repository from the version stream")
      --source-ref-name string      the source ref name of the HelmRepository, GitRepository or Bucket containing the helm chart
      --target-git-url string       the target git URL to create a Pull Request on
      --version string              the version number to promote. If not specified uses $VERSION or the version file
      --version-file string         the file to load the version from if not specified directly or via a $VERSION environment variable. Defaults to VERSION in the current dir
      --version-prefix string       the prefix added to the version number that will be used in the Flux CD Application YAML if --version option is not specified and the version is defaulted from $VERSION or the VERSION file (default "v")
```

### Source

[jenkins-x-plugins/jx-updatebot](https://github.com/jenkins-x-plugins/jx-updatebot)
