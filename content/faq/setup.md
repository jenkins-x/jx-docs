---
title: Setup Questions
linktitle: Setup Questions
description: Questions about installing or configuring Jenkins X
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

## How do I add a user to my Jenkins X installation?

Jenkins X assumes each user has access to the same development kubernetes cluster that Jenkins X is running on.

If your user does not have access to the kubernetes cluster we need to setup their `~/.kube/config` file so that they can access it. 

If you are using Google's GKE then you can browse the [GKE Console]() to view all the clusters and click on the `Connect` button next to your development cluster and then that lets you copy/paste the command to connect to the cluster.

For other clusters we are planning on writing some [CLI commands to export and import the kube config](https://github.com/jenkins-x/jx/issues/1406).

### Once the user has access to the kubernetes cluster

Once your user has access to the kubernetes cluster:

* [install the jx binary](/getting-started/install/)

If Jenkins X was installed in the namespace `jx` then the following should [switch your context](/developing/kube-context/) to the `jx` namespace:

    jx ns nx

To test you should be able to type:

    jx get env
    jx open

To view the environments and any development tools like the Jenkins or Nexus consoles.

    