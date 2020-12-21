---
title: "Creating projects"
date: 2017-01-05
weight: 30
type: docs
description: >
  Now that you've setup the platform, let's create your first project.
aliases: 
    - /v3/develop/create-project/
---

To create or import projects you will need to get the [jx 3.x binary](/v3/guides/jx3/) and put it on your `$PATH`


## Create a new project from a quickstart

To create a new project from a quickstart template use the [jx project quickstart](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_quickstart.md) command:

```bash 
jx project quickstart
``` 

Note that the old Jenkins X 2.x alias `jx quickstart` is still supported but will be deprecated eventually.

See the [quickstart documentation](/docs/create-project/creating/) for more information

## Import an existing project

To import an existing project use the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command:

```bash 
jx project import
```        

See the [import documentation](/docs/create-project/creating/import/) for more information

Note that the old Jenkins X 2.x alias `jx import` is still supported but will be deprecated eventually.

### Importing projects with Jenkinfiles

Note that Jenkins X 3.x includes [new support for handling of importing Jenkinsfiles](jenkinsfile) if you are trying to combine Jenkins and Tekton together in Jenkins X.

This means we can create quickstarts and import projects using the same UX whether you wish to use the automated CI/CD pipelines from Jenkins X using Tekton or wish to reuse your own existing `Jenkinsfile` files (or even a combination of both on the same repository!)

## Top level wizard
               
If you just run the [jx project](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project.md) you get a top level wizard that asks you which kind of approach you wish to take (e.g. quickstart versus import etc)

## Improvements since v3

We've made a number of improvements over the 2.x version of [jx import](https://jenkins-x.io/commands/jx_import/) command:

* when importing to Jenkins X we ask which pipeline catalog you wish to use which you can now [configure easily](/v3/about/extending/#pipeline-catalog)
* the wizard will prompt you for the pack name (language) once the detection has occurred. Usually the pack name detection is good enough. e.g. detecting `maven` but you may wish to change the version of the pack (e.g. `maven-java11`)
* when importing a project which has a `Jenkinfiles` you are given the choice to:
  * ignore the `Jenkinsfile` and let Jenkins X automate the CI/CD via Tekton 
  * use a Jenkins server you have configured via Jenkins X to implement the CI
  * add a new Jenkins server for the CI managed via GitOps in Jenkins X 
  * use the Jenkinfile Runner via Tekton
  

### Changes since 2.x:

For those of you who know [Jenkins X](https://jenkins-x.io/) and have used [jx import](https://jenkins-x.io/commands/jx_import/) before the new project wizard is a little different:

* the commands are a little different:

  * `jx create import` is now `jx project import`
  * `jx create quickstart` is now `jx project quickstart`
  * `jx create project` is now `jx project`
  * `jx create spring` is now `jx project spring`
