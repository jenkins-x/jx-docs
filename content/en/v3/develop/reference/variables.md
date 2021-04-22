---
title: Variables
linktitle: Variables
type: docs
description: Environment variables available inside Pipelines
weight: 300
---

### Environment Variables

The following tekton parameters and environment variables are available inside the pipeline catalog. They are populated by [lighthouse](https://github.com/jenkins-x/lighthouse)

| Variable | Description |
 | --- | --- |
| BUILD_ID | a unique long number for this build |
| JOB_NAME | the name of the build which matches the name in the `presubmit` or `postsubmit` in your [lighthouse](https://github.com/jenkins-x/lighthouse) `triggers.yaml` |
| JOB_SPEC|  is of the form `type:presumit` or `type:postsubmit` so you know what kind of job you are inside |
| PULL_BASE_REF | the base branch name. e.g. `master` or `main` |
| PULL_BASE_SHA | the base git SHA being built |
| REPO_NAME | the name of the git repository |
| REPO_OWNER | the owner of the git repository (a user or organisation) |
| REPO_URL | the git URL to clone the repository being built |

Pull Requests `presubmit` also have the following values:

| Variable | Description |
| --- | --- |
| PULL_NUMBER | the number of the pull request |
| PULL_PULL_REF | the git reference of the pull request; something like `refs/pull/123/head` |
| PULL_PULL_SHA |  the git SHA of the pull request |

#### Additional environment variables

If your pipeline runs the [jx gitops variables](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_variables.md) command it will lazily create the `.jx/variables.sh` script which will default a bunch more environment variables if they are not already populated in your git repository.

**NOTE** that these variables are dynamically created during the execution of the pipeline pod; so to access them you must `source .jx/variables.sh` inside your step.

So that your step looks something like this...

```yaml
- image: gcr.io/jenkinsxio/jx:latest
  name: my-step
  script: |
    #!/usr/bin/env bash
    source .jx/variables.sh
    echo "now we can use variables like this: ${VERSION}"
```

Available variables:

| Variable | Description |
| --- | --- |
| APP_NAME | the name of the application which defaults to the `$REPO_NAME` |
| BRANCH_NAME | is really the pull request name so something like `PR-123` |
| BUILD_NUMBER | the human readable short build number relative to the repository and branch. So builds start at 1 and go up incrementally |
| DOMAIN | the domain name for your ingress (from `spec.ingress.domain` in your `jx-requirements.yml` file) |
| GIT_BRANCH | the real git branch being used (e.g. if on a Pull Request) |
| DOCKERFILE_PATH |  the location of the `Dockerfile` if it exists |
| DOCKER_REGISTRY | the host name of the registry being used for image builds |
| DOCKER_REGISTRY_ORG | the owner in the container registry (user name or organisation) to push images |
| JENKINS_X_URL | the URL to view the current pipeline in the [dashboard](/v3/develop/ui/dashboard/) |
| JX_CHART_REPOSITORY | the URL of the helm chart repository to use |
| NAMESPACE_SUB_DOMAIN | the sub domain prefix added to `$DOMAIN` to create ingresses. e.g. `myservice.${NAMESPACE_SUB_DOMAIN}${DOMAIN}` |
| PIPELINE_KIND | the kind of pipeline being run `pullrequest` or `release` |
| PUSH_CONTAINER_REGISTRY | generally the same as `DOCKER_REGISTRY` but sometimes can be different (e.g. if using minikube/docker you could push to a local registry) |  
| VERSION | the version number used for releases (and used to tag images and git etc) or the preview version for pull requests |

#### Additional Pull Request variables

| Variable | Description |
| --- | --- |
| PR_BASE_REF | the git branch which a Pull Request pipeline will |   
| PR_BASE_SHA | the git sha which the Pull Request has been rebased on from the base branch the PR will merge to | 
| PR_HEAD_REF | the git branch of the source of the Pull Request |  
| PR_HEAD_SHA | the latest git sha of the Pull Request being processed |
| PR_LABEL_${LabelName} = 'true' | where `${labelName}` is the upper case name of the Pull Request label with any special character like `-` or `/` replaced by `_` e.g. `PR_LABEL_ENV_STAGING` for the label `env/staging` | 


If you want to define dynamic environment variables in one step for use in later steps you can append new variables to `.jx/variables.sh` and then add the `source .jx/variables.sh` later in your pipeline
