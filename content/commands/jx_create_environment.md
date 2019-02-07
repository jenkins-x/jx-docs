---
date: 2019-02-07T12:04:59Z
title: "jx create environment"
slug: jx_create_environment
url: /commands/jx_create_environment/
---
## jx create environment

Create a new Environment which is used to promote your Team's Applications via Continuous Delivery

### Synopsis

Creates a new Environment
  
An Environment maps to a Kubernetes cluster and namespace and is a place that your team's applications can be promoted to via Continous Delivery. 

You can optionally use GitOps to manage the configuration of an Environment by storing all configuration in a Git repository and then only changing it via Pull Requests and CI/CD. 

For more documentation on Environments see: https://jenkins-x.io/about/features/#environments

```
jx create environment [flags]
```

### Examples

```
  # Create a new Environment, prompting for the required data
  jx create env
  
  # Creates a new Environment passing in the required data on the command line
  jx create env -n prod -l Production --no-gitops --namespace my-prod
```

### Options

```
  -b, --batch-mode                   In batch mode the command never prompts for user input
      --branches string              The branch pattern for branches to trigger CI/CD pipelines on the environment Git repository
  -c, --cluster string               The Kubernetes cluster for the Environment. If blank and a namespace is specified assumes the current cluster
      --domain string                Domain to expose ingress endpoints.  Example: jenkinsx.io
      --env-job-credentials string   The Jenkins credentials used by the GitOps Job for this environment
      --exposer string               Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
  -f, --fork-git-repo string         The Git repository used as the fork when creating new Environment Git repos (default "https://github.com/jenkins-x/default-environment-charts.git")
      --git-api-token string         The Git API token to use for creating new Git repositories
      --git-owner string             Git organisation / owner
      --git-private                  Create new Git repositories as private
      --git-provider-kind string     Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string      The Git server URL to create new Git repositories inside (default "https://github.com")
  -r, --git-ref string               The Git repo reference for the source code for GitOps based Environments
  -g, --git-url string               The Git clone URL for the source code for GitOps based Environments
      --git-username string          The Git username to use for creating new Git repositories
      --headless                     Enable headless operation if using browser automation
  -h, --help                         help for environment
      --install-dependencies         Should any required dependencies be installed automatically
      --keep-exposecontroller-job    Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -l, --label string                 The Environment label which is a descriptive string like 'Production' or 'Staging'
      --log-level string             Logging level. Possible values - panic, fatal, error, warning, info, debug. (default "info")
  -n, --name string                  The Environment resource name. Must follow the Kubernetes name conventions like Services, Namespaces
  -s, --namespace string             The Kubernetes namespace for the Environment
      --no-brew                      Disables the use of brew on macOS to install or upgrade command line dependencies
  -x, --no-gitops                    Disables the use of GitOps on the environment so that promotion is implemented by directly modifying the resources via helm instead of using a Git repository
  -o, --order int32                  The order weighting of the Environment so that they can be sorted by this order before name (default 100)
      --prefix string                Environment repo prefix, your Git repo will be of the form 'environment-$prefix-$envName' (default "jx")
  -p, --promotion string             The promotion strategy
      --prow                         Install and use Prow for environment promotion
      --pull-secrets string          The pull secrets the service account created should have (useful when deploying to your own private registry): provide multiple pull secrets by providing them in a singular block of quotes e.g. --pull-secrets "foo, bar, baz"
      --skip-auth-secrets-merge      Skips merging a local git auth yaml file with any pipeline secrets that are found
      --urltemplate string           For ingress; exposers can set the urltemplate to expose
      --vault                        Sets up a Hashicorp Vault for storing secrets during the cluster creation
      --verbose                      Enable verbose logging
```

### SEE ALSO

* [jx create](/commands/jx_create/)	 - Create a new resource

###### Auto generated by spf13/cobra on 7-Feb-2019
