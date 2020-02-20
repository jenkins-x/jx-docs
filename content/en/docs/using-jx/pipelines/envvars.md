---
title: "Pipeline Environment Variables"
linkTitle: "Environment Variables"
weight: 3
description: >
  Using environment variables in your pipelines
---

There are variables that are available by default, and there are those that you can define yourself.

## Default environment variables

The following environment variables are available for use in a step in Jenkins X Pipelines:

| Name | Description |
| --- | --- |
| DOCKER_REGISTRY | the docker registry host (e.g. `docker.io` or `gcr.io`) |
| BUILD_NUMBER | the build number (1, 2, 3) starts at `1` for each repo and branch |
| PIPELINE_KIND | the kind of pipeline such as `release` or `pullrequest` |
| PIPELINE_CONTEXT | the pipeline context if there are multiple pipelines per PR (for different tests/governance/lint etc) |
| REPO_OWNER | the git repository owner |
| REPO_NAME | the git repository name |
| JOB_NAME | the job name which typically looks like `$REPO_OWNER/$REPO_NAME/$BRANCH_NAME` |
| APP_NAME | the name of the app which typically is the `$REPO_NAME`
| BRANCH_NAME | the name of the branch such as `master` or `PR-123` |
| JX_BATCH_MODE | indicates to jx to use batch mode if `true` |
| VERSION | contains the version number being released or the PR's preview version |
| BUILD_ID | same as `$BUILD_NUMBER`
| JOB_TYPE | the prow job type such as `presubmit` for PR or `postsubmit` for release |
| PULL_BASE_REF | the branch/ref of git |
| PULL_BASE_SHA | the git SHA being built |
| PULL_NUMBER | for PRs this will be the number without the `PR-` prefix
| PULL_REFS | for batch merging all the git refs |

### ${VERSION}

This particular variable is populated by Jenkins X when running pipelines. You can use this to tag docker images or anything else where you need a version number for the application you’re building.

For Release pipelines, Jenkins X will look up the latest Git tag and use that as a basis for the value, increment it and create a new tag. For example, if your latest tag is `1.3.34`, Jenkins X will populate `${VERSION}` with `1.3.35` and will tag the HEAD of the master branch with the same value. This all happens automatically, giving you a record of the last successful build of the master branch.

For `pullRequest` pipelines, the value is populated based on the version recorded in the GitOps repo for your application, and appended with `PR-<pull request number>-<build number>` giving each build a pull request a unique version.

#### Triggering a major or minor version bump

When the version is bumped automatically, only the patch version is changed. To change the major or minor version, manually add a tag (e.g. 1.4.0) to your repo and Jenkins X will continue to increment from there (making the next application version 1.4.1 in the previous example).

#### Overriding ${VERSION}

For `pullRequest` pipelines, the logic behind `${VERSION}` cannot yet be overridden, but you could likely construct a version string out of the other variables mentioned above, if the default doesn’t serve your purpose.

For `Release` pipelines, you can override the default logic by adding a `setVersion` declaration above the `pipeline` keyword like this:

```yaml
    release:
      setVersion:
        steps:
          - name: next-version
            sh: "jx step next-version --version $(cat HUGO_VERSION)-${BUILD_NUMBER} --tag"
```

The example above uses a file with a version number to construct a specific version string where the unique part is the build number. The `--tag` part makes Jenkins X also tag the repo with the generated string. In the example, we wanted to keep the official Hugo version and have a separate indicator for the build number, to avoid bumping the patch number and making our image seem ahead of the official Hugo version. The string generated ends up looking like `0.60.1-3`

## Self defined variables

You can define your own environment variables either at the pipeline level:

```yaml
    release:
      pipeline:
        environment:
          - name: PIPELINE_VAR
            value: A value for the pipeline variable
```
at a stage level:

```yaml
    release:
      pipeline:
        stages:
          environment:
            - name: STAGE_VAR
              value: A value for the stage level variable
```

or at a step level:

```yaml
    release:
      pipeline:
        stages:
          steps:
            environment:
              - name: STEP_VAR
                value: A value for the step level variable
```

Each level will add their variables to the variables defined in the level(s) above them, or potentially replace a variable if the same name is used.
