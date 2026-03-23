---
title: jx pipeline previews
linktitle: previews
type: docs
description: "Display one or more Preview Environments ***Aliases**: preview*"
aliases:
  - jx-pipeline_previews
---

### Usage

```
jx pipeline previews
```

### Synopsis

Display one or more preview environments.
  
See Also: 

  * jx get env : https://jenkins-x.io/commands/jx_get_env

### Examples

  ```bash
  # List all preview environments
  jx get previews
  
  # View the current preview environment URL
  # inside a CI pipeline
  jx get preview --current

  ```
### Options

```
  -c, --current         Output the URL of the current Preview application the current pipeline just deployed
  -h, --help            help for previews
  -o, --output string   The output format such as 'yaml'
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
