---
title: jx gitops git setup
linktitle: setup
type: docs
description: "Sets up git to ensure the git user name and email is setup"
aliases:
  - jx-gitops_git_setup
---

### Usage

```bash
jx gitops git setup
```

### Synopsis

Sets up git to ensure the git user name and email is setup.
  
This is typically used in a pipeline to ensure git can do commits.

### Examples

  ```bash
  jx-gitops git setup

  ```
  
### Details

The `jx gitops git setup` command ensures that we can authenticate with configured Git server by configuring the local
credentials file in the home directory. This command tries to ensure following things:

- The user can be authenticated with Git provider (for example Github)
- An email is associated with each automated commit message

These credentials are written to `${HOME}/git/credentials` file, where the `${HOME}` directory is determined as:

- value stored in `XGD_CONFIG_HOME` environment variable or
- value stored in `HOME` environment variable or
- value stored in `USERPROFILE` environment variable or
- as current directory `.`

The credentials are determined by reading out the `jx-requirements.yaml` from the cluster repository and `jx-boot`
Secret resource provisioned together with `jx-git-operator` in your Kubernetes namespace.

The Git username and email are preferentially determined from `PipelineUser` field from `jx-requirements.yaml`, but if
they are not available there then default email address `jenkins-x@googlegroups.com` is used (which is the reason why
you are seeing commits from `pow-devops2020` user made on your repositories). If the username could not be determined
from `jx-requirements.yaml`, then it is determined from:

- `GIT_USERNAME` environment variable or
- `GITHUB_ACTOR` environment variable
- In case that we are running in Kubernetes cluster from `username` field of the `jx-boot` Secret provisioned with
  `jx-git-operator`

The password for Github user (or a token for the robot account, depending on which you configued) is determined in
similar fashion. Namely the token is first determined from environment variable `GITHUB_TOKEN`, but if that fails, then
further determination is dependent on execution environment of the command. Namely if it is running within Github
actions, then the `GITHUB_TOKEN` environment variable is our last stop. Otherwise if the command is executed within
Kubernetes cluster, then the secret is determined by reading the `password` field of the `jx-boot` Secret provisioned
with the `jx-git-operator`.

### Options

```
      --credentials-file string     The destination of the git credentials file to generate. If not specified uses $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
  -d, --dir string                  the directory to run the git setup command from
  -e, --email string                the git user email to use if one is not setup. Default value is `jenkins-x@googlegroups.com`, if none other is provided
      --fake-in-cluster             for testing: lets you fake running this command inside a kubernetes cluster so that it can create the file: $XDG_CONFIG_HOME/git/credentials or $HOME/git/credentials
      --git-provider string         the git provider URL. If not specified it is detected from the git operator `jx-boot` Secret or defaults to https://github.com
  -h, --help                        help for setup
  -n, --name string                 the git user name to use if one is not setup
      --namespace string            the namespace used to find the git operator secret for the git repository if running in cluster. Defaults to the current namespace
      --operator-namespace string   the namespace used by the git operator to find the secret for the git repository if running in cluster (default "jx-git-operator")
      --password string             the git password/token to use. if not specified it is detected from the git operator Secret
      --secret string               the name of the Secret to find the git URL, username and password for creating a git credential if running inside the cluster (default "jx-boot")
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
