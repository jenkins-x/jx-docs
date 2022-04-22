---
title: jx scm repository clone
linktitle: clone
type: docs
description: "Clones a git repository"
aliases:
  - jx-scm_repository_clone
---

### Usage

```
jx scm repository clone
```

### Synopsis

Clones a git repository

### Examples

  ```bash
  # creates a new git repository in the given server
  jx-scm repository clone https://myserver.com/myowner/myrepo

  ```
### Options

```
  -b, --batch-mode         Runs in batch mode without prompting for user input
  -h, --help               help for clone
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-scm](https://github.com/jenkins-x-plugins/jx-scm)
