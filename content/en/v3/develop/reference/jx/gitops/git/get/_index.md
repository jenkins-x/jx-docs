---
title: jx gitops git get
linktitle: get
type: docs
description: "Gets a file from a git repository or environment git repository"
aliases:
  - jx-gitops_git_get
---

### Usage

```
jx gitops git get
```

### Synopsis

Gets a file from a git repository or Jx Environment git repository

### Details

Copies a file specified by `--file` flag from a Git repository into local file system. The repository from which the file is read is either the one specified via command line flags or the one defined as the target repository of the Jenkins X Environment object, whose name too can be passed in via CLI flags.

In case that repository is read out from the environment, then if we are running
in Kubernetes cluster the Environment object is searched for either in the namespace defined by the current kubeconfig context (if command is executed locally) or is searched for in the namespace of the Pod on which the command is being executed.

In case that command is not executed in Kubernetes and the repository has not been set via command line flags, then the repositoy from which file is read needs to be configured in environment variable: `JX_ENVIRONMENT_GIT_URL`.

The file is either copied to the path specified by the command line flag `--to` or is written under the same path from which it was read into the current working directory.

Notes:
- The namespace in which the command looks for the environment is either the namespace configured in kubeconfig or the namespace of the pod on which command is executing.

### Examples

  ```bash
  jx-gitops git get --file jx-values.yaml --dev dev

  ```
### Options

```
      --branch string       specifies the branch if not inside a git clone
      --dir string          the directory to search for the .git to discover the git source URL (default ".")
  -e, --env string          the name of the Environment to find the git repository URL
  -f, --file string         the file in the git repository
      --from string         the git repository of the form owner/name to find the file
      --git-kind string     the kind of git server to connect to
      --git-server string   the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string    the git token used to operate on the git repository
  -h, --help                help for get
      --ref string          the git reference (branch, tag or SHA) to query the file (default "master")
  -r, --repo string         the full git repository name of the form 'owner/name'
      --source-url string   the git source URL of the repository
      --to string           the destination of the file. If not specified defaults to the path
```

### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
