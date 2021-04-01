---
title: "Scaling Preview Environments with Osiris"
date: 2021-04-01
draft: false
description: Jenkins X v3 now integrates Osiris to help you scale your preview environments
categories: [blog]
keywords: [Community, 2021]
slug: "jx3-osiris-preview-envs"
aliases: []
author: Vincent Behar
---

One of Jenkins X's core features is the [preview environments](/v3/develop/environments/preview/): temporary environments created automatically for each Pull Requests, to deploy your application and its dependencies. You can then use this preview environment to run integration tests, or manually use/test your application.

This is all great until you have more and more applications, each with a few dependencies (postgresql, mongodb, ...) and a few opened pull requests at any time. This means that you'll get more and more pods running in your Kubernetes cluster, in addition to Jenkins X's own components, your build pipelines, and of course your staging and production applications - unless you are using [multi-cluster](/v3/admin/guides/multi-cluster/). The result is that you'll need more nodes or bigger nodes. Which means more money.

But, these preview environments are in fact idle most of the time: they are only used for the integration tests, and sometimes when someone manually uses them. The rest of the time - including all night for example - they are just staying there, idle, and consuming resources. What if we could easily scale them down when they are idle, and automatically bring them up when we need them? So that a Pull Request staying opened for 2 weeks because someone went on vacation won't consume resources in your cluster.

### Osiris

Enter [Osiris](https://github.com/dailymotion-oss/osiris)! Initially created by the [Deislabs team](https://github.com/deislabs), Osiris is a Kubernetes component that will automatically scale down your "idle" pods, and scale them up when a request comes in. Although the [original project](https://github.com/deislabs/osiris) has been archived, the [Dailymotion team](https://github.com/dailymotion-oss) has taken over the maintenance of [a fork](https://github.com/dailymotion-oss/osiris). And they have been using it with success in their Jenkins X dev cluster for more than 2 years: they regularly have around 50 preview environments active at any time, and... 0 pods from these environments running at night - or on weekends. Coupled with a cluster autoscaler, it means that their Kubernetes cluster use between 3 and more than 20 nodes depending on the workload. Being able to scale down to a minimum number of nodes is a great benefit when using cloud resources.

### How can you benefit from it in your own Jenkins X cluster?

- first, you'll need to follow the [admin guide to enable Osiris in your dev cluster](/v3/admin/guides/preview-environments/)
- and then, you'll need to add annotations to your Deployment/Statefulset and Service manifests - as explained in the [Osiris documentation](https://github.com/dailymotion-oss/osiris) - in your application's Helm chart

Note that if you store data, you'll need to use persistent volumes (for postgresql, mongodb, ...) so that you won't lose your data after a scale down/up of your pods.

### How does it work?

Osiris will automatically inject itself as a proxy in front of all the pods with the right annotation, so that it can see all requests for your pods. If it doesn't see any request for a configurable amount of time - 10 minutes by default - it will scale down the deployment (or statefulset), and place itself behind the associated service. So that if a new request comes in, Osiris will be able to scale up the deployment (or statefulset), and then forward the request to the new pod.
