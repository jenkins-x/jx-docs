---
title: jx scm repository remove
linktitle: remove
type: docs
description: "Removes one or more repositories ***Aliases**: delete,rm*"
aliases:
  - jx-scm_repository_remove
---

### Usage

```
jx scm repository remove
```

### Synopsis

Removes one or more repositories

### Examples

  ```bash
  # removes all the repositories in the owner with the given filter
  jx-scm repository remove --owner myuser -f mything
  
  # removes all the repositories in the owner created before the given time
  jx-scm repository remove --owner myuser --created-before '02 Jan 06 15:04 MST'
  
  # removes all the repositories in the owner created 30 days ago
  jx-scm repository remove --owner myuser --created-days-ago 30  --confirm

  ```
### Options

```
      --confirm                 confirms the removal without prompting the user
      --created-before string   the time expression for removing repositories created before this time
      --created-days-ago int    remove repositories created more than this number of days ago
      --dry-run                 disables actually deleting the repository so you can test the filtering
  -x, --exclude stringArray     the text filter to exclude
      --fail-on-error           stops removing repositories if a remove failsg
  -f, --filter stringArray      the text filter to match the name
      --git-kind string         the kind of git server to connect to
      --git-server string       the git server URL to create the scm client
      --git-token string        the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string     the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                    help for remove
  -n, --name string             the name of the repository to create
  -o, --owner string            the owner of the repository to create. Either an organisation or username.  For Azure, include the project: 'organization/project'
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
