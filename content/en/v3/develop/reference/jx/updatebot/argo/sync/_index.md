---
title: jx updatebot argo sync
linktitle: sync
type: docs
description: "Synchronizes some or all applications in an ArgoCD git repository to reduce version drift"
aliases:
  - jx-updatebot_argo_sync
---

### Usage

```
jx updatebot argo sync
```

### Synopsis

Synchronizes some or all applications in an ArgoCD git repository to reduce version drift 

Creates a Pull Request on the target GitOps repository.

### Examples

  ```bash
  # create a Pull Request if any of the versions are out of sync
  jx updatebot argo sync --source-git-url https://github.com/myorg/my-staging-repo --target-git-url https://github.com/myorg/my-production-repo
  
  # create a Pull Request if any of the versions are out of sync including only the given repo URL strings
  jx updatebot argo sync --source-git-url https://github.com/myorg/my-staging-repo --target-git-url https://github.com/myorg/my-production-repo --repourl-includes wine  --repourl-includes beer
  
  # create a Pull Request if any of the versions are out of sync excluding the given repo URL strings
  jx updatebot argo sync --source-git-url https://github.com/myorg/my-staging-repo --target-git-url https://github.com/myorg/my-production-repo --repourl-excludes water

  ```
### Options

```
      --auto-merge                  should we automatically merge if the PR pipeline is green (default true)
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --commit-message string       the commit message
      --commit-title string         the commit title
      --git-credentials             ensures the git credentials are setup so we can push to git
      --git-kind string             the kind of git server to connect to
      --git-server string           the git server URL to create the scm client
      --git-token string            the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-user-email string       the user email to git commit
      --git-user-name string        the user name to git commit
      --git-username string         the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                        help for sync
      --labels strings              a list of labels to apply to the PR
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --path-exclude strings        text strings in the path of the helm chart to be excluded when synchronising
      --path-include strings        text strings in the path of the helm chart to be included when synchronising
      --pull-request-body string    the PR body
      --pull-request-title string   the PR title
      --repourl-exclude strings     text strings in the repository URL to be excluded when synchronising
      --repourl-include strings     text strings in the repository URL to be included when synchronising
      --source-dir string           the directory to use for the git clone for the source
      --source-git-url string       git URL to clone for the source
      --target-dir string           the directory to use for the git clone for the target
      --target-git-url string       git URL to clone for the target
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-updatebot](https://github.com/jenkins-x-plugins/jx-updatebot)
