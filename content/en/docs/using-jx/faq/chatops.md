---
title: ChatOps Questions
linktitle: ChatOps Questions
description: Questions on using ChatOps with Jenkins X
weight: 20
---

For more background see the guide on [Serverless Jenkins X Pipelines](/docs/concepts/jenkins-x-pipelines/) using [Tekton](https://tekton.dev/). There is also the [Jenkins X Pipelines Syntax Reference](/docs/reference/pipeline-syntax-reference/)

## What is ChatOps?

We use the phaes _ChatOps_ to mean operating code changes via chat. More specifically this usually is done via commenting on Pull Requests using comments; though in the future this could be via Slack or web consoles too.


## Which kinds of webhook support ChatOps?

[Prow](/docs/reference/components/prow/) and [Lighthouse](/architecture/lighthouse/) support webhooks and [ChatOps](/docs/using-jx/faq/chatops) whereas Jenkins just supports webhooks.


