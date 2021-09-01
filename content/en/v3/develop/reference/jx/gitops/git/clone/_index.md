---
title: jx gitops git clone
linktitle: clone
type: docs
description: "Clones the cluster git repository using the URL, git user and token from the Secret"
aliases:
  - jx-gitops_git_clone
---

### Usage

```
jx gitops git clone
```

### Synopsis

Clones the cluster git repository from the URL provided to the jx-git-operator watching the said repository, and authenticating as git user with token provided by jx-boot secret, also provided by jx-git-operator installation.

Effectively this command runs jx gitops git setup before proceeding to simply clone the repository into either the folder passed in via --clone-dir or into the ./setup directory.

### Examples

  ```bash
  jx-gitops git clone

  ```

### Options

```
      --clone-dir string            the directory to clone the repository to. Default value used is ./source relative to the directory in which the command is running
      --credentials-file string     The destination of the git credentials file to generate. If not specified uses $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
  -d, --dir string                  the directory to run the git setup command from
  -e, --email string                the git user email to use if one is not setup. Default value is jenkins-x@googlegroups.com, if none other is provided
      --fake-in-cluster             for testing: lets you fake running this command inside a kubernetes cluster so that it can create the file: $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
      --git-provider string         the git provider URL. If not specified its detected from the git operator jx-boot Secret or defaults to https://github.com
  -h, --help                        help for clone
  -n, --name string                 the git user name to use if one is not setup
      --namespace string            the namespace used to find the git operator secret for the git repository if running in cluster. Defaults to the current namespace
      --operator-namespace string   the namespace used by the git operator to find the secret for the git repository if running in cluster (default "jx-git-operator")
      --password string             the git password/token to use. if not specified it is detected from the git operator Secret
      --secret string               the name of the Secret to find the git URL, username and password for creating a git credential if running inside the cluster (default "jx-boot")
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
