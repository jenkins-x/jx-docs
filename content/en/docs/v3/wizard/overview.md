---
title: Overview
linktitle: Overview
description: Overview of the wizard improvements
weight: 10
---


The [jx 3.x binary](/docs/v3/guides/jx3/) includes an improved wizard for importing projects or creating new projects from quickstarts.

You can invoke the wizard directly via:

```bash 
jxl project
```

It will guide you through the various wizards.

If you know you want to import code from the currect directory try:

```bash 
jxl project import
```

If you have a git URL you wish to import from try:

```bash 
jxl project import --git-url=https://github.com/myorg/myrepo.git
```                                                             

Or if you want to try a quickstart try:

```bash 
jxl project quickstart
```

Or to create a new Spring Boot project:

```bash 
jxl project spring
```

## Improvements

We've made a number of improvements over the [jx import](https://jenkins-x.io/commands/jx_import/) command:

* when importing to Jenkins X we ask which build pack you wish to use (e.g. classic or kubernetes) so that you can import java libraries or node modules easily in addition to kubernetes native applications
* the wizard will prompt you for the pack name (language) once the detection has occurred. Usually the pack name detection is good enough. e.g. detecting `maven` but you may wish to change the version of the pack (e.g. `maven-java11`)
* when importing a project and you are using Jenkins X and Jenkins in the same cluster you get asked whether you want to import the project into [Jenkins X](https://jenkins-x.io/) or to pick which Jenkins server to use
* we support 2 modes of importing projects to [a remote Jenkins server](/docs/v3/jenkins/)
  * regular Jenkins import where a Multi Branch Project is used and Jenkins processes the webhooks
  * ChatOps mode: we use [lighthouse](https://github.com/jenkins-x/lighthouse) to handle the webhooks and ChatOps and then when triggered we trigger regular pipelines inside the Jenkins server 
* if your repository contains a `Jenkinsfile` and you choose to import into a Jenkins server we don't run the build packs and generate a `Dockerfile`, helm chart or `jenkins-x.yml`


## Changes since `jx import`

For those of you who know [Jenkins X](https://jenkins-x.io/) and have used [jx import](https://jenkins-x.io/commands/jx_import/) before this wizard is a little different:

* the commands are a little different:
  * `jx create import` is now `jxl project import`
  * `jx create quickstart` is now `jxl project quickstart`
  * `jx create project` is now `jwizard`
  * `jx create spring` is now `jxl project spring`
