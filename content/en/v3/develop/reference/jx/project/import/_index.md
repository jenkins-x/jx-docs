---
title: jx project import
linktitle: import
type: docs
description: "Imports a local project or Git repository into Jenkins"
aliases:
  - jx-project_import
---

### Usage

```
jx project import
```

### Synopsis

Imports a local folder or Git repository into Jenkins X. 

If you specify no other options or arguments then the current directory is imported. Or you can use '--dir' to specify a directory to import. 

You can specify the git URL as an argument. 

For more documentation see: https://jenkins-x.io/docs/using-jx/creating/import/

### Examples

  ```bash
  # Import the current folder
  jx-project import
  
  # Import a different folder
  jx-project import /foo/bar
  
  # Import a Git repository from a URL
  jx-project import --url https://github.com/jenkins-x/spring-boot-web-example.git
  
  # Select a number of repositories from a GitHub organisation
  jx-project import --github --org myname
  
  # Import all repositories from a GitHub organisation selecting ones to not import
  jx-project import --github --org myname --all
  
  # Import all repositories from a GitHub organisation which contain the text foo
  jx-project import --github --org myname --all --filter foo

  ```
### Options

```
      --all                            If selecting projects to import from a Git provider this defaults to selecting them all
  -b, --batch-mode                     Runs in batch mode without prompting for user input
      --boot-secret-name string        The name of the boot secret (default "jx-boot")
      --canary                         should we use canary rollouts (progressive delivery) by default for this application. e.g. using a Canary deployment via flagger. Requires the installation of flagger and istio/gloo in your cluster
      --deploy-kind string             The kind of deployment to use for the project. Should be one of knative, default
      --dir string                     Specify the directory to import (default ".")
      --docker-registry-org string     The name of the docker registry organisation to use. If not specified then the Git provider organisation will be used
      --dry-run                        Performs local changes to the repo but skips the import into Jenkins X
      --env-name string                The name of the environment to create (only used for env projects)
      --env-strategy string            The promotion strategy of the environment to create (only used for env projects) (default "Never")
      --git-kind string                the kind of git server to connect to
      --git-provider-url string        Deprecated: please use --git-server
      --git-server string              the git server URL to create the scm client
      --git-token string               the git token used to operate on the git repository. If not specified it's loaded from the git credentials file
      --git-username string            the git username used to operate on the git repository. If not specified it's loaded from the git credentials file
      --github                         If you wish to pick the repositories from GitHub to import
  -h, --help                           help for import
      --hpa                            should we enable the Horizontal Pod Autoscaler for this application.
      --import-commit-message string   Specifies the initial commit message used when importing the project
      --jenkins string                 The name of the Jenkins server to import the project into
      --jenkinsfilerunner string       if you want to import into Jenkins X with Jenkinsfilerunner this argument lets you specify the container image to use
      --jx                             if you want to default to importing this project into Jenkins X instead of a Jenkins server if you have a mixed Jenkins X and Jenkins cluster
      --log-level string               Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --name string                    Specify the Git repository name to import the project into (if it is not already in one)
      --nested-repo                    Specify if using nested repositories (in gitlab)
      --no-collaborator                disables checking if the bot user is a collaborator. Only used if you have an issue with your git provider and this functionality in go-scm
      --no-dev-pr                      disables generating a Pull Request on the cluster git repository
      --no-pack                        Disable trying to default a Dockerfile and Helm Chart from the pipeline catalog pack
      --no-start                       disables starting a release pipeline when importing/creating a new project
      --operator-namespace string      The namespace where the git operator is installed (default "jx-git-operator")
      --org string                     Specify the Git provider organisation to import the project into (if it is not already in one)
      --pack string                    The name of the pipeline catalog pack to use. If none is specified it will be chosen based on matching the source code languages
      --pipeline-catalog-dir string    The pipeline catalog directory you want to use instead of the buildPackGitURL in the dev Environment Team settings. Generally only used for testing pipelines
      --pr-poll-period duration        the time between polls of the Pull Request on the cluster environment git repository (default 20s)
      --pr-poll-timeout duration       the maximum amount of time we wait for the Pull Request on the cluster environment git repository (default 20m0s)
      --service-account string         The Kubernetes ServiceAccount to use to run the initial pipeline (default "tekton-bot")
  -u, --url string                     The git clone URL to clone into the current directory and then import
      --use-default-git                use default git account
      --verbose                        Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
      --wait-for-pr                    waits for the Pull Request generated on the cluster environment git repository to merge (default true)
```



### Source

[jenkins-x-plugins/jx-project](https://github.com/jenkins-x-plugins/jx-project)
