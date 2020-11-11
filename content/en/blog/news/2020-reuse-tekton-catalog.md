---
title: "Accelerate your Tekton with Jenkins X"
date: 2020-11-11
draft: false
description: how to reuse, share and customise Tekton Pipelines and the Tekton Catalog with Jenkins X
  
categories: [blog]
keywords: [Community, 2020]
slug: "jx-reuse-tekton-catalog"
aliases: []
author: James Strachan
---

One of the goals of [Jenkins X](https://jenkins-x.io/) has always been to help [accelerate](about/overview/accelerate/) and automate Continuous Delivery so that developers can focus on delivering value to their customers; either by creating that new microservice or adding features to an existing project and not writing and managing pipelines.

Pipeline engines like [Jenkins](https://www.jenkins.io/) and [Tekton](https://tekton.dev/) are awesome - they can do anything! But they start as a blank sheet of paper where you have to fill in all the details of how to compile your code, test it, verify it, tag it, release, distribute and delivery it to production. Figuring all that stuff out can take a huge amount of time to create and maintain. This gets even more complex as we are all creating more and more microservices each with their own pipelines making more and more things to create and manage.

We want to be able to reuse pipelines and tasks to get work done. But at the same time we want flexibility; not all applications are the same and sometimes things need to be changed on a per team or application basis.

## Version 2.x

In Jenkins X 2.x we went with a `jenkins-x.xml` approach to pipelines which let you inherit pipelines from reuable pipeline library and then use a composition DSL above [Tekton](https://tekton.dev/) which lets you add/remove/replace steps.

e.g. to use the `javascript` pipeline library but override a step you could use:

```yaml 
buildPack: javascript
pipelineConfig:
  pipelines:
    overrides:
      - pipeline: release
        name: helm-release
        step: 
          image: busybox
          sh: echo "this command is replaced"
``` 

This was a pretty good approach; it lets us reuse common pipelines in a shared git repository and let's reuse a composition DSL.

However we've found that this approach as a few downsides:

* we have to create and maintain a DSL above Tekton which adds complexity and can be a leaky abstraction
  * e.g. the DSL does not yet support all of the semantics of Tekton yet such as conditions and sidecars
  * tekton moves fast; its hard to keep up ;)
* its complex trying to understand how to make local modifications of pipelines
  * particularly if you just want to add an environment variable; modify a command line argument or something
* we can't use [IDE tooling](/docs/v3/develop/pipeline-catalog/#ide-support) for [Tekton](https://tekton.dev/) to edit/visualise pipelines
* we can't reuse [Tekton Catalog tasks](https://github.com/tektoncd/catalog)


## Vision

We want developers to have reusable pipelines for all their applications lifecycles: 

* continuous integration
* verification, testing, linting
* releasing, packaging, promoting, deploying

We also want to:

* automate the generation of pipelines so most of the time developers don't need to care about pipelines
* reuse pipelines across applications
  * usually all, say, spring boot microservices tend to be built and released in the same way
* make it easy for developers to view/edit the pipelines if required
  * maintain those changes over time as everything in the cloud native ecosystem is changing all the time

From a technical perspective:

* we believe [Tekton](https://tekton.dev/) is currently the best cloud native standard way to represent pipelines and tasks for Continuous Delivery and we want that to be the primary DSL for developers and tools 
* we want to work with the [Tekton Catalog](https://github.com/tektoncd/catalog) so its easy to share tasks among teams


## Version 3.x

For [Jenkins X 3.x](/docs/v3/) we really wanted to move closer to this vision: to _accelerate_ the adoption of Tekton and help give developers Tekton super powers.

Re-reading [Brian Grant's document on Declarative application management in Kubernetes](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/architecture/declarative-application-management.md) really got us thinking about this problem of how to reuse complex YAML files for pipelines and tasks while also allowing local modifications while also avoiding a complex leaky DSL for composition.

Then we tried out [kpt](https://googlecontainertools.github.io/kpt/) (pronounced `kept`) and everything fell into place pretty quickly.


### Using Tekton in your repository

When you [create a new quickstart](/docs/v3/develop/create-project/#create-a-new-project-from-a-quickstart) or [import a repository](/docs/v3/develop/create-project/#import-an-existing-project) into [Jenkins X 3.x](/docs/v3/) you get a new folder: **.lighthouse/jenkins-x** added to your source code which contains the Tekton pipeline files you need for your application.

So for a typical application the **.lighthouse/jenkins-x** folder will contain: 

* **release.yaml** the Tekton `PipelineRun` for releasing your application 
* **pullrequest.yaml** the Tekton `PipelineRun` for perform continuous integration testing, verification and the creation of a Preview Environment for your proposed changes before they merge to the main branch
* **triggers.yaml** to define the [lighthouse](https://github.com/jenkins-x/lighthouse) [TriggerConfig](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#Config) which defines the [ChatOps](/docs/resources/faq/using/chatops/#what-is-chatops) and triggering configuration via a [spec field](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-triggerconfig.md#ConfigSpec) which defines [presubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Presubmit) and [postsubmits](https://github.com/jenkins-x/lighthouse/blob/master/docs/trigger/github-com-jenkins-x-lighthouse-pkg-config-job.md#Postsubmit) (i.e. Pull Request and Release triggers).

See the [Pipeline Catalog documentation](/docs/v3/develop/pipeline-catalog/) for more details on how this works and go to the [reference guide](/docs/v3/develop/pipeline-catalog/#reference-guide) if you want to dive into the details.

As a developer you can mostly ignore the `.lighthouse` folder if you don't care about how the pipelines work. If you are interested you can look inside.

If you need to modify anything, just open the Tekton files in your [IDE](/docs/v3/develop/pipeline-catalog/#ide-support) and modify them. No complex DSL to understand other than Tekton itself. Then the changes will be used when you submit your local changes via a Pull Request (for the pull request pipeline) or they get merged to the main branch (for release pipeline changes).

To handle change going forward from upstream pipeline catalogs while preserving any local modifications we use a generic [update mechanism on all git repositories](/docs/v3/develop/pipeline-catalog/#upgrading-pipelines-and-helm-charts) which is powered by [kpt](https://googlecontainertools.github.io/kpt/)  


### Using Tekton Catalog Tasks

The [Tekton Catalog](https://github.com/tektoncd/catalog) contains a ton of reusable Tekton `Tasks` for doing all kinds of things in the Continuous Delivery landscape with a variety of tools.
 
We want to make it super easy for you to reuse any of them easily in your project.

So now the new [jx pipeline import](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_import.md) command can be used to import `Task` resources from the [Tekton Catalog](https://github.com/tektoncd/catalog) so you can use them inside your project. 

Here's a [demo of this in action](https://asciinema.org/a/368282):

<script src="https://asciinema.org/a/368282.js" id="asciicast-368282" async></script>

The tekton Task resources are copied into your **.lighthouse** directory in a folder using [kpt](https://googlecontainertools.github.io/kpt/) so that you can modify things locally if you need to and can [upgrade your local copy with upstream changes](/docs/v3/develop/pipeline-catalog/#upgrading-pipelines-and-helm-charts).

This lets you work with shared resources from the Tekton community and, when required, modify them to suit and manage them easily over time.
 
We hope that over time you can take your Pipelines and make your own Pipeline Catalogs and share them with folks inside and outside of your company. 

Hopefully this can help us all accelerate our Tekton pipelines and catalogs towards more continuous delivery awesome! If you want to give this a try [check out Jenkins X 3.x](/docs/v3/)




