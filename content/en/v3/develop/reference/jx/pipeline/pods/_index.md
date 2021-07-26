---
title: jx pipeline pods
linktitle: pods
type: docs
description: "Displays the build pods and their details ***Aliases**: pod*"
aliases:
  - jx-pipeline_pods
---

### Usage

```
jx pipeline pods [flags]
```

### Synopsis

Display the Tekton build pods

### Examples

  ```bash
  # List all the Tekton build pods
  jx pipeline pods
  
  # List all the pending Tekton build pods
  jx pipeline pods -p
  
  # List all the Tekton build pods for a given repository
  jx pipeline pods --repo cheese
  
  # List all the pending Tekton build pods for a given repository
  jx pipeline pods --repo cheese -p
  
  # List all the Tekton build pods for a given Pull Request
  jx pipeline pods --repo cheese --branch PR-1234

  ```
### Options

```
  -b, --batch-mode         Runs in batch mode without prompting for user input
      --branch string      Filters the branch
      --build string       The build number to view
      --context string     Filters the context of the build
  -e, --env string         The name of the environment to view pipelines for the git repository
  -f, --filter string      Filters all the available jobs by those that contain the given text
  -g, --giturl string      The git URL to filter on. If you specify a link to a github repository or PR we can filter the query of build pods accordingly
  -h, --help               help for pods
      --log-level string   Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string   The namespace to look for the build pods. Defaults to the current namespace
  -o, --owner string       Filters the owner (person/organisation) of the repository
  -p, --pending            Only include pipeline pods which are currently pending to choose from if no build name is supplied
      --pod string         The pod name to view
  -r, --repo string        Filters the build repository
      --verbose            Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
