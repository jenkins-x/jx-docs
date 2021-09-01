---
title: jx updatebot argo promote
linktitle: promote
type: docs
description: "Promotes a new Application version in an ArgoCD git repository"
aliases:
  - jx-updatebot_argo_promote
---

### Usage

```
jx updatebot argo promote
```

### Synopsis

Promotes a new Application version in an ArgoCD git repository

This command will use the source git repository URL and version to find the ArgoCD Application resource in the target git URL and create a Pull Request if the version is different. This lets you push promotion pull requests into ArgoCD repositories as part of your CI release pipeline.

### Examples

  ```bash
  # lets use the $VERSION env var or a VERSION file in the current dir
  jx updatebot argo promote --target-git-url https://github.com/myorg/my-argo-repo.git
  
  # lets promote a specific version in the current git clone to a remote repo
  jx updatebot argo promote --version v1.2.3 --target-git-url https://github.com/myorg/my-argo-repo.git
  
  # lets promote a specific version of the given spec.source.repoURL (--source-git-url)
  jx updatebot argo promote --version v1.2.3 --source-git-url https://github.com/myorg/my-chart-repo.git --target-git-url https://github.com/myorg/my-argo-repo.git

  ```

### Options

```
      --auto-merge                  should we automatically merge if the PR pipeline is green
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
      --source-git-url string       the source repo git URL to upgrade the version
      --target-git-url string       the target git URL to create a Pull Request on
      --version string              the version number to promote. If not specified uses $VERSION or the version file
      --version-file string         the file to load the version from if not specified directly or via a $VERSION environment variable. Defaults to VERSION in the current dir
      --version-prefix string       the prefix added to the version number that will be used in the Argo CD Application YAML if --version option is not specified and the version is defaulted from $VERSION or the VERSION file (default "v")
```

### Source

[jenkins-x-plugins/jx-updatebot](https://github.com/jenkins-x-plugins/jx-updatebot)
