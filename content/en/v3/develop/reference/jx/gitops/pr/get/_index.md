---
title: jx gitops pr get
linktitle: get
type: docs
description: "Gets a pull request and displays fields from it"
aliases:
  - jx-gitops_pr_get
---

## jx gitops pr get

Gets a pull request and displays fields from it

### Usage

```
jx gitops pr get
```

### Synopsis

Gets a pull request and displays fields from it

### Examples

  ```bash
  # display the head source URL
  jx-gitops pr get --head-url

  ```
### Options

```
      --branch string       specifies the branch if not inside a git clone
      --dir string          the directory to search for the .git to discover the git source URL (default ".")
      --git-kind string     the kind of git server to connect to
      --git-server string   the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string    the git token used to operate on the git repository
      --head-url            show the head clone URL of the PR
  -h, --help                help for get
      --pr int              the Pull Request number. If not specified we detect it via $PULL_NUMBER or $BRANCH_NAME environment variables
  -r, --repo string         the full git repository name of the form 'owner/name'
      --source-url string   the git source URL of the repository
```

