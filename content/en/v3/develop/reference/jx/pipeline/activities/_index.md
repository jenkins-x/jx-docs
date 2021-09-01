---
title: jx pipeline activities
linktitle: activities
type: docs
description: "Display one or more Activities on projects ***Aliases**: activity,act*"
aliases:
  - jx-pipeline_activities
---

### Usage

```
jx pipeline activities
```

### Synopsis

Display the current activities for one or more projects.

### Examples

  ```bash
  # List the current activities for all applications in the current team
  jx pipeline activities
  
  # List the current activities for application 'foo'
  jx pipeline act -f foo
  
  # Watch the activities for application 'foo'
  jx pipeline act -f foo -w

  ```

### Options

```
  -b, --batch-mode         Runs in batch mode without prompting for user input
      --build string       The build number to filter on
  -f, --filter string      Text to filter the pipeline names
  -h, --help               help for activities
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -s, --sort               Sort activities by timestamp
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -w, --watch              Whether to watch the activities for changes
```

### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
