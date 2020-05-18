---
title: General Questions
linktitle: General Questions
description: General questions about the Jenkins X project
weight: 20
---

We have tried to collate common issues here with work arounds. If your issue isn't listed here please [let us know](https://github.com/jenkins-x/jx/issues/new).


## Is Jenkins X Open Source?

Yes! All of Jenkins X source code and artifacts are open source; either Apache or MIT and will always remain so!

## How does Jenkins X compare to Jenkins?

Jenkins X provides [automated CI + CD](/about/concepts/features/#automated-pipelines) for applications on kubernetes with [GitOps promotion through environments](/about/concepts/features/#promotion) and [preview environments on Pull Requests
](/about/concepts/features/#preview-environments). (See the [features for more details](/about/concepts/features/)).

Jenkins is a general purpose CI/CD server that can be configured to do anything you like by adding plugins, changing configuration and writing your own pipelines.

With Jenkins X you just [install Jenkins X](/docs/getting-started/) which automatically sets up all of the various tools (helm, docker registry, nexus etc) and then [create](/docs/resources/guides/using-jx/common-tasks/create-spring/)/[import](/docs/resources/guides/using-jx/creating/import/) projects and you get fully automated CI/CD and previews. This lets your developers focus on building applications while you delegate to Jenkins X to manage your CI+CD.

Jenkins X supports different execution engines; so it can orchestrate a Jenkins server per team by reusing Jenkins in a docker container. Though when using [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) we use [Tekton](https://tekton.dev/) rather than Jenkins as the underlying CI/CD engine to provide a modern highly available cloud native architecture.


## Is Jenkins X a fork of Jenkins?

No! Jenkins X can orchestrate Jenkins by reusing it inside a container and configures it to be as kubernetes native as possible.

Though when using [serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) we use [Tekton](https://tekton.dev/) rather than Jenkins as the underlying CI/CD engine to provide a modern highly available cloud native architecture.

## Why create a sub project?

We are huge fans of <a href="https://kubernetes.io/">Kubernetes</a> &amp; the cloud and think its
the long term future approach for running software for many folks.

However lots of folks will still want to run Jenkins in the regular jenkins way via: <code>java
-jar jenkins.war</code>

So the idea of the Jenkins X sub project is to focus 100% on the Kubernetes and Cloud Native use
case and let the core Jenkins project focus on the classic java approach.

One of Jenkins big strengths has always been its flexibility and huge ecosystem of different
plugins and capabilities. The separate Jenkins X sub project helps the community iterate and go fast
improving both the Cloud Native and the classic distributions of Jenkins in parallel.

