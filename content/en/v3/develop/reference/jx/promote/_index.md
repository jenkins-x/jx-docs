---
title: jx promote
linktitle: promote
type: docs
description: 
aliases:
  - promote
---

## promote

Promotes a version of an application to an Environment

### Usage

```
promote [application]
```

### Synopsis

Promotes a version of an application to zero to many permanent environments. 

For more documentation see: https://jenkins-x.io/docs/getting-started/promotion/

### Examples

  # Promote a version of the current application to staging
  # discovering the application name from the source code
  jx promote --version 1.2.3 --env staging
  
  # Promote a version of the myapp application to production
  jx promote --app myapp --version 1.2.3 --env production
  
  # To search for all the available charts for a given name use -f.
  # e.g. to find a redis chart to install
  jx promote -f redis
  
  # To promote a postgres chart using an alias
  jx promote -f postgres --alias mydb
  
  # To create or update a Preview Environment please see the 'jx preview' command if you are inside a git clone of a repo
  jx preview

### Options

```
      --alias string                         The optional alias used in the 'requirements.yaml' file
      --all                                  Promote to all automatic and manual environments in order using a draft PR for manual promotion environments
      --all-auto                             Promote to all automatic environments in order
  -a, --app string                           The Application to promote
      --app-git-url string                   The Git URL of the application being promoted. Only required if using file or kpt rules
      --auto-merge                           If enabled add the 'updatebot' label to tell lighthouse to eagerly merge. Usually the Pull Request pipeline will add this label during the Pull Request pipeline after any extra generation/commits have been done and the PR is valid
  -b, --batch-mode                           Enables batch mode which avoids prompting for user input
      --build string                         The Build number which is used to update the PipelineActivity. If not specified its defaulted from  the '$BUILD_NUMBER' environment variable
      --default-app-namespace string         The default namespace for promoting to remote clusters for the first
  -e, --env string                           The Environment to promote to
  -f, --filter string                        The search filter to find charts to promote
      --git-token string                     Git token used to clone the development environment. If not specified its loaded from the git credentials file
      --git-user string                      Git username used to clone the development environment. If not specified its loaded from the git credentials file
  -r, --helm-repo-name string                The name of the helm repository that contains the app (default "releases")
  -u, --helm-repo-url string                 The Helm Repository URL to use for the App
  -h, --help                                 help for promote
      --ignore-local-file                    Ignores the local file system when deducing the Git repository
  -n, --namespace string                     The Namespace to promote to
      --no-helm-update                       Allows the 'helm repo update' command if you are sure your local helm cache is up to date with the version you wish to promote
      --no-merge                             Disables automatic merge of promote Pull Requests
      --no-poll                              Disables polling for Pull Request or Pipeline status
      --no-pr-group                          Disables grouping Auto promotions to different Environments in the same git repository within a single Pull Request which causes them to use separate Pull Requests
      --no-wait                              Disables waiting for completing promotion after the Pull request is merged
      --pipeline string                      The Pipeline string in the form 'folderName/repoName/branch' which is used to update the PipelineActivity. If not specified its defaulted from  the '$BUILD_NUMBER' environment variable
      --promotion-environments stringArray   The environments considered for promotion
      --pull-request-poll-time string        Poll time when waiting for a Pull Request to merge (default "20s")
      --release string                       The name of the helm release
  -t, --timeout string                       The timeout to wait for the promotion to succeed in the underlying Environment. The command fails if the timeout is exceeded or the promotion does not complete (default "1h")
  -v, --version string                       The Version to promote. If no version is specified it defaults to $VERSION which is usually populated in a pipeline. If no value can be found you will be prompted to pick the version
      --version-file string                  the file to load the version from if not specified directly or via a $VERSION environment variable. Defaults to VERSION in the current dir
```

###### Auto generated by spf13/cobra on 25-Mar-2021
