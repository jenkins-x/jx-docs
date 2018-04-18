---
title: Build Packs
linktitle: Build Packs
description: Turning source code into applications on kubernetes
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "architecture"
    weight: 70
weight: 70
sections_weight: 70
draft: false
toc: true
---

We use [draft](https://draft.sh/) style _build packs_ for different languages, runtimes and build tools to add the necessary configuration files to projects as we [import them](/developing/import/) or [create](/developing/create-spring/) [them](/developing/create-quickstart/) so that we can build and deploy them in kubernetes.

The build packs are used to default the following files if they do not already exist in the project being created/imported:

* `Dockerfile` to turn the code into an immutable docker image for running on kubernetes
* `Jenkinsfile` to define the declarative Jenkins pipeline to define the CI/CD steps for the application
* helm chart in the `charts` folder to generate the kubernetes resources to run the application on kubernetes
* a _preview chart_ in the `charts/preview` folder to define any dependencies for deploying a [preview environment](/about/features/#preview-environments) on a Pull Request   

The default build packs are at [https://github.com/jenkins-x/draft-packs](https://github.com/jenkins-x/draft-packs) with a folder for each language or build tool.

The `jx` command line clones the build packs to your `.~/.jx/draft/packs/` folder and updates them via a `git pull` each time you try create or import a project.

## Creating new build packs

We love [contributions](/community/) so please consider adding new build packs and [pod templates](/architecture/pod-templates/).

Here are instructions on how to create a new build pack - please if anything is not clear come [join the community and just ask](/community/) we are happy to help!

The best place to start with is a _quickstart_ application. A sample project that you can use as a test. So create/find a suitable example project and then [import it](/developing/import).

Then manually add a `Dockerfile` and `Jenkinsfile` if one is not already added for you. You could start with files from the [current build pack folders](https://github.com/jenkins-x/draft-packs/tree/master/packs) - using the most similar language/framework to yours.

If your build pack is using build tools which are not yet available in one of the existing [pod templates](/architecture/pod-templates) then you will need to [submit a new pod template](/architecture/pod-templates/#submitting-new-pod-templates) probably using a new build container image too.

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

Once your `Jenkinsfile` is capable of doing CI/CD for your language/runtime on your sample project then we should be able to take the `Dockerfile`, `Jenkinsfile` and charts folder and copy them into a folder in your fork of the [jenkins-x/draft-packs repository](https://github.com/jenkins-x/draft-packs).

You can try that out locally by adding these files to your local clone of the build packs repository at ` ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs`

e.g. 

```shell 
export PACK="foo"
mkdir ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK
cp Dockerfile Jenkinsfile  ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK

# the charts will be in some folder charts/somefoo
cp -r charts/somefoo ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK/charts
```   

Once your build pack is in a folder at `~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/` then it should be usable by the [jx import](/commands/jx_import) code which uses programming language detection to find the most suitable build pack to use when importing a project. If your build pack requires custom logic to detect it then let us know and we can help patch [jx import](/commands/jx_import) to work better for your build pack. e.g. we have some custom logic for handling [maven and gradle better](https://github.com/jenkins-x/jx/blob/master/pkg/jx/cmd/import.go#L383-L397)     
   
          
If you need any more help [join the community](/community/)  