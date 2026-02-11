---
title: "Jenkins X Pipelines integrated with Tekton"
date: 2019-02-19T10:36:00+02:00
description: "Jenkins X Pipelines are Serverless" 
categories: [blog]
keywords: []
slug: "jenkins-x-next-gen-pipeline-engine"
author: rawlingsj
aliases:
  - /news/jenkins-x-next-gen-pipeline-engine
---

## Introducing the new Jenkins X Pipeline Engine

The [Jenkins X](https://jenkins-x.io/) team and [CloudBees](https://www.cloudbees.com/) are excited to announce some changes that we’ve been working on and are jntroducing the new [Jenkins X Pipeline Engine](/architecture/jenkins-x-pipelines/).

{{< youtube id="EYywyqcPVMY" autoplay="true" >}}


Today, there are two ways that you can run your Jenkins pipelines in Jenkins X. 

By default today, Jenkins X uses a static traditional Jenkins master and Jenkins Pipelines. This mode works well for those who may have complex existing Jenkins pipelines and want to be able to use all the Jenkins X goodness of GitOps and preview environments in Kubernetes. 

As of last October, you can run Jenkins pipelines without the static Jenkins server -- so, it’s [serverless](https://medium.com/@jdrawlings/serverless-jenkins-with-jenkins-x-9134cbfe6870). 

Serverless pipeline execution mode will become the best way to run Jenkins X in the not-too-distant future. And as we’re looking forward, we’ve begun to find ways to further improve the serverless mode of Jenkins X. We now have [Jenkins X Pipelines](/architecture/jenkins-x-pipelines/) which are based on [Tekton](https://github.com/tektoncd/pipeline) which is a new Kubernetes-native way of running serverless pipelines. While it’s still in its early stages, Tekton will eventually become the best way to run CI/CD pipelines in Kubernetes. 

We’ve begun some early work to add Tekton into Jenkins X. You can now begin testing the pipeline, and we’d love to get your feedback. To use the new Tekton execution mode you [install your Jenkins X cluster using the new tekton mode](/about/concepts/jenkins-x-pipelines/). You will then get a `jenkins-x.yml` file with your application instead of a Jenkinsfile in your source code repository. This YAML file is organized similarly to the Jenkins declarative pipeline syntax used in a Jenkinsfile.

We’ll continue to update the community on progress accordingly and welcome your feedback! Feel free to contact the [Jenkins X team via Slack](https://jenkins-x.io/community/#slack), [office hours](https://jenkins-x.io/community/#office-hours) or send us an email with any questions or concerns. The next office hours will be on Thursday, February 21st, at 11:00am ET and Andrew Bayer will be demoing progress. Thanks!
