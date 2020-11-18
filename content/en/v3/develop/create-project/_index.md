---
title: "Creating projects"
date: 2017-01-05
weight: 30
type: docs
description: >
  Now that you've setup the platform, let's create your first project.
aliases: 
    - /docs/v3/develop/create-project/
---

To create or import projects you will need to get the [jx 3.x binary](/docs/v3/guides/jx3/) and put it on your `$PATH`


## Create a new project from a quickstart

To create a new project from a quickstart template use the [jx project quickstart](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_quickstart.md) command:

```bash 
jx project quickstart
``` 

Note that the old Jenkins X 2.x alias `jx quickstart` is still supported but will be deprecated eventually.

See the [quickstart documentation](/docs/create-project/creating/) for more information

## Import an existing project

To create a new project from a quickstart template use the [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) command:

```bash 
jx project import
```        

See the [import documentation](/docs/create-project/creating/import/) for more information

Note that the old Jenkins X 2.x alias `jx import` is still supported but will be deprecated eventually.

### Importing projects with Jenkinfiles

Note that Jenkins X 3.x includes [new support for handling of importing Jenkinsfiles](jenkinsfile) if you are trying to combine Jenkins and Tekton together in Jenkins X.


## Top level wizard

This gives you all of the above options in an interactive wizard via [jx project](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project.md)


## Improvements

We've made a number of improvements over the 2.x version of [jx import](https://jenkins-x.io/commands/jx_import/) command:

* when importing to Jenkins X we ask which build pack you wish to use (e.g. classic or kubernetes) so that you can import java libraries or node modules easily in addition to kubernetes native applications
* the wizard will prompt you for the pack name (language) once the detection has occurred. Usually the pack name detection is good enough. e.g. detecting `maven` but you may wish to change the version of the pack (e.g. `maven-java11`)
* when importing a project and you are using Jenkins X and Jenkins in the same cluster you get asked whether you want to import the project into [Jenkins X](https://jenkins-x.io/) or to pick which Jenkins server to use
* we support 2 modes of importing projects to [a remote Jenkins server](/docs/v3/guides/jenkins/)
  * regular Jenkins import where a Multi Branch Project is used and Jenkins processes the webhooks
  * ChatOps mode: we use [lighthouse](https://github.com/jenkins-x/lighthouse) to handle the webhooks and ChatOps and then when triggered we trigger regular pipelines inside the Jenkins server 
* if your repository contains a `Jenkinsfile` and you choose to import into a Jenkins server we don't run the build packs and generate a `Dockerfile`, helm chart or `jenkins-x.yml`


## Changes since 2.x:

For those of you who know [Jenkins X](https://jenkins-x.io/) and have used [jx import](https://jenkins-x.io/commands/jx_import/) before the new project wizard is a little different:

* the commands are a little different:

  * `jx create import` is now `jx project import`
  * `jx create quickstart` is now `jx project quickstart`
  * `jx create project` is now `jx project`
  * `jx create spring` is now `jx project spring`
