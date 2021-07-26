---
title: jx pipeline env
linktitle: env
type: docs
description: "Displays the environment variables for a step in a chosen pipeline pod ***Aliases**: environment*"
aliases:
  - jx-pipeline_env
---

### Usage

```
jx pipeline env [flags]
```

### Synopsis

Display the Pipeline step environment variables for a step in a chosen pipeline pod

### Examples

  ```bash
  # Pick the pipeline pod and step to view the environment variables
  jx pipeline env
  
  # Pick the pipeline pod for a repository and step to view the environment variables
  jx pipeline env --repo cheese
  
  # Pick the pipeline pod for a repository, a given Pull Request and a step to view the environment variables
  jx pipeline env --repo cheese --branch PR-1234
  
  # Generate IDEA based environment variable output you can copy/paste into the Run/Debug UI
  jx pipeline env -t idea

  ```
### Options

```
  -b, --batch-mode            Runs in batch mode without prompting for user input
      --branch string         Filters the branch
      --build string          The build number to view
      --context string        Filters the context of the build
  -e, --env string            The name of the environment to view pipelines for the git repository
  -x, --exclude stringArray   The environment variable names to exclude.
  -f, --filter string         Filters all the available jobs by those that contain the given text
  -t, --format string         The output format. Valid values are 'shell' or 'idea' (default "shell")
  -g, --giturl string         The git URL to filter on. If you specify a link to a github repository or PR we can filter the query of build pods accordingly
  -h, --help                  help for env
      --log-level string      Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string      The namespace to look for the build pods. Defaults to the current namespace
  -o, --owner string          Filters the owner (person/organisation) of the repository
  -p, --pending               Only include pipeline pods which are currently pending to choose from if no build name is supplied
      --pod string            The pod name to view
  -r, --repo string           Filters the build repository
      --verbose               Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
