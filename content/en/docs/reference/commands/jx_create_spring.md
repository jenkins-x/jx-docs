---
date: 2019-11-06T07:36:05Z
title: "jx create spring"
slug: jx_create_spring
url: /commands/jx_create_spring/
---
## jx create spring

Create a new Spring Boot application and import the generated code into Git and Jenkins for CI/CD

### Synopsis

Creates a new Spring Boot application and then optionally setups CI/CD pipelines and GitOps promotion.
  
      You can see a demo of this command here: [https://jenkins-x.io/demos/create_spring/](https://jenkins-x.io/demos/create_spring/)
  
      For more documentation see: [https://jenkins-x.io/developing/create-spring/](https://jenkins-x.io/developing/create-spring/)
  
See Also: 

  * jx create project : https://jenkins-x.io/commands/jx_create_project

```
jx create spring [flags]
```

### Examples

```
  # Create a Spring Boot application where you use the terminal to pick the values
  jx create spring
  
  # Creates a Spring Boot application passing in the required dependencies
  jx create spring -d web -d actuator
  
  # To pick the advanced options (such as what package type maven-project/gradle-project) etc then use
  jx create spring -x
  
  # To create a gradle project use:
  jx create spring --type gradle-project
```

### Options

```
  -x, --advanced                       Advanced mode can show more detailed forms for some resource kinds like springboot
  -a, --artifact string                Artifact ID to generate
  -t, --boot-version string            Spring Boot version
      --branches string                The branch pattern for branches to trigger CI/CD pipelines on
      --credentials string             The Jenkins credentials name used by the job
  -d, --dep stringArray                Spring Boot dependencies
      --deploy-kind string             The kind of deployment to use for the project. Should be one of knative, default
      --disable-updatebot              disable updatebot-maven-plugin from attempting to fix/update the maven pom.xml
      --docker-registry-org string     The name of the docker registry organisation to use. If not specified then the Git provider organisation will be used
      --dry-run                        Performs local changes to the repo but skips the import into Jenkins X
      --external-jenkins-url string    The jenkins url that an external git provider needs to use
      --git-api-token string           The Git API token to use for creating new Git repositories
      --git-provider-kind string       Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string        The Git server URL to create new Git repositories inside (default "https://github.com")
      --git-public                     Create new Git repositories as public
      --git-username string            The Git username to use for creating new Git repositories
  -g, --group string                   Group ID to generate
  -h, --help                           help for spring
      --import-commit-message string   Specifies the initial commit message used when importing the project
  -m, --import-mode string             The import mode to use. Should be one of Jenkinsfile, YAML
  -j, --java-version string            Java version
      --jenkinsfile string             The name of the Jenkinsfile to use. If not specified then 'Jenkinsfile' will be used
  -k, --kind stringArray               Default dependency kinds to choose from (default [Core,Web,Template Engines,SQL,I/O,Ops,Spring Cloud GCP,Azure,Cloud Contract,Cloud AWS,Cloud Messaging,Cloud Tracing])
  -l, --language string                Language to generate
      --list-packs                     list available draft packs
      --name string                    Specify the Git repository name to import the project into (if it is not already in one)
      --no-draft                       Disable Draft from trying to default a Dockerfile and Helm Chart
      --no-import                      Disable import after the creation
      --no-jenkinsfile                 Disable defaulting a Jenkinsfile if its missing
      --org string                     Specify the Git provider organisation to import the project into (if it is not already in one)
  -o, --output-dir string              Directory to output the project to. Defaults to the current directory
      --pack string                    The name of the pack to use
  -p, --packaging string               Packaging
      --scheduler string               The name of the Scheduler configuration to use for ChatOps when using Prow
      --type string                    Project Type (such as maven-project or gradle-project)
      --use-default-git                use default git account
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output
```

### SEE ALSO

* [jx create](/commands/jx_create/)	 - Create a new resource

###### Auto generated by spf13/cobra on 6-Nov-2019
