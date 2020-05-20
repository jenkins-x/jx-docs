---
date: 2020-05-20T00:55:49Z
title: "jx preview"
slug: jx_preview
url: /commands/jx_preview/
description: list of jx commands
---
## jx preview

Creates or updates a Preview Environment for the current version of an application

### Synopsis

Creates or updates a Preview Environment for the given Pull Request or Branch. 

For more documentation on Preview Environments see: https://jenkins-x.io/about/features/#preview-environments

```
jx preview [flags]
```

### Examples

```
  # Create or updates the Preview Environment for the Pull Request
  jx preview
```

### Options

```
      --alias string                      The optional alias used in the 'requirements.yaml' file
  -a, --app string                        The Application to promote
      --build string                      The Build number which is used to update the PipelineActivity. If not specified its defaulted from  the '$BUILD_NUMBER' environment variable
  -c, --cluster string                    The Kubernetes cluster for the Environment. If blank and a namespace is specified assumes the current cluster
      --dev-namespace string              The Developer namespace where the preview command should run
      --dir string                        The source directory used to detect the git source URL and reference
      --domain string                     Domain to expose ingress endpoints.  Example: jenkinsx.io
      --exposer string                    Used to describe which strategy exposecontroller should use to access applications (default "Ingress")
  -f, --filter string                     The search filter to find charts to promote
  -r, --helm-repo-name string             The name of the helm repository that contains the app (default "releases")
  -u, --helm-repo-url string              The Helm Repository URL to use for the App
  -h, --help                              help for preview
      --ignore-local-file                 Ignores the local file system when deducing the Git repository
      --ingress-class string              Used to set the ingress.class annotation in exposecontroller created ingress
      --keep-exposecontroller-job         Prevents Helm deleting the exposecontroller Job and Pod after running.  Useful for debugging exposecontroller logs but you will need to manually delete the job if you update an environment
  -l, --label string                      The Environment label which is a descriptive string like 'Production' or 'Staging'
  -n, --name string                       The Environment resource name. Must follow the Kubernetes name conventions like Services, Namespaces
      --namespace string                  The Kubernetes namespace for the Environment
      --no-comment                        Disables commenting on the Pull Request after preview is created.
      --no-helm-update                    Allows the 'helm repo update' command if you are sure your local helm cache is up to date with the version you wish to promote
      --no-merge                          Disables automatic merge of promote Pull Requests
      --no-poll                           Disables polling for Pull Request or Pipeline status
      --no-wait                           Disables waiting for completing promotion after the Pull request is merged
      --pipeline string                   The Pipeline string in the form 'folderName/repoName/branch' which is used to update the PipelineActivity. If not specified its defaulted from  the '$BUILD_NUMBER' environment variable
      --post-preview-job-timeout string   The duration before we consider the post preview Jobs failed (default "2h")
      --post-preview-poll-time string     The amount of time between polls for the post preview Job status (default "10s")
      --pr string                         The Pull Request Name (e.g. 'PR-23' or just '23'
      --pr-url string                     The Pull Request URL
      --preview-health-timeout string     The amount of time to wait for the preview application to become healthy (default "5m")
      --pull-request-poll-time string     Poll time when waiting for a Pull Request to merge (default "20s")
      --release string                    The name of the helm release
      --skip-availability-check           Disables the mandatory availability check.
      --source-ref string                 The source code git ref (branch/sha)
  -s, --source-url string                 The source code git URL
  -t, --timeout string                    The timeout to wait for the promotion to succeed in the underlying Environment. The command fails if the timeout is exceeded or the promotion does not complete (default "1h")
      --urltemplate string                For ingress; exposers can set the urltemplate to expose
  -v, --version string                    The Version to promote
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx](/commands/jx/)	 - jx is a command line tool for working with Jenkins X

###### Auto generated by spf13/cobra on 20-May-2020
