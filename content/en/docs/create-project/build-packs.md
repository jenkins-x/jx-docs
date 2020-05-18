---
title: Build Packs
linktitle: Build Packs
description: Turning source code into applications on kubernetes
weight: 10
aliases:
  - /architecture/build-packs
  - /docs/resources/guides/managing-jx/common-tasks/build-packs
  - /docs/create-project/build-packs/
  - /docs/reference/components/build-packs
---

We use [draft](https://draft.sh/) style _build packs_ for different languages, runtimes and build tools to add the necessary configuration files to projects as we [import them](/docs/resources/guides/using-jx/creating/import/) or [create](/docs/resources/guides/using-jx/common-tasks/create-spring/) [them](/docs/getting-started/first-project/create-quickstart/) so that we can build and deploy them in kubernetes.

The build packs are used to default the following files if they do not already exist in the project being created/imported:

* `Dockerfile` to turn the code into an immutable docker image for running on kubernetes
* `Jenkinsfile` to define the declarative Jenkins pipeline to define the CI/CD steps for the application
* helm chart in the `charts` folder to generate the kubernetes resources to run the application on kubernetes
* a _preview chart_ in the `charts/preview` folder to define any dependencies for deploying a [preview environment](/about/concepts/features/#preview-environments) on a Pull Request

The default build packs are at [https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) with a folder for each language or build tool.

The `jx` command line clones the build packs to your `.~/.jx/draft/packs/` folder and updates them via a `git pull` each time you try create or import a project.

## Pipeline extension model

As part of the move to [cloud native Jenkins](/docs/resources/guides/managing-jx/common-tasks/cloud-native-jenkins/) we've refactored our [build packs](https://github.com/jenkins-x-buildpacks/) so that they are more modular and easier to compose and reuse across workloads.

For example the [jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) build pack inherits from the [jenkins-x-classic](https://github.com/jenkins-x-buildpacks/jenkins-x-classic) build pack, reusing the CI and release pipelines but then adding the kubernetes specific workloads (e.g. building docker images, creating helm charts, [Preview Environments](/about/concepts/features/#preview-environments) and [Promotion via GitOps](/about/concepts/features/#promotion))

To do this we've introduced a simple new YAML file format for defining pipelines.


## Pipelines

Each Pipeline YAML file has a number of separate logical pipelines:

* `release` for processing merges to the `master` branch which typically creates a new version and release then triggers promotion
* `pullRequest` for processing Pull Requests
* `feature` for processing merges to a feature branch. Though note that the [accelerate book](/about/accelerate/) recommends against long term feature branches. Instead consider using trunk based development which is a practice of high performing teams.

## Life Cycles

Then each pipeline has a number of distinct life cycle phases - rather like maven has `clean`, `compile`, `compile-test`, `package` etc.

The life cycle phases in Jenkins X Pipeline YAML are:

* `setup`
* `preBuild`
* `build`
* `postBuild`
* `promote`

## Extending

A Pipeline YAML can extend another YAML file. You can reference a base pipeline YAML via:

* using `file` to reference a relative file path in the same build pack [like this example using file](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L1-L2)
* using `import` to reference a YAML file which is imported like [this example using import](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml#L2-L3) which then refers to a [named imported module via git](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/imports.yaml#L2-L4)

## Overriding steps

Rather like classes in languages like Java you can override steps in a Pipeline YAML from a base Pipeline YAML. This lets you reuse the steps in a base pipeline's life cycle then add your own additional steps.

By default any steps you define are added after the base pipeline YAML steps like in [this example](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence/pipeline.yaml#L7).

You can add steps before the base pipeline steps using the `preSteps: ` property like [this example](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence2/pipeline.yaml#L6)

If you want to completely replace all the steps from a base pipeline for a particular life cycle you can use `replace: true` like in [this example](https://github.com/jenkins-x/jx/blob/0520fe3d9740cbcb1cc9754e173fe7726219f58e/pkg/jx/cmd/test_data/step_buildpack_apply/inheritence2/pipeline.yaml#L11-L14)

## Example Pipeline

For example for [maven libraries we use this pipeline.yaml file](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml) which:

* [extends](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L1-L2) the [common pipeline](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/pipeline.yaml) that sets up git and defines common post build steps
* [configures the agent](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L3-L5) in terms of [pod template](/docs/resources/guides/managing-jx/common-tasks/pod-templates/) and container name
* defines the steps for the `pull request` pipeline [build steps](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L7-L11)
* defines the `release` pipeline [set version steps](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L13-L18) and [build steps](https://github.com/jenkins-x-buildpacks/jenkins-x-classic/blob/f7027df958eb385d50fec0c0368e606a6d5eb9df/packs/maven/pipeline.yaml#L19-L21)

Then the [maven kubernetes pipeline.yaml](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml) then [extends](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/45819e05fa197d9069af682fbbcad0af8d8d605a/packs/maven/pipeline.yaml#L2-L3) from the classic pipeline to add the kubernetes steps

# Creating new build packs

We love [contributions](/community/) so please consider adding new build packs and [pod templates](/docs/resources/guides/managing-jx/common-tasks/pod-templates/).

Here are instructions on how to create a new build pack - please if anything is not clear come [join the community and just ask](/community/) we are happy to help!

The best place to start with is a _quickstart_ application. A sample project that you can use as a test. So create/find a suitable example project and then [import it](/docs/resources/guides/using-jx/creating/import/).

Then manually add a `Dockerfile` and `Jenkinsfile` if one is not already added for you. You could start with files from the [current build pack folders](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs) - using the most similar language/framework to yours.

If your build pack is using build tools which are not yet available in one of the existing [pod templates](/docs/reference/components/pod-templates/) then you will need to [submit a new pod template](/docs/reference/components/pod-templates/) probably using a new build container image too.

Once you have a pod template to use, say, `jenkins-foo` then refer to it in your `Jenkinsfile`:

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-foo"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('foo') {
            sh "foo deploy"
          }
```

Once your `Jenkinsfile` is capable of doing CI/CD for your language/runtime on your sample project then we should be able to take the `Dockerfile`, `Jenkinsfile` and charts folder and copy them into a folder in your fork of the [jenkins-x/draft-packs repository](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes).

You can try that out locally by adding these files to your local clone of the build packs repository at ` ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs`

e.g.

```sh
export PACK="foo"
mkdir ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK
cp Dockerfile Jenkinsfile  ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK

# the charts will be in some folder charts/somefoo
cp -r charts/somefoo ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK/charts
```

Once your build pack is in a folder at `~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/`
then it should be usable by the [jx import](/commands/jx_import/) code
which uses programming language detection to find the most suitable build pack to use when importing a project.
If your build pack requires custom logic to detect it then let us know
and we can help patch [jx import](/commands/jx_import/) to work better for your build pack.
For example, we have some custom logic for handling [Maven and Gradle better](https://github.com/jenkins-x/jx/blob/712d9edf5e55aafaadfb3e0ac57692bb44634b1c/pkg/jx/cmd/common_buildpacks.go#L82:L108).


If you need any more help [join the community](/community/)
