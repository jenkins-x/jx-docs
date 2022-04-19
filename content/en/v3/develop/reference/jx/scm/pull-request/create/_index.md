---
title: jx scm pull-request create
linktitle: create
type: docs
description: "Creates a pull request"
aliases:
  - jx-scm_pull-request_create
---

### Usage

```
jx scm pull-request create
```

### Synopsis

Creates a pull request in the given repository, requesting the head branch be merged into the base branch

### Examples

  ```bash
  # creates a pull request for a branch
  jx-scm pull-request create \
  --owner foo \
  --name bar \
  --title "chore: a good reason to merge" \
  --body "Useful details for reviewers" \
  --head some-feature-branch \
  --base main

  ```
### Options

```
      --base string       the name of the branch you want the changes pulled into (default "main")
      --body string       the contents of the pull request
      --head string       the name of the branch where your changes are implemented
  -h, --help              help for create
  -k, --kind string       the kind of git server to use
  -r, --name string       the name of the repository
  -o, --owner string      the owner of the repository. Either an organisation or username
  -s, --server string     the git server URL to use
      --title string      the title of the new pull request
  -t, --token string      the token to use on the git server
  -u, --username string   the user name to use on the git server
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
