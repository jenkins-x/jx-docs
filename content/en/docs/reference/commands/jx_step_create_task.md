---
date: 2020-05-20T00:55:49Z
title: "jx step create task"
slug: jx_step_create_task
url: /commands/jx_step_create_task/
description: list of jx commands
---
## jx step create task

Creates a Tekton PipelineRun for the current folder or given build pack

### Synopsis

Creates a Tekton Pipeline Run for a project

```
jx step create task [flags]
```

### Examples

```
  # create a Tekton Pipeline Run and render to the console
  jx step create task
  
  # create a Tekton Pipeline Task
  jx step create task -o mytask.yaml
  
  # view the steps that would be created
  jx step create task --view
```

### Options

```
      --branch string                The git branch to trigger the build in. Defaults to the current local branch name
      --branch-as-revision           Use the provided branch as the revision for release pipelines, not the version tag
      --build-number string          The build number
      --clone-dir string             Specify the directory of the directory containing the git clone
      --clone-git-url string         Specify the git URL to clone to a temporary directory to get the source code
  -c, --context string               The pipeline context if there are multiple separate pipelines for a given branch
      --default-image string         Specify the docker image to use if there is no image specified for a step and there's no Pod Template (default "gcr.io/jenkinsxio/builder-maven")
      --delete-temp-dir              Deletes the temporary directory of cloned files if using the 'clone-git-url' option (default true)
      --docker-registry string       The Docker Registry host name to use which is added as a prefix to docker images
      --docker-registry-org string   The Docker registry organisation. If blank the git repository owner is used
      --dry-run                      Disables creating the Pipeline resources in the kubernetes cluster and just outputs the generated Task to the console or output file, without side effects
      --duration duration            Retry duration when trying to create a PipelineRun (default 30s)
      --effective-pipeline           Just view the effective pipeline definition that would be created
      --end-step string              When in interpret mode this specifies the step to end at
  -e, --env stringArray              List of custom environment variables to be applied to resources that are created
  -h, --help                         help for task
      --image string                 Specify a custom image to use for the steps which overrides the image in the PodTemplates
      --interpret                    Enable interpret mode. Rather than spinning up Tekton CRDs to create a Pod just invoke the commands in the current shell directly. Useful for bootstrapping installations of Jenkins X and tekton using a pipeline before you have installed Tekton.
      --kaniko-image string          The docker image for Kaniko (default "gcr.io/kaniko-project/executor:v0.22.0")
      --kaniko-secret string         The name of the kaniko secret (default "kaniko-secret")
      --kaniko-secret-key string     The key in the Kaniko Secret to mount (default "kaniko-secret")
      --kaniko-secret-mount string   The mount point of the Kaniko secret (default "/kaniko-secret/secret.json")
  -k, --kind string                  The kind of pipeline to create such as: release, pullrequest, feature (default "release")
  -l, --label stringArray            List of custom labels to be applied to resources that are created
      --no-apply                     Disables creating the Pipeline resources in the kubernetes cluster and just outputs the generated Task to the console or output file
      --no-kaniko                    Disables using kaniko directly for building docker images
      --no-release-prepare           Disables creating the release version number and tagging git and triggering the release pipeline from the new tag
  -o, --output string                The directory to write the output to as YAML. Defaults to 'out' (default "out")
  -p, --pack string                  The build pack name. If none is specified its discovered from the source code
      --pr-number string             If a Pull Request this is it's number
      --project-id string            The cloud project ID. If not specified we default to the install project
  -r, --ref string                   The Git reference (branch,tag,sha) in the Git repository to use
      --revision string              The git revision to checkout, can be a branch name or git sha
      --semantic-release             Enable semantic releases
      --service-account string       The Kubernetes ServiceAccount to use to run the pipeline (default "tekton-bot")
      --source string                The name of the source repository (default "source")
      --start-step string            When in interpret mode this specifies the step to start at
      --target-path string           The target path appended to /workspace/${source} to clone the source code
  -u, --url string                   The URL for the build pack Git repository
      --view                         Just view the steps that would be created
```

### Options inherited from parent commands

```
  -b, --batch-mode   Runs in batch mode without prompting for user input (default true)
      --verbose      Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warning, info, debug, trace
```

### SEE ALSO

* [jx step create](/commands/jx_step_create/)	 - create [command]

###### Auto generated by spf13/cobra on 20-May-2020
