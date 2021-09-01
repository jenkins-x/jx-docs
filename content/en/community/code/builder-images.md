---
title: "Builder Images"
linktitle: "Builder Images"
date: 2019-09-06T20:00:23Z
type: docs
weight: 60
aliases:
    - /docs/contributing/code/builder-images/
---

Jenkins X relies on a set of Docker images to run the actual builds. You can find the list here: <https://github.com/jenkins-x/jenkins-x-builders>

In case you don't see the image you need, you have two options:

1. Build your own custom image, host it in a repo somewhere and reference it in your builds
1. Construct and contribute a new builder

This article is only concerned with the second option.

## Overview

At a high level, adding a new builder image will look like this:

- Create the necessary `Dockerfile` & a test to validate that it's working as expected
- Ensure the new builder is actually being built
- Update the updatebot to make sure your builder is updated when Jenkins X is
- Wait for things to get merge into master
- Add the new builder to `jenkins-x-platform`
- Add yml file for the new builder to `jenkins-x-versions`

We'll go over each step in the following.

## Getting Started

Before you can get started, you'll need to first fork & clone <https://github.com/jenkins-x/jenkins-x-builders>. See [Development](/community/code/) section for more details on setting up your local environment, link to upstream, and branching out from your master.

## Create Builder

Each builder extends a base image that includes everything needed by Jenkins X, so your builder mainly needs to focus on what's missing. Looking at the existing builders is a good way to get inspiration.

First off though, create a new folder for your builder following the format of `builder-<language><version>` like `builder-nodejs10x`.

### Dockerfile

There's only a few things that you'll need to include in your `Dockerfile`:

1. always start with

  ```Dockerfile
FROM: gcr.io/jenkinsxio/builder-base:0.0.56
  ```

1. always end the file with

  ```Dockerfile
# jx
ENV JX_VERSION 2.0.693
RUN curl -f -L https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz | tar xzv && \
  mv jx /usr/bin/
  ```

In between these two things is where you'll add what your builder needs.

**Note**: To get the correct version of the `builder-base` image, look at `Dockerfile.gobase` in the root of the repo and use the base image version from that.

### Test

To make sure that the image is built correctly, a test is run which usually just checks that the image can output something expected.

Here's an example of a test that check that the included CLI outputs the correct version:

```yml
schemaVersion: '2.0.0' # Make sure to test the latest schema version
commandTests:
- name: 'node'
  command: 'node'
  args: ['-v']
  excludedError: ['.*FAIL.*']
  expectedOutput: ['.*v10.*']
```

### File structure

The two files are placed in the following structure:

```dir
builder-<your builder name>
  |- Dockerfile
  |- test
  |  |- container-test.yaml
```

Once your files are in place, and you have verified locally that your image builds, you can commit, push, and raise a pull request as described in [Development](/community/code/)

## Inform the update bot

The `update-bot.sh` script is used to create a PR that includes all the updated builder images. Edit the file (it's in the root of the `jenkins-x-builders` repo) and add the appropriate argument to this existing command
:

```sh
jx step create pr chart --name gcr.io/jenkinsxio/builder-ruby --name gcr.io/jenkinsxio/builder-swift \
  --name gcr.io/jenkinsxio/builder-dlang --name gcr.io/jenkinsxio/builder-go --name gcr.io/jenkinsxio/builder-go-maven \
  --name gcr.io/jenkinsxio/builder-gradle --name gcr.io/jenkinsxio/builder-gradle4 --name gcr.io/jenkinsxio/builder-gradle5 \
  --name gcr.io/jenkinsxio/builder-jx --name gcr.io/jenkinsxio/builder-maven --name gcr.io/jenkinsxio/builder-maven-32 \
  --name gcr.io/jenkinsxio/builder-maven-java11 --name gcr.io/jenkinsxio/builder-maven-nodejs --name gcr.io/jenkinsxio/builder-newman \
  --name gcr.io/jenkinsxio/builder-nodejs --name gcr.io/jenkinsxio/builder-nodejs8x --name gcr.io/jenkinsxio/builder-nodejs10x \
  --name gcr.io/jenkinsxio/builder-nodejs12x --name gcr.io/jenkinsxio/builder-php5x --name gcr.io/jenkinsxio/builder-php7x \
  --name gcr.io/jenkinsxio/builder-python --name gcr.io/jenkinsxio/builder-python2 --name gcr.io/jenkinsxio/builder-python37 \
  --name gcr.io/jenkinsxio/builder-rust --name gcr.io/jenkinsxio/builder-scala --name gcr.io/jenkinsxio/builder-terraform \
  --version ${VERSION} --repo https://github.com/jenkins-x/jenkins-x-platform.git
```

Basically you'd want to add `--name gcr.io/jenkinsxio/builder-<your builder name>` somewhere in there.

## Now we wait

At this point you'll have to wait until your new builder has been approves, merged, built, etc.

Once everything is merged you can continue to the next step.

## Update Jenkins X Platform

Once everything is merged into `jenkins-x-builders` and the merge has finished. We need to update the helm charts used by Jenkins X, to make it aware of the new builder.

1. Fork/setup/checkout `jenkins-x-platform`
1. update the file `/jenkins-x-platform/values.yaml` (see details below)
1. commit/push/raise a PR

### Adding values for new builder

In the `values.yaml` file mentioned above, add the following section for each new builder you're adding:

```yaml
      Nodejs10x:
        Name: nodejs10x
        Label: jenkins-nodejs10x
        DevPodPorts: 9229, 3000, 8080
        volumes:
        - type: Secret
          secretName: jenkins-docker-cfg
          mountPath: /home/jenkins/.docker
        EnvVars:
          JENKINS_URL: http://jenkins:8080
          GIT_COMMITTER_EMAIL: jenkins-x@googlegroups.com
          GIT_AUTHOR_EMAIL: jenkins-x@googlegroups.com
          GIT_AUTHOR_NAME: jenkins-x-bot
          GIT_COMMITTER_NAME: jenkins-x-bot
          XDG_CONFIG_HOME: /home/jenkins
          DOCKER_CONFIG: /home/jenkins/.docker/
        ServiceAccount: jenkins
        Containers:
          Jnlp:
            Image: jenkinsci/jnlp-slave:3.26-1-alpine
            RequestCpu: "100m"
            RequestMemory: "128Mi"
            Args: '${computer.jnlpmac} ${computer.name}'
          Nodejs:
            Image: gcr.io/jenkinsxio/builder-nodejs10x:0.1.755
            Privileged: true
            RequestCpu: "400m"
            RequestMemory: "512Mi"
            LimitCpu: "2"
            LimitMemory: "2048Mi"
            # You may want to change this to true while testing a new image
            # AlwaysPullImage: true
            Command: "/bin/sh -c"
            Args: "cat"
            Tty: true
```

**Note**: you can copy-paste from the above and just update the places where it mentions `nodejs10x` to your builder name (assuming your builder doesn't need more resources etc. than the example above)

**Note 2**: If you don't know the exact image version, find your image on [gcr.io/jenkinsxio/](https://gcr.io/jenkinsxio/)

## Update Jenkins X Versions

Finally, we need to tell Jenkins X which version of the new builder to use. This will make Jenkins X use the helm chart we defined above, which in tern pulls down the image we built in the first set of steps.

1. Fork/setup/checkout `jenkins-x-versions`
1. Add yaml file for each buidler (see below) to `/docker/gcr.io/jenkinsxio/`
1. Commit/push/raise a PR

### Adding builder version yml file

Each file should be named like the builder, e.g. `builder-nodejs12x.yml` and should just contain one line:

```yml
version: 0.1.755
```

**Note** make sure to use the image version you specified in the previous step
