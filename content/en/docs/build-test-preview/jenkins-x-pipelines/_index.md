---
title: Jenkins X Pipelines
linktitle: Writing Pipelines
description: cloud native serverless pipelines
date: 2019-03-04
publishdate: 2019-03-04
keywords: [tekton]
aliases:
  - /architecture/jenkins-x-pipelines
  - /getting-started/next-gen-pipeline
  - /about/concepts/jenkins-x-pipelines/
weight: 10
---

 In continuous delivery (CD) environments, a *pipeline* is a process (expressed
as a collection of commands or plugins and a configuration file to express the
development process) that automates the life cycle from repository source files
to production deployment.

**Jenkins X Pipelines** is a *serverless* pipeline execution engine
based on the [Tekton Pipelines](https://tekton.dev/) open source
project. Tekton has been designed to be a modern cloud native solution
for running pipelines.

Jenkins X pipelines are configured in YAML configuration files. The files can be
found in two locations serving distinct purposes:

* In the Jenkins X project repository, called `jenkins-x.yml`.
* In the build packs for creating applications, if it is specified in the project repository `jenkins-x.yml` file under `buildPack`.

## Pipeline types

Each pipeline YAML file has a number of separate logical pipelines:

* `release` for processing merges to the master branch which typically creates a new version and release then triggers promotion
* `pullRequest` for processing Pull Requests
* `feature` for processing merges to a feature branch. Consider using trunk based development which is a practice of high performing teams.

## Lifecycles

Jenkins X has various steps in building, validating, and releasing your
application through the development lifecycle. The lifecycle phases in the
Jenkins X pipeline YAML configuration are:

* `setup` - Steps to create the build environment, such as checking out code
  with git checkout or generating credentials files for Git provider
  authentication

* `preBuild` - Steps to perform before a build occurs, such as ensuring a Docker
  image registry is available for building

* `build` - Steps performed to build your application

* `postBuild` - Steps performed after the build occurs, such as validating for
  Common Vulnerability Exposure (CVE) in any code changes.

* `promote` - Shifting the state of an application (after build and validation)
  to another environment, such as Staging or Production.

## Understanding Jenkins X pipelines
The Jenkins X cluster configuration process creates a YAML-based pipeline
configuration file called jenkins-x.yml. This file configures the default
development pipeline for building applications on kubernetes clusters with
Jenkins X.

```sh
buildPack: none
pipelineConfig:
  pipelines:
    release:
      pipeline:
        agent:
          image: gcr.io/jenkinsxio/builder-go
```

`buildPack` specifies a build pack which contains a `pipeline.yml` file that
supersedes the `jenkins-x.yml` file in the project directory. If none is
specified, there is no build pack and Jenkins X uses the default pipeline
configuration.

The configuration defines the pipeline agent, in this case a Google Container
Registry image for the Go language build tools.

The configuration defines the pipeline agent, in this case a Google Container
Registry image for the Go language build tools.

```sh
        environment:
          - name: DEPLOY_NAMESPACE
            value: jx
```

`environment` specifies environment variables used in the pipeline
configuration. In this instance, the `DEPLOY_NAMESPACE` variable is used with a
value of `jx` for the Jenkins X namespace.

```sh
        stages:
          - name: release
            steps:
              - name: verify-preintall
                dir: /workspace/source/env
                command: jx
                args: ['step','verify','preinstall']
```

`stages` are unique groups of steps (or nested stages sequentially run within a
stage) that specify commands, directories, and arguments for a particular
pipeline stage. In this instance, there is a step within the `release` stage
called `verify-preinstall` that runs a `jx` command that verifies whether cloud
infrastructure (such as the presence of the `kubectl` binary and the correct
version of git is installed) was setup in the preinstallation process.

```sh
              - name: install-vault
                dir: /workspace/source/systems/vault
                command: jx
                args: ['step', 'boot','vault']
```

`name` calls out a unique step in the pipeline configuration that defines
development steps to verify and apply arguments to various commands necessary
for the stage under which it is nested. In this instance, `install-vault`
installs the Hashicorp Vault tool for secrets management.

```sh
              - name: apply-repositories
                dir: /workspace/source/repositories
                command: jx
                args: ['step','helm','apply', '--name', 'repos']
```

This step creates and applies the Helm Package Manager for installation and
management of helm kubernetes applications.

```sh
              - name: apply-pipeline-schedulers
                dir: /workspace/source/prowConfig
                command: jx
                args: ['step','scheduler','config', 'apply', '--direct=true']
```

This step allows the pipeline to work with a scheduler, which executes program
jobs unattended in the background.

```sh
              - name: update-webhooks
                dir: /workspace/source/repositories
                command: jx
                args: ['update','webhooks','--verbose', '--warn-on-fail']
```

This step updates webhooks, which is a service that listens for GitHub activity
and trigger jobs, send automated messages to chat clients such as Slack, and
other configurable actions.

```sh
              - name: verify-install
                dir: /workspace/source/env
                command: jx
                args: ['step','verify','install', '--pod-wait-time', '30m']
```

This step verifies the project installation, downloading and installing or
updating components when necessary.

```sh
    pullRequest:
      pipeline:
        agent:
          image: gcr.io/jenkinsxio/builder-go
```

`pullRequest` is a logical pipeline within the project pipeline that specifies how pull requests are managed when changes are made to the project repository in GitHub.

```sh
        stages:
          - name: release
            steps:
              - name: helm-build
                dir: /workspace/source/env
                command: make
                args: ['build']
```

The `pullRequest` pipeline contains a stage wherein steps can also be executed. In this instance, make is run to create a helm chart and validate that a build has been completed.

## Extending pipelines

A pipeline YAML can extend another YAML file. You can reference a base pipeline
YAML using the following methods:

* Using file to reference a relative file path in the same build pack

  ```sh
  extends:
    file: ../jenkins-x.yaml
  ```  

* Using import to reference a YAML file:
  
  ```sh
  extends:
    import: classic
    file: maven/pipeline.yaml
  ```

which then refers to a named imported module via git:  

  ```sh
  modules:
  - name: classic
    gitUrl: https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes.git
    gitRef: master
  ```

## Overriding steps

Users can override steps in a pipeline YAML from a base pipeline YAML, similar to overriding classes in languages like Java. This allows users reuse the steps in a base pipeline’s lifecycle, then add additional steps.

By default any steps you define are added after the base pipeline YAML steps. For example:

```sh
extends:
  file: base-pipeline.yaml
pipelines:
  pullRequest:
    build:
      steps:
      - sh: export VERSION=$PREVIEW_VERSION && skaffold build -f skaffold.yaml
```

You can add steps before the base pipeline steps using the preSteps: property:

```sh
extends:
  file: base-pipeline.yaml
pipelines:
  release:
    setup:
      preSteps:
      - sh: echo BEFORE BASE SETUP
      steps:
      - sh: echo AFTER BASE SETUP
    build:
      replace: true
      steps:
      - sh: mvn clean deploy -Pmyprofile
        comment: this command is overridden from the base pipeline
```

If you want to completely replace all the steps from a base pipeline for a
particular lifecycle you can use replace: true:

```sh
  replace: true
  steps:
  - sh: mvn clean deploy -Pmyprofile
    comment: this command is overridden from the base pipeline
```

<!--
## Trying Jenkins X Pipelines

Create a new cluster installed with Jenkins X Pipelines using `jx` and the following flags:

```sh
jx create cluster gke --tekton
```

Or if you want to go all in on the next generation of Jenkins X with built-in GitOps for your development environment, using Tekton and using Vault for storage of secrets then use the following (only works on GCP and AWS right now):

```sh
jx create cluster gke --ng
```

The general developer experience, CLI and IDE plugins should work as before - but using [Tekton Pipelines](https://tekton.dev/) Custom Resources under the covers instead of creating a Jenkins Server per team!

## Using a quickstart

Once your cluster is started you can create a new quickstart.

```sh
jx create quickstart
```

A `prowjob` is created, a new prow pipeline controller watches for these jobs and when it receives an event it will check if it has a `pipelinerun` spec present, if not it will post the `prowjob` to a new `pipelinerunner` service from Jenkins X which in turn clones the repo and revision then translates its `jenkins-x.yml` into vanilla Tekton Pipeline resources.  Once they are created the `tekton-pipeline-controller` executes the builds.

## Differences to Jenkins Pipelines

Jenkins X Pipelines use a new `jenkins-x.yml` file which is YAML instead of the Groovy `Jenkinsfile` used by Jenkins.

However it's still reusing the same reusable and composable build packs under the covers. (The Jenkins X [build packs](/docs/create-project/build-packs/) are actually written in Jenkins X Pipelines YAML).

One thing you will notice is that with Jenkins X Pipelines we don't need to copy/paste a large `Jenkinsfile` into each application's git repository; usually the generated `jenkins-x.yml` file is small, like this:

```yaml
buildPack: maven
```

That's it! What that basically means is at runtime the Jenkins X Pipeline will use the [build packs](/docs/create-project/build-packs/) to generate the actual Tekton Pipeline.

## Customizing the Pipelines

Having automated [build packs](/docs/create-project/build-packs/) to do all of your CI+CD is pretty awesome - as most of the time your microservices will all be compiled, tested, packaged, released and promoted in the same way. CI+CD is often undifferentiated heavy lifting we should just automate!

However there are times you want to customize a [particular pipeline](/docs/create-project/build-packs/#pipelines) (release, pull request, feature etc) and a particular [life cycle](/docs/first-projects/build-packs/#life-cycles) to change the actual steps invoked.

You can read more about the [extension model](/docs/create-project/build-packs/#pipeline-extension-model) to find out all you can do. Basically you can add steps before/after any life cycle or completely replace a set of life cycles or even opt out of the build pack completely and inline your pipelines inside your `jenkins-x.yml`

For a quick way to add a new step into a pipeline life cycle you can use the [jx create step](/commands/deprecation/) command:

<figure>
<img src="/images/architecture/create-step.gif" />
<figcaption>
<h5>Create a new Jenkins X Pipeline Step via the CLI</h5>
</figcaption>
</figure>

You can also add or override an environment variable in your pipeline via the [jx create variable](/commands/jx_create_variable/) command

## Editing in VS Code

If you are using [VS Code](https://code.visualstudio.com/) we recommend you install the [YAML Language Extension](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) from Red Hat.

This extension lets you edit YAML files with optional JSON Schema validation.

Jenkins X's JSON Schema is already registered with [schemastore.org](http://schemastore.org/json/) so editing your `jenkins-x.yml` file in VS Code will include smart completion and validation!

<figure>
<embed src="/images/architecture/yaml-edit.mp4" autostart="false" height="400" width="600" />
<figcaption>
<h5>Edit Jenkins X Pipeline in VS Code</h5>
</figcaption>
</figure>

We'd love to improve this UX if you fancy [helping out](/docs/contributing).

## Editing in IDEA

This should already be included out of the box due to the Jenkins X JSON Schema being registered with [schemastore.org](http://schemastore.org/json/) so editing your `jenkins-x.yml` file in IDEA will include smart completion and validation!

We'd love to improve this UX if you fancy [helping out](/docs/contributing/).
-->