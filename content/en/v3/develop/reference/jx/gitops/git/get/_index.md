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

Gets a file from a git repository or environment git repository

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
