---
title: General questions
linktitle: General questions
description: General questions about the Jenkins X project
weight: 10
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
