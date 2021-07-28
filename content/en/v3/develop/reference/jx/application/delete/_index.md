---
title: jx application delete
linktitle: delete
type: docs
description: "Deletes the application deployments and removes the lighthouse configuration"
aliases:
  - jx-application_delete
---

### Usage

```
jx application delete
```

### Synopsis

Deletes the application deployments and removes the lighthouse configuration 

This command actually create a Pull Request on the development cluster git repository so you can review the changes to be made.

### Examples

  ```bash
  # deletes the application with the given name from the development cluster
  jx application delete --name myapp
  
  # deletes the deployed application for the remote production cluster only
  jx application delete --name myapp --env production
  
  # deletes the application with the given name with the git owner
  jx application delete --name myapp --owner myorg
  
  # deletes the deployed applications but doesn't remove the '.jx/gitops/source-config.yaml' entry - so new releases come back
  jx application delete --name myapp --owner myorg --no-source

  ```
### Options

```
      --auto-merge                  should we automatically merge if the PR pipeline is green (default true)
  -b, --batch-mode                  Runs in batch mode without prompting for user input
      --commit-message string       the commit message
      --commit-title string         the commit title
  -e, --env string                  The Environment name used to find the repository git URL if none is specified (default "dev")
      --git-kind string             the kind of git server to connect to
      --git-server string           the git server URL to create the scm client
      --git-token string            the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string         the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                        help for delete
      --log-level string            Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --no-source                   Do not remove the repository from the '.jx/gitops/source-config/yaml' file - so that a new release will come back
  -o, --owner string                The name of the git organisation or user which owns the app
      --pull-request-body string    the PR body
      --pull-request-title string   the PR title
      --remove-ns string            The namespace to remove the app from. If blank remove from all deployed namespaces
  -r, --repo string                 The name of the repository to remove
  -u, --url string                  The git URL of the cluster git repository to modify
      --verbose                     Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-application](https://github.com/jenkins-x-plugins/jx-application)
