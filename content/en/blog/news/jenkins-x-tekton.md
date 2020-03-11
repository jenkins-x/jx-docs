---
title: "Jenkins X  ❤ Tekton"
date: 2020-03-11
draft: false
description: >
  Like Jenkins X, Tekton is Kubernetes native and has been built from the ground up to leverage Kubernetes. 
categories: [blog]
keywords: [Jenkins,Tekton,2020]
slug: "tekton"
aliases: []
author: Ethan Jones
---

Jenkins X is committing fully to Tekton as its pipeline execution engine. We are convinced that this is the right choice for Jenkins X, as a cloud-native CI/CD platform on Kubernetes, and for our users. 

This means we are formally deprecating - and will be removing - traditional Jenkins static masters support inside Jenkins X. We are excited about the new way forward, which we’ll discuss further below, but it’s important to be clear about what this means for current users. If you are already using Jenkins X with Tekton-based pipelines, then nothing will change for you, and you do not need to change anything. If you’re running a traditional Jenkinsfile on Jenkins X, then you have three choices: 

* Continue using static masters with a version of Jenkins X that supports Jenkins static masters
    * Note that for versions of Jenkins X that support Jenkins static masters we will not provide any security fixes either to the jx CLI or to the Jenkins image used after mid April.
* Return to a more optimized Jenkins installation
* Or, if you plan on updating your version of Jenkins X to keep up with the latest features, then you will need to adapt your setup

In this post, we will discuss how we arrived at this decision, why there is currently a choice between two different pipeline execution engines, and why it is better for the project and for our users to standardize on one. We will go over in more detail what these changes mean for current users, and the options we have to help current users on Jenkins static masters with these changes.

## A story of Pipeline Engines

When Jenkins X was founded two years ago, Jenkins was chosen as its pipeline execution engine. Why? 

1) Familiarity: Jenkins is the most widely used orchestration system in history, and at CloudBees we know it quite well.

2) There was not a Kubernetes native pipeline engine, ie, there was no Tekton

A year later, Tekton had been founded and Jenkins X rapidly adopted the new Kubernetes-native pipeline engine. It became one of two options for users to choose as their pipeline execution engine within Jenkins X. This was huge for us, because Jenkins was never built to be used in the way we were using it, and the way Jenkins is architected made it very difficult to build Jenkins X forward with our dream features and keep things compatible and running well - Tekton solved all these problems.

As a result, though, the users of Jenkins X can now choose between two very different pipeline execution engines -- Jenkins static masters or our own Tekton-based pipelines.

Ideally, a developer using Jenkins X does not need to think about the pipeline engine executing their CI/CD pipelines.  In practice, though, the Jenkins X user experience varies significantly depending on which pipeline engine the user choses. This is because of technical complexity and use case difference that makes standardization hard to achieve and even harder to maintain.

As more functionality is added to the project which fits seamlessly with Tekton, Jenkins as a pipeline engine for Jenkins X increasingly feels unoptimized and inappropriate for the project. As amazing as Jenkins is, it wasn’t built to be an ephemeral cloud-native pipeline engine inside of a larger workflow tool, and maintaining Jenkins as a pipeline engine for Jenkins X has proven difficult and complex. The Jenkins X user experience with Jenkins static masters is already lesser than the user experience with Tekton, and it will only degrade further over time. For this reason, we have been recommending Tekton as the default pipeline engine in Jenkins X for more than 6 months now.  

The way we see it, traditional Jenkins running on Kubernetes makes sense for Jenkins-based apps that already exist and for teams that aren’t ready to change their tooling and their process. Jenkins is rock-solid and can run forever doing what it does today for the hundreds of thousands of teams that use it. But, that’s not what Jenkins X is for. Jenkins X is for brand new applications, being built from the ground up for the world of Kubernetes-based, cloud-native development - and we want to make things as great as possible for all the developers building those kinds of applications right now.

## Kubernetes native 

Although for users the pipeline execution engine should be an implementation detail, for the Jenkins X project Tekton is clearly a better, more natural, fit. Like Jenkins X, Tekton is Kubernetes native: it was designed from the ground up to leverage Kubernetes, not merely integrate with Kubernetes.

The Jenkins X core team has chosen to standardize on Tekton as a pipeline execution engine for the following reasons:

* Kubernetes native
* Declarative, not scripted
    * This makes pipelines easier to author, read, and maintain
    * Highly opinionated syntax, making it easier to work in a best-practices way
    * YAML! Not Groovy or Groovy-based syntax 

However, Jenkins X has its own syntax on top of Tekton, to improve the user experience. Tekton’s syntax is very explicit, which is excellent for the level at which Tekton is operating. Jenkins X, as a developer-centric CI/CD platform, is able to take the information already available regarding a user’s configuration and provide that context. Additionally, Jenkins X provides an opinionated, best-practices based workflow. For these reasons, the amount of information a user needs to provide is reduced and the user experience is guided and simplified.

For Jenkins X, as a CI/CD platform on Kubernetes, Tekton is the right choice for the pipeline execution engine. Focusing on one pipeline engine going forward will enable a leaner, cleaner codebase and a better end-user experience. Standardizing on Tekton as the pipeline execution engine for Jenkins X enables the core team to focus on improving the Jenkins X user experience without having to support compatibility with two different pipeline engines.

## What’s next 

We’re deprecating traditional Jenkins masters in all new versions of Jenkins X. They will be removed from the codebase of future Jenkins X versions from April 20th. 

While this is an aggressive timeline, it’s important to know that if you’re currently running Jenkins X with traditional Jenkins today, it’s not going to disappear. You won’t be able to upgrade to new versions - but we will cut one final release right before the deadline to give you a stable version to use for as long as you need.

Next, If you’re looking to migrate existing declarative Jenkins jobs to Jenkins X, we have a [partial Jenkinsfile translator](https://github.com/jenkins-x/jx-convert-jenkinsfile) that can help point you in the right direction. While it won’t fully translate all Jenkinsfiles, it will help point you in the right direction to get the ball rolling.

And finally, if you’d like to keep your Jenkins jobs running but as individual steps inside a Jenkins X pipeline, [we have a proposal for remote execution](https://jenkins-x.io/docs/labs/jenkins/) as a new path forward. Since Jenkins itself can be run on Kubernetes, switching to a remote execution step via Jenkins X - or entirely to Jenkins if it makes more sense for you - should be an easy switch to make. We think this is a much better path forward, as it keeps Jenkins entirely out of Jenkins X while still letting you adopt Jenkins X right away and migrate your traditional Jenkins jobs to Tekton-based jobs over time. We expect a working proof of concept for the community soon.

## Conclusion

We know this is a big announcement on a fast timeline and a lot of ideas to take in. We’d love to talk to you about it! Please join the [office hours we have arranged on March 19th](https://jenkins-x.io/community/office_hours/) that will be fully dedicated to discussing this. 

You may reach out to me, Ethan Jones, at ejones@cloudbees.com if you’d like to discuss things one on one with some of our product and engineering team members.