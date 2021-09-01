---
title: jx test create
linktitle: create
type: docs
description: "Create a new TestRun resource to record the test case resources"
aliases:
  - jx-test_create
---

### Usage

```
jx test create
```

### Synopsis

Garbage collects test resources

### Examples

  ```bash
  jx-test create --test-url https://github.com/myorg/mytest.git

  ```

### Options

```
      --app string           the name of the app. Defaults to $APP_NAME
      --branch string        the branch used in the pipeline. Defaults to $BRANCH_NAME
      --build string         the build number. Defaults to $BUILD_NUMBER
      --context string       the pipeline context. Defaults to $JOB_NAME
  -e, --env stringArray      specifies env vars of the form name=value
      --env-pattern string   the regular expression for environment variables to automatically include (default "TF_.*")
  -f, --file string          the template file to create
  -h, --help                 help for create
      --log                  logs the generated resource before applying it (default true)
      --name-prefix string   the resource name prefix (default "tf-")
      --no-delete            disables deleting of the test resource after the job has completed successfully
      --no-watch-job         disables watching of the job created by the resource
      --owner string         the owner of the repository. Defaults to $REPO_OWNER
      --pr int               the Pull Request number. Defaults to $PULL_NUMBER
      --pull-sha string      the Pull Request git SHA. Defaults to $PULL_PULL_SHA
      --repo string          the name of the repository. Defaults to $REPO_NAME
      --type string          the pipeline type. e.g. presubmit or postsubmit. Defaults to $JOB_TYPE
      --verify-result        verifies the output of the boot job to ensure it succeeded
      --version string       the version number. Defaults to $VERSION (default "2.0.1300-dev")
```

### Source

[jenkins-x-plugins/jx-test](https://github.com/jenkins-x-plugins/jx-test)
