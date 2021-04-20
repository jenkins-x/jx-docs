---
title: jx gitops git setup
linktitle: setup
type: docs
description: "Sets up git to ensure the git user name and email is setup"
aliases:
  - jx-gitops_git_setup
---

### Usage

```
jx gitops git setup
```

### Synopsis

Sets up git to ensure the git user name and email is setup.
  
This is typically used in a pipeline to ensure git can do commits.

### Examples

  ```bash
  jx-gitops git setup

  ```
### Options

```
      --credentials-file string     The destination of the git credentials file to generate. If not specified uses $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
  -d, --dir string                  the directory to run the git setup command from
  -e, --email string                the git user email to use if one is not setup
      --fake-in-cluster             for testing: lets you fake running this command inside a kubernetes cluster so that it can create the file: $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
      --git-provider string         the git provider URL. If not specified its detected from the git operator Secret or defaults to https://github.com
  -h, --help                        help for setup
  -n, --name string                 the git user name to use if one is not setup
      --namespace string            the namespace used to find the git operator secret for the git repository if running in cluster. Defaults to the current namespace
      --operator-namespace string   the namespace used by the git operator to find the secret for the git repository if running in cluster (default "jx-git-operator")
      --password string             the git password/token to use. if not specified it is detected from the git operator Secret
      --secret string               the name of the Secret to find the git URL, username and password for creating a git credential if running inside the cluster (default "jx-boot")
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
