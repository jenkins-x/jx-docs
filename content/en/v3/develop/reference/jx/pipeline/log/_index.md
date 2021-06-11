---
title: jx pipeline log
linktitle: log
type: docs
description: "Display a build log ***Aliases**: logs*"
aliases:
  - jx-pipeline_log
---

### Usage

```
jx pipeline log [flags]
```

### Synopsis

Display a build log

### Examples

  ```bash
  # Display a build log - with the user choosing which repo + build to view
  jx pipeline log
  
  # Pick a build to view the log based on the repo cheese
  jx pipeline log --repo cheese
  
  # Pick a pending Tekton build to view the log based
  jx pipeline log -p
  
  # Pick a pending Tekton build to view the log based on the repo cheese
  jx pipeline log --repo cheese -p
  
  # Pick a Tekton build for the 1234 Pull Request on the repo cheese
  jx pipeline log --repo cheese --branch PR-1234
  
  # View the build logs for a specific tekton build pod
  jx pipeline log --pod my-pod-name

  ```
### Options

```
  -b, --batch-mode               Runs in batch mode without prompting for user input
      --branch string            Filters the branch
      --build string             The build number to view
      --context string           Filters the context of the build
  -c, --current                  Display logs using current folder as repo name, and parent folder as owner
      --dir string               the directory to search for the .git to discover the git source URL (default ".")
      --fail-with-pod            Return an error if the pod fails
  -f, --filter string            Filters all the available jobs by those that contain the given text
  -g, --giturl string            The git URL to filter on. If you specify a link to a github repository or PR we can filter the query of build pods accordingly
  -h, --help                     help for log
      --log-level string         Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -o, --owner string             Filters the owner (person/organisation) of the repository
  -p, --pending                  Only include pipeline pods which are currently pending to choose from if no build name is supplied
      --pod string               The pod name to view
  -r, --repo string              Filters the build repository
  -t, --tail                     Tails the build log to the current terminal (default true)
      --verbose                  Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
  -w, --wait                     Waits for the build to start before failing
  -d, --wait-duration duration   Timeout period waiting for the given pipeline to be created (default 20m0s)
```



### Source

[jenkins-x-plugins/jx-pipeline](https://github.com/jenkins-x-plugins/jx-pipeline)
