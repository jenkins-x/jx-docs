---
title: jx admin create
linktitle: create
type: docs
description: 
aliases:
  - jx-admin_create
---

## jx-admin create

Creates a new git repository for a new Jenkins X installation

### Usage

```
jx-admin create
```

### Synopsis

Creates a new git repository for a new Jenkins X installation

### Examples

  # create a new git repository which we can then boot up
  jx-admin create

### Options

```
      --add jx-apps.yml              The apps/charts to add to the jx-apps.yml file to add the apps
      --approver stringArray         the git user names of the approvers for the environments
      --autoupdate-schedule string   the cron schedule for auto upgrading your cluster
      --autoupgrade                  enables or disables auto upgrades
  -b, --batch-mode                   Enables batch mode which avoids prompting for user input
      --bucket-backups string        the bucket URL to store backups
      --bucket-logs string           the bucket URL to store logs
      --bucket-repo string           the bucket URL to store repository artifacts
      --bucket-reports string        the bucket URL to store reports. If not specified default to te logs bucket
      --canary                       enables Canary deployment of apps by default
      --chart string                 the chart name to use to install the git operator (default "jx3/jx-git-operator")
      --chart-version string         override the helm chart version used for the git operator
  -c, --cluster string               configures the cluster name
      --dev-git-kind string          The kind of git server for the development environment
      --dev-git-url string           The git URL of the development environment if you are creating a remote staging/production cluster. If specified this will create a Pull Request on the development cluster
      --dir string                   The directory used to create the development environment git repository inside. If not specified a temporary directory will be used
  -d, --domain string                configures the domain name
      --dry-run                      if enabled just display the helm command that will run but don't actually do anything
  -e, --env string                   The name of the remote environment to create
      --env-git-owner string         the git owner (organisation or user) used to own the git repositories for the environments
      --env-git-public               enables or disables whether the environment repositories should be public
      --env-remote                   if enables then all other environments than dev (staging & production by default) will be configured to be in remote clusters
      --extdns-sa string             configures the External DNS service account name
      --git-kind string              the kind of git repository to use. Possible values: bitbucketcloud, bitbucketserver, gitea, github, gitlab
      --git-name string              the name of the git repository
      --git-public                   enables or disables whether the project repositories should be public
      --git-server string            the git server host such as https://github.com or https://gitlab.com
      --git-token string             the git token used to operate on the git repository
  -h, --help                         help for create
      --hpa                          enables HPA deployment of apps by default
      --initial-git-url string       The git URL to clone to fetch the initial set of files for a helm 3 / helmfile based git configuration if this command is not run inside a git clone or against a GitOps based cluster
      --kaniko-sa string             configures the Kaniko service account name
      --name string                  the helm release name t ouse (default "jxgo")
      --no-operator                  If enabled then don't try to install the git operator after creating the git repository
      --operator-namespace string    The name of the remote environment to create (default "jx-git-operator")
      --out string                   the name of the file to save with the created git URL inside
      --project string               configures the Google Project ID
  -p, --provider string              configures the kubernetes provider.  Supported providers: aks, alibaba, aws, eks, gke, icp, iks, jx-infra, kubernetes, oke, openshift, pks
      --region string                configures the cloud region
      --registry string              configures the host name of the container registry
      --remove jx-apps.yml           The apps/charts to remove from the jx-apps.yml file to remove the apps
      --repo string                  the name of the development git repository to create
      --repository string            the artifact repository. Possible values are: none, bucketrepo, nexus, artifactory
  -r, --requirements string          The 'jx-requirements.yml' file to use in the created development git repository. This file may be created via terraform
      --secret string                configures the secret storage kind. Possible values: local, vault
      --tls                          enable TLS for Ingress
      --tls-email string             the TLS email address to enable TLS on the domain
      --tls-production               the LetsEncrypt production service, defaults to true, set to false to use the Staging service (default true)
      --tls-secret string            [optional] the custom Kubernetes Secret name for the TLS certificate
      --vault-bucket string          specify the vault bucket
      --vault-disable-url-discover   override the default lookup of the Vault URL, could be incluster service or external ingress
      --vault-key string             specify the vault key
      --vault-keyring string         specify the vault key ring
      --vault-name string            specify the vault name
      --vault-recreate-bucket        enables or disables whether to rereate the secret bucket on boot
      --vault-sa string              specify the vault Service Account name
  -z, --zone string                  configures the cloud zone
```

### SEE ALSO

* [jx-admin](..)	 - commands for creating and upgrading Jenkins X environments using GitOps

###### Auto generated by spf13/cobra on 1-Feb-2021
