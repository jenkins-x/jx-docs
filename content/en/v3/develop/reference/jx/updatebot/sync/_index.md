---
title: jx updatebot sync
linktitle: sync
type: docs
description: "Synchronizes some or all applications in an environment/namespace to another environment/namespace to reduce version drift"
aliases:
  - jx-updatebot_sync
---

### Usage

```
jx updatebot sync
```

### Synopsis

Synchronizes some or all applications in an environment/namespace to another environment/namespace to reduce version drift

Supports synchronizing environments or namespaces within the same cluster or namespaces between remote clusters (possibly using different namespaces).

Create a Pull Request on the target GitOps repository to apply the changes so that you can review the changes before they happen. You can use different labels to enable/disable auto-merging.

### Examples

  ```bash
  # choose the environments to synchronize
  jx updatebot sync
  
  # synchronizes the apps in 2 of your environments (local or remote)
  jx updatebot sync --source-env staging --target-env production
  
  # synchronizes the apps in 2 namespaces in the dev cluster
  jx updatebot sync --source-ns jx-staging --target-ns jx-production
  
  
  # synchronizes the edam and beer charts in 2 of your environments (local or remote)
  jx updatebot sync --source-env staging --target-env production --charts edam --charts beer

  ```

### Options

```
      --auto-merge                  should we automatically merge if the PR pipeline is green (default true)
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --charts strings              names of charts to filter resources to sync. Can be local chart name (without prefix) or the full name with prefix
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
      --namespaces strings          a list of namespaces to filter resources to sync
      --no-version                  disables validation on requiring a '--version' option or environment variable to be required
      --pull-request-body string    the PR body
      --pull-request-title string   the PR title
      --source-dir string           the directory to use for the git clone for the source
      --source-env string           the environment name for the source
      --source-git-url string       git URL to clone for the source
      --source-helmfile string      the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the git clone dir
      --source-ns string            the namespace for the source
      --target-dir string           the directory to use for the git clone for the target
      --target-env string           the environment name for the target
      --target-git-url string       git URL to clone for the target
      --target-helmfile string      the helmfile to resolve. If not specified defaults to 'helmfile.yaml' in the git clone dir
      --target-ns string            the namespace for the target
      --update-only                 only update versions in the target environment/namespace - do not add any new charts that are missing
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-updatebot](https://github.com/jenkins-x-plugins/jx-updatebot)
