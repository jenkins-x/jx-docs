---
title: Multiple Clusters
linktitle: Multiple Clusters
description: Use separate cluster, account or clouds
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 47
weight: 47
sections_weight: 48
draft: false
toc: true
---

A common requirement for a production setup is to isolate your Development, Staging and Production environments onto separate kubernetes clusters and to isolate the clusters from each other in separate cloud accounts.

You can do this by installing the `Environment Controller` chart into your Staging or Production cluster.

## Goal

Our assumption with the Environment Controller is that we need something:

* runs inside your Staging or Production cluster to avoid having to expose write/admin access to Staging/Production outside of your cluster
* has a small with minimal RBAC footprint so it can be installed in any namespace in any Staging/Production cluster - which are usually really locked down for security
* makes few assumptions about the cluster (e.g. does not depend on a particular Ingress controller)
* does not require access to the development cluster or any of Jenkins X - other than the environments git repository


## Installing

There is a single simple install command [jx create addon envctl](https://jenkins-x.io/commands/jx_create_addon_environment/). 

You need to specify the environments git repository and docker registry host and on GCP the project ID:

``` 
jx create addon envctl -s https://github.com/myorg/env-production.git --project-id myproject --docker-registry gcr.io --cluster-rbac true
```

The installer needs a user + API token for the git repository which it will prompt you for the known values from your `~/.jx/gitAuth.yaml` file so if you already installed Jenkins X it should be able to default those values for you.

If you need to you should be able to use the helm chart `jenkins-x/environment-controller` directly too if you properly configure the required `values.yaml`


## How it works

On startup the Environment Controller registers itself into the github repository as a webhook endpoint using its LoadBalancer service IP address. If you are using a custom ingress/DNS endpoint you can override this via the `webhookUrl` property or [--webhook-url CLI option](https://jenkins-x.io/commands/jx_create_addon_environment/)

Whenever there is a push to the `master` branch (PRs and feature branches are handled by your Development cluster) the Environment Controller triggers a new [Jenkins X Pipeline](/architecture/jenkins-x-pipelines/) for the Promotion.

Then thanks to the tekton controller, this ges turned into one or more pods to run the pipeline (usually just one - but a deployment pipeline could use multiple separate tasks).