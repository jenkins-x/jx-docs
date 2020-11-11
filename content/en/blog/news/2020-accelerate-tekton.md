---
title: "Accelerate your Tekton with Jenkins X"
date: 2020-11-11
draft: false
description: how to reuse, share and customise Tekton Pipelines and the Tekton Catalog with Jenkins X
  
categories: [blog]
keywords: [Community, 2020]
slug: "accelerate-tekton"
aliases: []
author: James Strachan
---

One of the goals of [Jenkins X](https://jenkins-x.io/) has always been to help [accelerate](/about/overview/accelerate/) and automate Continuous Delivery so that developers can focus on delivering value to their customers; either by creating that new microservice or adding features to an existing project and not writing and managing pipelines.

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
  * e.g. the DSL does not yet support all of the semantics of Tekton yet such as conditions, [runAfter](https://github.com/tektoncd/pipeline/blob/master/docs/pipelines.md#using-the-runafter-parameter) or [finally tasks](https://github.com/tektoncd/pipeline/blob/master/docs/pipelines.md#adding-finally-to-the-pipeline)
  * tekton moves fast; it's hard to keep up in a DSL ;)
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


### Reusing Tekton Catalog Tasks

The [Tekton Catalog](https://github.com/tektoncd/catalog) contains a ton of reusable Tekton `Tasks` for doing all kinds of things in the Continuous Delivery landscape with a variety of tools.
 
We want to make it super easy for you to reuse any of them easily in your project.

So now the new [jx pipeline import](https://github.com/jenkins-x/jx-pipeline/blob/master/docs/cmd/jx-pipeline_import.md) command can be used to import `Task` resources from the [Tekton Catalog](https://github.com/tektoncd/catalog) so you can use them inside your project. 

Here's a [demo of this in action](https://asciinema.org/a/368282):

<script src="https://asciinema.org/a/368282.js" id="asciicast-368282" async></script>

The tekton Task resources are copied into your **.lighthouse** directory in a folder using [kpt](https://googlecontainertools.github.io/kpt/) so that you can modify things locally if you need to and can [upgrade your local copy with upstream changes](/docs/v3/develop/pipeline-catalog/#upgrading-pipelines-and-helm-charts).

This lets you work with shared resources from the Tekton community and, when required, modify them to suit and manage them easily over time.


### Sharing steps between Tasks

[Tekton](https://tekton.dev/) makes it super easy to share `Task` resources between different `Pipeline` instances. Though there is a current [limitation](https://github.com/tektoncd/pipeline/issues/3476) where splitting a `Pipeline` into multiple reusable `Task` instances results in the pipeline being split among multiple `Pod` resources; which means to share state between the Tasks you need to use a `Persistent Volume` for each pipeline run which can be a bit of an overhead. 

For example: you may think it's a nice idea to have a reusable `Task` to git clone your source code then use it with your other `Task` to run your tests. It turns out that can be quite expensive infrastructure wise; as it means your cluster will end up making a Persistent Volume for each pipeline invocation so that the git clone pod can clone git and store the state on the PV so that your real Task pod can start and mount the same volume to see the contents of git. Its much easier to just share the git clone steps in each Task; so that there's no need for the PV; just git clone in each separate Task directly.

So for cases where you want to reuse a collection of steps inside `Task` resources we added an annotation in [lighthouse](https://github.com/jenkins-x/lighthouse) so that we can import steps from a URL to avoid the copy/paste. 

e.g. in our [pipeline catalog](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs) we use this approach to share the git clone Task steps such as [this example](https://github.com/jenkins-x/jx3-pipeline-catalog/blob/master/packs/javascript/.lighthouse/jenkins-x/release.yaml#L4-L5):

```yaml 
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  annotations:        
    # lets share the git clone tasks as the initial steps in this Task
    lighthouse.jenkins-x.io/prependStepsURL: https://raw.githubusercontent.com/jenkins-x/jx3-pipeline-catalog/005e78cf69b643862344397a635736a51dd1bd89/tasks/git-clone/git-clone.yaml
spec:
  ...
```

Hopefully we can migrate to a standard tekton based approach [if this issue is resolved](https://github.com/tektoncd/pipeline/issues/3476).  


### Custom Pipeline Catalogs

[Tekton Catalog](https://github.com/tektoncd/catalog) is an awesome way to reuse Tasks but it doesn't help when trying to reuse complete `PipelineRun` and `Pipeline` resources across projects and repositories while also being able to modify them as needed on a per team or repository basis.

[Jenkins X 3.x](/docs/v3/) comes with its own default [pipeline catalog for different languages, tools and frameworks](https://github.com/jenkins-x/jx3-pipeline-catalog/tree/master/packs). This catalog contains reusable steps, Tasks and Pipelines you can use on any project. 

It's easy for you to fork this catalog to make changes for your team or share between teams in your company. You can make as many catalogs as you like and put whichever catalogs you want in the `extensions/pipeline-catalogs.yaml` file of your cluster git repository of your [Jenkins X 3.x install](/docs/v3/). For more detail there's the [configuration reference here](https://github.com/jenkins-x/jx-project/blob/master/docs/config.md#project.jenkins-x.io/v1alpha1.PipelineCatalog).

Then when developers [create a new quickstart](/docs/v3/develop/create-project/#create-a-new-project-from-a-quickstart) or [import a repository](/docs/v3/develop/create-project/#import-an-existing-project) developers will be asked to pick the catalog they want from your list if there is more than one, or the configured catalog is silently used.

This gives you complete freedom to configure things at a global, team or repository level while also making it easy to share changes across projects, teams and companies.


### Conclusion

We are super excited about the combination of [Jenkins X 3.x](/docs/v3/), [Tekton](https://tekton.dev/), [Tekton Catalog](https://github.com/tektoncd/catalog) and ChatOps.  
 
We hope that you can use the above capabilities to solve your Continuous Delivery needs and over time you can take your Pipelines and make your own Pipeline Catalogs and share them with folks inside and outside of your company. 

Hopefully this can help us all accelerate our Tekton pipelines and catalogs towards more continuous delivery awesome with flexible reusable tasks and pipelines! If you want to give this a try [check out Jenkins X 3.x](/docs/v3/)




