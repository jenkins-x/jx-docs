---
title: jx scm repository create
linktitle: create
type: docs
description: "Creates a new git provider in a git server"
aliases:
  - jx-scm_repository_create
---

### Usage

```
jx scm repository create
```

### Synopsis

Creates a new git provider in a git server

### Examples

  ```bash
  # creates a new git repository in the given server
  jx-scm repository create --git-kind gitlab --git-server https://myserver.com --owner myuser --name myrepo
  
  # creates a new git repository using a URL
  jx-scm repository create --git-kind gitlab https://mygitserver/myowner/myrepo

  ```
### Options

```
  -b, --batch-mode           Runs in batch mode without prompting for user input
      --confirm              confirms creating the repository
  -d, --description string   the repository description
  -h, --help                 help for create
      --home-page string     the repository home page
  -k, --kind string          the kind of git server to use
      --log-level string     Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --name string          the name of the repository to create
  -o, --owner string         the owner of the repository to create. Either an organisation or username
      --private              if the repository should be private
      --push-host string     the git host to use when pushing to the git repository. Only really useful in BDD tests if using something like 'kubectl portforward' to access a git repository where you want to push from outside the cluster with a different host name to the host name used inside the cluster
  -s, --server string        the git server URL to use
      --template string      the git template repository to create the repository from
  -t, --token string         the token to use on the git server
  -u, --username string      the user name to use on the git server
      --verbose              Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
