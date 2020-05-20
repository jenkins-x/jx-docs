---
date: 2020-05-20T00:55:49Z
title: "jx create mlquickstart"
slug: jx_create_mlquickstart
url: /commands/jx_create_mlquickstart/
description: list of jx commands
---
## jx create mlquickstart

Create a new machine learning app from a set of quickstarts and import the generated code into Git and Jenkins for CI/CD

### Synopsis

Create a new machine learning project from a sample/starter (found in https://github.com/machine-learning-quickstarts)
  
      This will create two new projects for you from the selected template. One for training and one for deploying a model as a service.
      It will exclude any work-in-progress repos (containing the "WIP-" pattern)
  
      For more documentation see: [https://jenkins-x.io/developing/create-mlquickstart/](https://jenkins-x.io/developing/create-mlquickstart/)
  
See Also: 

  * jx create project : https://jenkins-x.io/commands/jx_create_project

```
jx create mlquickstart [flags]
```

### Examples

```
  Create a new machine learning project from a sample/starter (found in https://github.com/machine-learning-quickstarts)
  
  This will create a new machine learning project for you from the selected template.
  It will exclude any work-in-progress repos (containing the "WIP-" pattern)
  
  jx create mlquickstart
  
  jx create mlquickstart -f pytorch
```

### Options

```
      --branches string                The branch pattern for branches to trigger CI/CD pipelines on
      --canary                         should we use canary rollouts (progressive delivery) by default for this application. e.g. using a Canary deployment via flagger. Requires the installation of flagger and istio/gloo in your cluster
      --credentials string             The Jenkins credentials name used by the job
      --deploy-kind string             The kind of deployment to use for the project. Should be one of knative, default
      --disable-updatebot              disable updatebot-maven-plugin from attempting to fix/update the maven pom.xml
      --docker-registry-org string     The name of the docker registry organisation to use. If not specified then the Git provider organisation will be used
      --dry-run                        Performs local changes to the repo but skips the import into Jenkins X
      --external-jenkins-url string    The jenkins url that an external git provider needs to use
  -f, --filter string                  The text filter
      --framework string               The framework to filter on
      --git-api-token string           The Git API token to use for creating new Git repositories
      --git-host string                The Git server host if not using GitHub when pushing created project
      --git-provider-kind string       Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string        The Git server URL to create new Git repositories inside
      --git-public                     Create new Git repositories as public
      --git-username string            The Git username to use for creating new Git repositories
  -h, --help                           help for mlquickstart
      --hpa                            should we enable the Horizontal Pod Autoscaler for this application.
      --import-commit-message string   Specifies the initial commit message used when importing the project
  -m, --import-mode string             The import mode to use. Should be one of Jenkinsfile, YAML
      --jenkinsfile string             The name of the Jenkinsfile to use. If not specified then 'Jenkinsfile' will be used
  -l, --language string                The language to filter on
      --list-packs                     list available draft packs
      --name string                    Specify the Git repository name to import the project into (if it is not already in one)
      --no-draft                       Disable Draft from trying to default a Dockerfile and Helm Chart
      --no-import                      Disable import after the creation
      --no-jenkinsfile                 Disable defaulting a Jenkinsfile if its missing
      --org string                     Specify the Git provider organisation to import the project into (if it is not already in one)
  -g, --organisations stringArray      The GitHub organisations to query for quickstarts
  -o, --output-dir string              Directory to output the project to. Defaults to the current directory
      --owner string                   The owner to filter on
      --pack string                    The name of the pack to use
  -p, --project-name string            The project name (for use with -b batch mode)
      --scheduler string               The name of the Scheduler configuration to use for ChatOps when using Prow
  -t, --tag stringArray                The tags on the quickstarts to filter
      --use-default-git                use default git account
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx create](/commands/jx_create/)	 - Create a new resource

###### Auto generated by spf13/cobra on 20-May-2020
