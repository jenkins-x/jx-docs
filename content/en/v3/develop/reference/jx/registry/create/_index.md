---
title: jx registry create
linktitle: create
type: docs
description: "Lazy create a container registry for ECR"
aliases:
  - jx-registry_create
---

### Usage

```
jx registry create
```

### Synopsis

Lazy create a container registry for ECR as well as putting a lifecycle policy in place. The default policy will make images with a tag prefix of 0.0.0- expire after 14 days. This prefix is the default for pull request builds. If a policy exist and the default policy isn't overridden (see --ecr-lifecycle-policy) no policy will be put.

### Examples

  ```bash
  # lets ensure we have an ECR registry setup
  jx-registry create

  ```
### Options

```
  -a, --app string                    The app name to use. Defaults to $APP_NAME
      --aws-profile string            The AWS profile to use. Defaults to $AWS_PROFILE (default "cloudbees-pse")
      --aws-region string             The AWS region. Defaults to $AWS_REGION or its read from the 'jx-requirements.yml' for the development environment
  -b, --batch-mode                    Runs in batch mode without prompting for user input
      --cache-suffix string           If specified (or enabled via $CACHE_SUFFIX) we will make sure an ECR is created for the cache image too
      --create-ecr-lifecycle-policy   Should ECR Lifecycle Policy be created. Can be specified in $CREATE_ECR_LIFECYCLE_POLICY. (default true)
      --ecr-lifecycle-policy string   ECR lifecycle policies to apply to the repository. Can be specified in $ECR_LIFECYCLE_POLICY.
      --ecr-registry-suffix string    The registry suffix to check if we are using ECR (default ".amazonaws.com")
  -h, --help                          help for create
      --log-level string              Sets the logging level. If not specified defaults to $JX_LOG_LEVEL
  -n, --namespace string              The namespace. Defaults to the current namespace
  -o, --organisation string           The registry organisation to use. Defaults to $DOCKER_REGISTRY_ORG
  -r, --registry string               The registry to use. Defaults to $DOCKER_REGISTRY
      --registry-id string            The registry ID to use. If not specified finds the first path of the registry. $REGISTRY_ID
      --verbose                       Enables verbose output. The environment variable JX_LOG_LEVEL has precedence over this flag and allows setting the logging level to any value of: panic, fatal, error, warn, info, debug, trace
```



### Source

[jenkins-x-plugins/jx-registry](https://github.com/jenkins-x-plugins/jx-registry)
