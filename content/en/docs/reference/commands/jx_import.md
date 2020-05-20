---
date: 2020-05-20T00:55:49Z
title: "jx import"
slug: jx_import
url: /commands/jx_import/
description: list of jx commands
---
## jx import

Imports a local project or Git repository into Jenkins

### Synopsis

Imports a local folder or Git repository into Jenkins X.
  
      If you specify no other options or arguments then the current directory is imported.
      Or you can use '--dir' to specify a directory to import.
  
      You can specify the git URL as an argument.
  
      For more documentation see: [https://jenkins-x.io/docs/using-jx/creating/import/](https://jenkins-x.io/docs/using-jx/creating/import/)
  
See Also: 

  * jx create project : https://jenkins-x.io/commands/jx_create_project

```
jx import [flags]
```

### Examples

```
  # Import the current folder
  jx import
  
  # Import a different folder
  jx import /foo/bar
  
  # Import a Git repository from a URL
  jx import --url https://github.com/jenkins-x/spring-boot-web-example.git
  
  # Select a number of repositories from a GitHub organisation
  jx import --github --org myname
  
  # Import all repositories from a GitHub organisation selecting ones to not import
  jx import --github --org myname --all
  
  # Import all repositories from a GitHub organisation which contain the text foo
  jx import --github --org myname --all --filter foo
```

### Options

```
      --all                            If selecting projects to import from a Git provider this defaults to selecting them all
      --branches string                The branch pattern for branches to trigger CI/CD pipelines on
      --canary                         should we use canary rollouts (progressive delivery) by default for this application. e.g. using a Canary deployment via flagger. Requires the installation of flagger and istio/gloo in your cluster
  -c, --credentials string             The Jenkins credentials name used by the job
      --deploy-kind string             The kind of deployment to use for the project. Should be one of knative, default
      --disable-updatebot              disable updatebot-maven-plugin from attempting to fix/update the maven pom.xml
      --docker-registry-org string     The name of the docker registry organisation to use. If not specified then the Git provider organisation will be used
      --dry-run                        Performs local changes to the repo but skips the import into Jenkins X
      --external-jenkins-url string    The jenkins url that an external git provider needs to use
      --filter string                  If selecting projects to import from a Git provider this filters the list of repositories
      --git-api-token string           The Git API token to use for creating new Git repositories
      --git-provider-kind string       Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string        The Git server URL to create new Git repositories inside
      --git-public                     Create new Git repositories as public
      --git-username string            The Git username to use for creating new Git repositories
      --github                         If you wish to pick the repositories from GitHub to import
  -h, --help                           help for import
      --hpa                            should we enable the Horizontal Pod Autoscaler for this application.
      --import-commit-message string   Specifies the initial commit message used when importing the project
  -m, --import-mode string             The import mode to use. Should be one of Jenkinsfile, YAML
  -j, --jenkinsfile string             The name of the Jenkinsfile to use. If not specified then 'Jenkinsfile' will be used
      --list-packs                     list available draft packs
      --name string                    Specify the Git repository name to import the project into (if it is not already in one) (default "n")
      --no-draft                       Disable Draft from trying to default a Dockerfile and Helm Chart
      --no-jenkinsfile                 Disable defaulting a Jenkinsfile if its missing
      --org string                     Specify the Git provider organisation to import the project into (if it is not already in one)
      --pack string                    The name of the pack to use
      --scheduler string               The name of the Scheduler configuration to use for ChatOps when using Prow
  -u, --url string                     The git clone URL to clone into the current directory and then import
      --use-default-git                use default git account
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx](/commands/jx/)	 - jx is a command line tool for working with Jenkins X

###### Auto generated by spf13/cobra on 20-May-2020
