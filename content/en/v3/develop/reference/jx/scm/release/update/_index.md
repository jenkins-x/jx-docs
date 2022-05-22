---
title: jx scm release update
linktitle: update
type: docs
description: "Updates a release"
aliases:
  - jx-scm_release_update
---

### Usage

```
jx scm release update
```

### Synopsis

Update a release

### Examples

  ```bash
  # updates a release to change the title
  jx-scm release update --owner foo --repository bar --tag v1.2.3 --title something
  
  # updates a release to make it not a pre-release
  jx-scm release update --owner foo --repository bar --tag v1.2.3 --pre-release false

  ```
### Options

```
      --description string   the updated release description
  -h, --help                 help for update
  -k, --kind string          the kind of git server to use
  -r, --name string          the name of the repository to update
  -o, --owner string         the owner of the repository to update. Either an organisation or username
      --prerelease           the updated prerelease status, true to identify the release as a prerelease, false to identify the release as a full release. (default true)
  -s, --server string        the git server URL to use
      --tag string           the tag of the release to update
      --title string         the updated release title
  -t, --token string         the token to use on the git server
  -u, --username string      the user name to use on the git server
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
