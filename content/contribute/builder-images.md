---
title: "Builder Images"
date: 2019-09-06T20:00:23Z
draft: true
menu:
  docs:
    parent: "contribute"
---

Jenkins X relies on a set of Docker images to run the actual builds. You can find the list here: https://github.com/jenkins-x/jenkins-x-builders

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

Before you can get started, you'll need to first fork & clone https://github.com/jenkins-x/jenkins-x-builders. See [Development](/contribute/development) section for more details on setting up your local environment, link to upstream, and branching out from your master.

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

Once your files are in place, and you have verified locally that your image builds, you can commit, push, and raise a pull request as described in [Development](/contribute/development)

## Inform the update bot

The `update-bot.sh` script is used to create a PR that includes all the updated builder images. Edit the file (it's in the root of the `jenkins-x-builders` repo) and add appropriate command to this section:

```
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

## Now we wait...

At this point you'll have to wait until your new builder has been approves, merged, built, etc.

Once everything is merged you can continue to the next step.

## Update Jenkins X Platform

(WiP) add the new builders to jenkins-x-platform (like https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/values.yaml#L1124-L1179).

## Update Jenkins X Versions

(WiP) add yaml files for the new builders in https://github.com/jenkins-x/jenkins-x-versions/tree/master/docker/gcr.io/jenkinsxio.