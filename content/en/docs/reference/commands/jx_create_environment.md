---
date: 2020-05-20T00:55:49Z
title: "jx create environment"
slug: jx_create_environment
url: /commands/jx_create_environment/
description: list of jx commands
---
## jx create environment

Create a new Environment which is used to promote your Team's Applications via Continuous Delivery

### Synopsis

Creates a new Environment
  
An Environment maps to a Kubernetes cluster and namespace and is a place that your team's applications can be promoted to via Continuous Delivery. 

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
      --branches string              The branch pattern for branches to trigger CI/CD pipelines on the environment Git repository
  -c, --cluster string               The Kubernetes cluster for the Environment. If blank and a namespace is specified assumes the current cluster
      --domain string                Domain to expose ingress endpoints.  Example: jenkinsx.io
      --env-job-credentials string   The Jenkins credentials used by the GitOps Job for this environment
      --exposer string               Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
  -f, --fork-git-repo string         The Git repository used as the fork when creating new Environment Git repos (default "https://github.com/jenkins-x/default-environment-charts.git")
      --git-api-token string         The Git API token to use for creating new Git repositories
      --git-owner string             Git organisation / owner
      --git-provider-kind string     Kind of Git server. If not specified, kind of server will be autodetected from Git provider URL. Possible values: bitbucketcloud, bitbucketserver, gitea, gitlab, github, fakegit
      --git-provider-url string      The Git server URL to create new Git repositories inside
      --git-public                   Create new Git repositories as public
  -r, --git-ref string               The Git repo reference for the source code for GitOps based Environments
  -g, --git-url string               The Git clone URL for the source code for GitOps based Environments
      --git-username string          The Git username to use for creating new Git repositories
  -h, --help                         help for environment
      --ingress-class string         Used to set the ingress.class annotation in exposecontroller created ingress
      --keep-exposecontroller-job    Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -l, --label string                 The Environment label which is a descriptive string like 'Production' or 'Staging'
  -n, --name string                  The Environment resource name. Must follow the Kubernetes name conventions like Services, Namespaces
  -s, --namespace string             The Kubernetes namespace for the Environment
  -x, --no-gitops                    Disables the use of GitOps on the environment so that promotion is implemented by directly modifying the resources via helm instead of using a Git repository
  -o, --order int32                  The order weighting of the Environment so that they can be sorted by this order before name (default 100)
      --prefix string                Environment repo prefix, your Git repo will be of the form 'environment-$prefix-$envName' (default "jx")
  -p, --promotion string             The promotion strategy
      --prow                         Install and use Prow for environment promotion
      --pull-secrets string          A list of Kubernetes secret names that will be attached to the service account (e.g. foo, bar, baz)
      --remote                       Indicates the Environment resides in a separate cluster to the development cluster. If this is true then we don't perform release piplines in this git repository but we use the Environment Controller inside that cluster: https://jenkins-x.io/getting-started/multi-cluster/
  -u, --update                       Update environment if already exists
      --urltemplate string           For ingress; exposers can set the urltemplate to expose
      --vault                        Sets up a Hashicorp Vault for storing secrets during the cluster creation
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx create](/commands/jx_create/)	 - Create a new resource

###### Auto generated by spf13/cobra on 20-May-2020
