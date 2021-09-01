---
title: jx project pullrequest
linktitle: pullrequest
type: docs
description: "Create a Pull Request on the git project for the current directory ***Aliases**: pr,pull request*"
aliases:
  - jx-project_pullrequest
---

### Usage

```
jx project pullrequest
```

### Synopsis

Creates a Pull Request in a the git project of the current directory.

If --push is specified the contents of the directory will be committed, pushed and used to create the pull request

### Examples

  ```bash
  # Create a Pull Request in the current project
  jx project pullrequest -t "my PR title"
  
  
  # Create a Pull Request with a title and a body
  jx project pullrequest -t "my PR title" --body "
  some more
  text
  goes
  here
  ""
  "

  ```

### Options

```
      --base string         The base branch to create the pull request into (default "master")
  -b, --batch-mode          Enables batch mode which avoids prompting for user input
      --body string         The body of the pullrequest
      --dir string          the directory to search for the .git to discover the git source URL (default ".")
      --fork                If true, and the username configured to push the repo is different from the org name a PR is being created against, assume that this is a fork
      --git-kind string     the kind of git server to connect to
      --git-server string   the git server URL to create the git provider client. If not specified its defaulted from the current source URL
      --git-token string    the git token used to operate on the git repository
  -h, --help                help for pullrequest
  -l, --label stringArray   The labels to add to the pullrequest
      --push                If true the contents of the source directory will be committed, pushed, and used to create the pull request
  -t, --title string        The title of the pullrequest to create
```

### Source

[jenkins-x-plugins/jx-project](https://github.com/jenkins-x-plugins/jx-project)
