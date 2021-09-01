---
title: jx project enable
linktitle: enable
type: docs
description: "Enables lighthouse pipelines in the current directory ***Aliases**: dump*"
aliases:
  - jx-project_enable
---

### Usage

```
jx project enable
```

### Synopsis

Enables lighthouse pipelines in the current directory

### Examples

  ```bash
  # Enables lighthouse pipelines in the current dir
  jx project enable

  ```

### Options

```
  -b, --batch-mode            Runs in batch mode without prompting for user input
      --charts                Should we regen the charts
      --dir string            Specify the directory to import (default ".")
      --git-kind string       the kind of git server to connect to
      --git-server string     the git server URL to create the scm client
      --git-token string      the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string   the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                  help for enable
      --log-level string      Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --pack string           The name of the pipeline catalog pack to use. If none is specified it will be chosen based on matching the source code languages
      --verbose               Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```

### Source

[jenkins-x-plugins/jx-project](https://github.com/jenkins-x-plugins/jx-project)
