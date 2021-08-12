---
title: jx gitops pr variables
linktitle: variables
type: docs
description: "Adds Pull Request environment variables to the .jx/variables.sh file ***Aliases**: var,variable*"
aliases:
  - jx-gitops_pr_variables
---

### Usage

```
jx gitops pr variables
```

### Synopsis

Adds Pull Request environment variables to the .jx/variables.sh file

### Examples

  ```bash
  # add variables from the Pull Request and labels to the .jx/variables.sh file
  jx gitops pr variables
  
  # add variables from the Pull Request, labels and comments of the form '/jx-var FOO=bar' to the .jx/variables.sh file
  jx gitops pr variables --comments

  ```
### Options

```
      --branch string           specifies the branch if not inside a git clone
      --comment-prefix string   the comment prefix to specify environment variables (default "/jx-var")
      --comments                if enabled query all the comments on the Pull Request and find any variables using special comments starting with the comment prefix
      --dir string              the directory to search for the .git to discover the git source URL (default ".")
      --env-prefix string       the prefix added to any variable name defined via a comment. e.g. a comment of '/jx-var CHEESE=edam' would generate 'export PR_COMMENT_CHEESE=edam' (default "PR_COMMENT_")
  -f, --file string             the default variables file to lazily create or enrich (default ".jx/variables.sh")
      --git-kind string         the kind of git server to connect to
      --git-server string       the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string        the git token used to operate on the git repository
  -h, --help                    help for variables
      --pr int                  the Pull Request number. If not specified we detect it via $PULL_NUMBER or $BRANCH_NAME environment variables
  -r, --repo string             the full git repository name of the form 'owner/name'
      --source-url string       the git source URL of the repository
```



### Source

[jenkins-x-plugins/jx-gitops](https://github.com/jenkins-x-plugins/jx-gitops)
