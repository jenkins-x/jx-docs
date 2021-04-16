---
title: jx gitops pr variables
linktitle: variables
type: docs
description: "Adds Pull Request environment variables to the .jx/variables.sh file ***Aliases**: var,variable*"
aliases:
  - jx-gitops_pr_variables
---

## jx gitops pr variables

Adds Pull Request environment variables to the .jx/variables.sh file

***Aliases**: var,variable*

### Usage

```
jx gitops pr variables
```

### Synopsis

Adds Pull Request environment variables to the .jx/variables.sh file

### Examples

  ```bash
  # add Pull Request env vars to the .jx/variables.sh file
  jx-gitops pr variables

  ```
### Options

```
      --branch string       specifies the branch if not inside a git clone
      --dir string          the directory to search for the .git to discover the git source URL (default ".")
  -f, --file string         the default variables file to lazily create or enrich (default ".jx/variables.sh")
      --git-kind string     the kind of git server to connect to
      --git-server string   the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string    the git token used to operate on the git repository
  -h, --help                help for variables
      --pr int              the Pull Request number. If not specified we detect it via $PULL_NUMBER or $BRANCH_NAME environment variables
  -r, --repo string         the full git repository name of the form 'owner/name'
      --source-url string   the git source URL of the repository
```

