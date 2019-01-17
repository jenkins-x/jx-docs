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

If you are using Google's GKE then you can browse the [GKE Console](https://console.cloud.google.com) to view all the clusters and click on the `Connect` button next to your development cluster and then that lets you copy/paste the command to connect to the cluster.

For other clusters we are planning on writing some [CLI commands to export and import the kube config](https://github.com/jenkins-x/jx/issues/1406).

Also CloudBees have a [commercial addon to Jenkins X called CloudBees Core](https://www.cloudbees.com/products/cloudbees-core-for-kubernetes-continuous-delivery) which adds Single Sign On and a single pane of glass UI to visualise teams, pipelines, logs, environments, applications, versions and infrastructure. This will hopefully be available as a freemium distribution soon. The CloudBees Core UI provides an easy way for anyone in your team to login to Jenkins X from the command line with the `Connect` button on the `Teams` page which uses [jx login](/commands/jx_login/) 

### Once the user has access to the kubernetes cluster

Once your user has access to the kubernetes cluster:

* [install the jx binary](/getting-started/install/)

If Jenkins X was installed in the namespace `jx` then the following should [switch your context](/developing/kube-context/) to the `jx` namespace:

    jx ns jx

To test you should be able to type:

    jx get env
    jx open

To view the environments and any development tools like the Jenkins or Nexus consoles.

## How do I upgrade my Jenkins X installation?

You can upgrade via the [jx upgrade](/commands/jx_upgrade/) commands. Start with 

```shell 
jx upgrade cli
```

to get you on the latest CLI then you can upgrade the platform:

```shell 
jx upgrade platform
```

## How does `--prow` differ from `--gitops`

* `--prow` uses [serverless jenkins](/news/serverless-jenkins/) and uses [prow](https://github.com/kubernetes/test-infra/tree/master/prow) to implement ChatOps on Pull Requests.
*  `--gitops` is still work in progress but will use GitOps to manage the Jenkins X installation (the dev environment) so that the platform installation is all stored in a git repo and upgrading / adding Apps / changing config is all changed via Pull Requests like changes to promotion of applications to the Staging or Production environments

## How do I reuse my existing Ingress controller?

By default when you [install Jenkins X into an existing kubernetes cluster](/getting-started/install-on-cluster/) it prompts you if you want to install an Ingress controller. Jenkins X needs an Ingress controller of some kind so that we can setup `Ingress` resources for each `Service` so we can access web applications via URLs outside of the kubneretes cluster (e.g. inside web browsers).

The [jx install](/commands/jx_install/) command takes a number of CLI arguments starting with `--ingress` where you can point to the namespace, deployment name and service name of the ingress controller you wish to use for the installation. 

We do recommend you use the default ingress controller if you can - as we know it works really well and only uses a single LoadBalancer IP for the whole cluster (your cloud provider often charges per IP address). However if you want to point at a different ingress controller just specify those arguments on install:

```shell 
jx install \
  --ingress-service=$(yoursvcname) \
  --ingress-deployment=$(yourdeployname) \
  --ingress-namespace=kube-system
```


