---
title: jx scm pull-request close
linktitle: close
type: docs
description: "closes a pull request"
aliases:
  - jx-scm_pull-request_close
---

### Usage

```
jx scm pull-request close
```

### Synopsis

Update a release

### Examples

  ```bash
  # closes pull requests foo/bar number 123
  jx-scm pull-request close --owner foo --name bar --pr 123
  
  # closes all open pull requests on foo/bar before pull request number 200
  jx-scm pull-request close --owner foo --name bar --before 200

  ```
### Options

```
      --before int        a pull request number to used to close ALL open pull requests before it
  -h, --help              help for close
  -k, --kind string       the kind of git server to use
  -r, --name string       the name of the repository that contains pull requests to close
  -o, --owner string      the owner of the repository that contains pull requests to close. Either an organisation or username
      --pr int            the pull request to close
  -s, --server string     the git server URL to use
      --size int          the number of open pull requests to return if using --before, defaults to 200 (default 200)
  -t, --token string      the token to use on the git server
  -u, --username string   the user name to use on the git server
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
