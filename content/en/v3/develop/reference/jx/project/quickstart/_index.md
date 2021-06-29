---
title: jx project quickstart
linktitle: quickstart
type: docs
description: "Create a new app from a Quickstart and import the generated code into Git and Jenkins for CI/CD ***Aliases**: arch*"
aliases:
  - jx-project_quickstart
---

### Usage

```
jx project quickstart
```

### Synopsis

Create a new project from a sample/starter (found in https://github.com/jenkins-x-quickstarts) 

This will create a new project for you from the selected template. It will exclude any work-in-progress repos (containing the "WIP-" pattern) 

For more documentation see: https://jenkins-x.io/developing/create-quickstart/

### Examples

  ```bash
  # create a new quickstart
  jx-project quickstart
  
  # creates a quickstart filtering on http based ones
  jx-project quickstart -f http

  ```
### Options

```
  -b, --batch-mode                     Runs in batch mode without prompting for user input
      --boot-secret-name string        The name of the boot secret (default "jx-boot")
      --canary                         should we use canary rollouts (progressive delivery) by default for this application. e.g. using a Canary deployment via flagger. Requires the installation of flagger and istio/gloo in your cluster
      --deploy-kind string             The kind of deployment to use for the project. Should be one of knative, default
      --dir string                     Specify the directory to import (default ".")
      --docker-registry-org string     The name of the docker registry organisation to use. If not specified then the Git provider organisation will be used
      --dry-run                        Performs local changes to the repo but skips the import into Jenkins X
      --env-name string                The name of the environment to create (only used for env projects)
      --env-strategy string            The promotion strategy of the environment to create (only used for env projects) (default "Never")
  -f, --filter string                  The text filter
      --framework string               The framework to filter on
      --git-host string                The Git server host if not using GitHub when pushing created project
      --git-kind string                the kind of git server to connect to
      --git-provider-url string        Deprecated: please use --git-server
      --git-server string              the git server URL to create the scm client
      --git-token string               the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string            the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
  -h, --help                           help for quickstart
      --hpa                            should we enable the Horizontal Pod Autoscaler for this application.
      --import-commit-message string   Specifies the initial commit message used when importing the project
      --jenkins string                 The name of the Jenkins server to import the project into
      --jenkinsfilerunner string       if you want to import into Jenkins X with Jenkinsfilerunner this argument lets you specify the container image to use
      --jx                             if you want to default to importing this project into Jenkins X instead of a Jenkins server if you have a mixed Jenkins X and Jenkins cluster
  -l, --language string                The language to filter on
      --log-level string               Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
      --machine-learning               Allow machine-learning quickstarts in results
      --name string                    Specify the Git repository name to import the project into (if it is not already in one)
      --no-collaborator                disables checking if the bot user is a collaborator. Only used if you have an issue with your git provider and this functionality in go-scm
      --no-dev-pr                      disables generating a Pull Request on the cluster git repository
      --no-import                      Disable import after the creation
      --no-pack                        Disable trying to default a Dockerfile and Helm Chart from the pipeline catalog pack
      --no-start                       disables starting a release pipeline when importing/creating a new project
      --operator-namespace string      The namespace where the git operator is installed (default "jx-git-operator")
      --org string                     Specify the Git provider organisation to import the project into (if it is not already in one)
  -g, --organisations stringArray      The GitHub organisations to query for quickstarts
  -o, --output-dir string              Directory to output the project to. Defaults to the current directory
      --owner string                   The owner to filter on
      --pack string                    The name of the pipeline catalog pack to use. If none is specified it will be chosen based on matching the source code languages
      --pipeline-catalog-dir string    The pipeline catalog directory you want to use instead of the buildPackGitURL in the dev Environment Team settings. Generally only used for testing pipelines
      --pr-poll-period duration        the time between polls of the Pull Request on the cluster environment git repository (default 20s)
      --pr-poll-timeout duration       the maximum amount of time we wait for the Pull Request on the cluster environment git repository (default 20m0s)
  -p, --project-name string            The project name (for use with -b batch mode)
      --quickstart-auth string         The auth mechanism used to authenticate with the git token to download the quickstarts. If not specified defaults to Basic but could be Bearer for bearer token auth
      --service-account string         The Kubernetes ServiceAccount to use to run the initial pipeline (default "tekton-bot")
  -t, --tag stringArray                The tags on the quickstarts to filter
      --use-default-git                use default git account
      --verbose                        Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --wait-for-pr                    waits for the Pull Request generated on the cluster environment git repository to merge (default true)
```



### Source

[jenkins-x-plugins/jx-project](https://github.com/jenkins-x-plugins/jx-project)
