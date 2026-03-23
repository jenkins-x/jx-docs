---
title: "Incident: Kaniko and ACR"
date: 2021-12-28
draft: false
description: >
  Tracking and resolving an upstream kaniko issue & mitigation steps in the meantime
categories: [blog]
keywords: [Community, 2021]
slug: "kanikoacrandjenkinsx"
aliases: []
author: Tom Hobson
---

We've recently had an issue with one of our packages come to light. We wanted to talk through the resolution steps we're going to put into place.

## So what happened?

Azure users started reporting seeing the following error within the build step:
```
error checking push permissions -- make sure you entered the correct tag name, and that you are authenticated correctly, and try again: checking push permission for "xyz.azurecr.io/myorg/myrepo:0.0.1": resolving authorization for xyz.azurecr.io failed: error getting credentials - err: exec: "docker-credential-acr-env": executable file not found in $PATH
```

This seemed to be indicating to an authorization issues with the terraform module. Other users were seemingly unaffected by this issue.

Upon further analysis, [kaniko](https://github.com/GoogleContainerTools/kaniko.git) seems to have issues with the latest version and grabbing credentials for acr. The latest working version that we are aware of is [1.3](https://github.com/GoogleContainerTools/kaniko/releases/tag/v1.3.0). There wasn't a massive influx of people seeing this issue due to it only occuring once versionstream had been updated with `jx gitops upgrade`.

## So what are you going to do about it?

For starters, most users are probably using the latest kaniko features, so we're unable to just roll this back for everyone.

We're getting started by creating a PR to kaniko to resolve the issue. However, due to release schedules etc, this will mean that getting started with azure will be broken for quite a while.


## How can I fix it in the meantime?
If you're on azure, the resolution is quite simple, here's a step by step guide:

**1.  Find which [buildpack](https://github.com/jenkins-x/jx3-pipeline-catalog) you are using and navigate to the [build-container-build step](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/tasks/csharp/release.yaml#L55):**
```
directory: csharp/ date: 12/28/21  git: main 
› cat .lighthouse/jenkins-x/release.yaml | grep "  image: "
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/csharp/release.yaml@versionStream
```

**2. Replace the build-container-build step to use the suggested kaniko image: `gcr.io/kaniko-project/executor:v1.3.0-debug`**

**Before**
```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  creationTimestamp: null
  name: release
spec:
  pipelineSpec:
    tasks:
    - name: from-build-pack
      resources: {}
      taskSpec:
        metadata: {}
        stepTemplate:
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/csharp/release.yaml@versionStream
          name: ""
          resources:
            requests:
              cpu: 200m
              memory: 256Mi
          workingDir: /workspace/source
        steps:
        - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
          name: ""
          resources: {}
        - name: next-version
          resources: {}
        - name: jx-variables
          resources: {}
        - name: check-registry
          resources: {}
        - name: build-container-build
          resources: {}
        - name: promote-changelog
          resources: {}
        - name: promote-helm-release
          resources: {}
        - name: promote-jx-promote
          resources: {}
  podTemplate: {}
  serviceAccountName: tekton-bot
  timeout: 12h0m0s
status: {}
```

**After**
```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  creationTimestamp: null
  name: release
spec:
  pipelineSpec:
    tasks:
    - name: from-build-pack
      resources: {}
      taskSpec:
        metadata: {}
        stepTemplate:
          image: uses:jenkins-x/jx3-pipeline-catalog/tasks/csharp/release.yaml@versionStream
          name: ""
          resources:
            requests:
              cpu: 200m
              memory: 256Mi
          workingDir: /workspace/source
        steps:
        - image: uses:jenkins-x/jx3-pipeline-catalog/tasks/git-clone/git-clone.yaml@versionStream
          name: ""
          resources: {}
        - name: next-version
          resources: {}
        - name: jx-variables
          resources: {}
        - name: check-registry
          resources: {}
        - image: gcr.io/kaniko-project/executor:v1.3.0-debug
          name: build-container-build
          resources: {}
          script: |
            #!/busybox/sh
            source .jx/variables.sh
            cp /tekton/creds-secrets/tekton-container-registry-auth/.dockerconfigjson /kaniko/.docker/config.json
            /kaniko/executor $KANIKO_FLAGS --context=/workspace/source --dockerfile=${DOCKERFILE_PATH:-Dockerfile} --destination=$PUSH_CONTAINER_REGISTRY/$DOCKER_REGISTRY_ORG/$APP_NAME:$VERSION
        - name: promote-changelog
          resources: {}
        - name: promote-helm-release
          resources: {}
        - name: promote-jx-promote
          resources: {}
  podTemplate: {}
  serviceAccountName: tekton-bot
  timeout: 12h0m0s
status: {}
```

**3. Do this again for your `.lighthouse/jenkins-x/pullrequest.yaml` file**

**4. Commit and push it to your repository.**

### We're hoping to make this simpler

We're working on:
* Fixing it upstream (the proper fix, but could take a while to be merged)
* Making a temporary azure pipeline step for azure users
* Making a script so that azure users don't have to go through this manual process each time
* Allowing overriding images without having to specify a script within lighthouse


### Help us find and fix things like this in future

Talk to us on our slack channels, which are part of the Kubernetes slack. Join  Kubernetes slack [here](http://slack.k8s.io/) and find us on our channels:

* #jenkins-x-dev for developers of Jenkins X
* #jenkins-x-user for users of Jenkins X

Find out more about becoming involved in the Jenkins X community [here](https://jenkins-x.io/community/).
