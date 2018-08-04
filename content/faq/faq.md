---
title: General Questions
linktitle: General Questions
description: General questions about the Jenkins X project
date: 2018-02-10
categories: [faq]
menu:
  docs:
    parent: "faq"
keywords: [faqs]
weight: 2
toc: true
aliases: [/faq/]
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).


### Is Jenkins X Open Source?

Yes! All of Jenkins X source code and artifacts are open source; either Apache or MIT and will always remain so!


### Is Jenkins X a fork of Jenkins?

No! Jenkins X currently reuses Jenkins Core and configures it to be as kubernetes native as possible.

Initially Jenkins X is a distribution of the core Jenkins with a custom kubernetes configuration with some additional built in plugins (e.g. the kubernetes plugin and jx pipelines plugin) packaged as a Helm chart.

Over time we hope the Jenkins X project can drive some changes in the Jenkins Core to help make Jenkins more Cloud Native. e.g. using a database or Kubernetes resources to store Jobs, Runs and Credentials so its easier to support things like multi-master or one shot masters. Though those changes will happen first through Jenkins Core then get reused by Jenkins X. 

### Why create a sub project?

We are huge fans of <a href="https://kubernetes.io/">Kubernetes</a> &amp; the cloud and think its
the long term future approach for running software for many folks.

However lots of folks will still want to run Jenkins in the regular jenkins way via: <code>java
-jar jenkins.war</code>


So the idea of the Jenkins X sub project is to focus 100% on the Kubernetes and Cloud Native use
case and let the core Jenkins project focus on the classic java approach.

One of Jenkins big strengths has always been its flexibility and huge ecosystem of different
plugins and capabilities. The separate Jenkins X sub project helps the community iterate and go fast
improving both the Cloud Native and the classic distributions of Jenkins in parallel.                   

