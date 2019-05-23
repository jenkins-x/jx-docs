---
date: 2019-05-23T10:22:50Z
title: "jx step create task"
slug: jx_step_create_task
url: /commands/jx_step_create_task/
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
      --clone-git-url string         Specify the git URL to clone to a temporary directory to get the source code
  -c, --context string               The pipeline context if there are multiple separate pipelines for a given branch
      --default-image string         Specify the docker image to use if there is no image specified for a step and there's no Pod Template (default "gcr.io/jenkinsxio/builder-maven")
      --delete-temp-dir              Deletes the temporary directory of cloned files if using the 'clone-git-url' option (default true)
  -d, --dir string                   The directory to query to find the projects .git directory
      --docker-registry string       The Docker Registry host name to use which is added as a prefix to docker images
      --docker-registry-org string   The Docker registry organisation. If blank the git repository owner is used
      --dry-run                      Disables creating the Pipeline resources in the kubernetes cluster and just outputs the generated Task to the console or output file, without side effects
      --duration duration            Retry duration when trying to create a PipelineRun (default 30s)
      --effective-pipeline           Just view the effective pipeline definition that would be created
  -e, --env stringArray              List of custom environment variables to be applied to resources that are created
  -h, --help                         help for task
      --image string                 Specify a custom image to use for the steps which overrides the image in the PodTemplates
      --kaniko-image string          The docker image for Kaniko (default "gcr.io/kaniko-project/executor:9912ccbf8d22bbafbf971124600fbb0b13b9cbd6")
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
      --service-account string       The Kubernetes ServiceAccount to use to run the pipeline (default "tekton-bot")
      --source string                The name of the source repository (default "source")
      --target-path string           The target path appended to /workspace/${source} to clone the source code
  -t, --trigger string               The kind of pipeline trigger (default "manual")
  -u, --url string                   The URL for the build pack Git repository
      --view                         Just view the steps that would be created
```

### Options inherited from parent commands

```
  -b, --batch-mode                Runs in batch mode without prompting for user input (default true)
      --install-dependencies      Enables automatic dependencies installation when required
      --log-level string          Sets the logging level (panic, fatal, error, warning, info, debug) (default "info")
      --no-brew                   Disables brew package manager on MacOS when installing binary dependencies
      --skip-auth-secrets-merge   Skips merging the secrets from local files with the secrets from Kubernetes cluster
      --verbose                   Enables verbose output
```

### SEE ALSO

* [jx step create](/commands/jx_step_create/)	 - create [command]

###### Auto generated by spf13/cobra on 23-May-2019
