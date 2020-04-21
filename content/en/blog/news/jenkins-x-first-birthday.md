---
title: "Happy 1st Birthday Jenkins X"
date: 2019-01-14T07:36:00+02:00
description: >
    One year of Jenkins X
categories: [blog]
keywords: []
slug: "happy-first-birthday"
aliases: []
author: tracymiranda
---

Time flies when you are delivering software. It has been just over a year since the [initial commit](https://github.com/jenkins-x/jx/commit/e255f7ea050c4a410a21183ec85a510c8e4ca8c6) went into Github for Jenkins X, the CI/CD solution for cloud native. In just 12 months, Jenkins X progress has been breathtaking, so let’s celebrate by taking a look at all that has been accomplished in this short space of time.

<img src="/news/jenkins-x-first-birthday/birthday.jpg"> 

One of the main founders of Jenkins X is [James Strachan](https://twitter.com/jstrachan) of CloudBees, who is known for building many popular open source software projects such as [Apache Groovy](http://groovy-lang.org/index.html), [Apache Camel](http://camel.apache.org/) and fabric8. Notable these projects also have enduring open source software communities around them. With all this experience it is safe to say James simply gets developers and what they want, need and care about.

Developers WANT to ship code fast.

Developers NEED to use best practices as they go so they can keep the long term sustainability of their code in mind.

Developers CARE ABOUT what they are building; the code, the programming language, the environment, the quirks: everything that makes it special (and also makes one-size-fits-all tools impossible to build). Jenkins X gets all of this, let’s take a look at what it offers developers.

## Ship Code Fast

To help developers get their code out to the world quickly Jenkins X offers preview environments, a seamless developer experience (DevEx) and support for multi-cloud platforms.

### Preview Environments

These are the Jenkins X killer feature. Preview environments enable developers to preview pull requests before changes merge to master. This takes away the pain of having to look at code to work out how good a PR is. Preview environments allow for fast and early feedback as developers can review actual functionality in an automatically provisioned environment. Typically the creation of preview environments is automated inside the Pipelines created by Jenkins X. Read more about [preview environments](https://jenkins-x.io/about/concepts/features/#preview-environments). 

### Developer Experience (DevEx)

Jenkins X can provide preview environments and a complete system for scalable CI/CD because it builds on Kubernetes and the cloud native ecosystem (tools such as Helm). However Kubernetes is complex so Jenkins X abstracts away a lot of this complexity, for example by providing a one line [‘jx create cluster’](https://jenkins-x.io/commands/jx_create_cluster/) command to create a fully formed cluster automatically set up with sensible defaults. 

### Multicloud

Jenkins X can create a cluster with a single command on virtually any flavour of Kubernetes, either on prem or using a public cloud provider. Google Cloud, Microsoft Azure, Amazon Web Services, Oracle Cloud, IBM Cloud, RedHat Openshift and more are all supported. Jenkins X does the heavy lifting so developers can get started without needing to know the cloud-specific command line interface (CLI), how to set up role-based access (RBAC) or what ingress controllers are. 

## Best Practices

### GitOps

Jenkins X comes built in with the most modern best practices for CI/CD including GitOps, operation by pull request. Jenkins X uses GitOps for promoting pull requests and to manage the configuration and version of the kubernetes resources which are deployed to each environment. Read [more about GitOps here](https://jenkins-x.io/about/features/#environments).

### Accelerate Capabilities

Jenkins X uses capabilities identified by the Accelerate book such as automating the deployment process, using trunk-based development and using loosely coupled architecture. Read [more here](https://jenkins-x.io/about/accelerate/).

## Extensibility

Jenkins X works in different environments with any programming language and empowers developers to extend it in so it is optimized for their environments. 

### Quickstart templates

This is the most popular way to extend Jenkins X as the community have contributed many quickstart templates for their favourite programming languages and frameworks. Read more about [extending Jenkins X](https://jenkins-x.io/extending/).

### Workloads

Not everybody has the luxury of starting on cloud native apps from fresh. so recently Jenkins X added buildpacks to bridge the cloud-native divide for typical Jenkins workloads such as Java, Maven, Gradle etc.. Buildpacks themselves are extensible. Read more about [buildpacks here](https://jenkins-x.io/architecture/build-packs/). 

## What do developer think of Jenkins X?
From the early adopters trying out Jenkins X we hear ‘Wow’ a lot, for example:

* When Dailymotion wrote about how they went from [Jenkins to Jenkins X](https://medium.com/dailymotion/from-jenkins-to-jenkins-x-604b6cde0ce3) they described the ‘wow effect’ of creating a cluster in one command
* Joselie Castañeda commented ‘take my wow!’ after watching the [Jenkins X talk video from Kubecon](https://youtu.be/uHe7R_iZSLU). 

## Community
Jenkins X would not be where it is today without the lovely community who make lots of contributions: code contributions, giving feedback and even being good sports making the Jenkins X signal. Thank you all!

Jenkins X is transforming the way developers continuously deliver code and we are excited to see how things progress in the next 12 months!

Happy first birthday Jenkins X!

