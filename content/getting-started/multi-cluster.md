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

A common requirement for a production setup is to isolate your Development, Staging and Production environments onto separate kubernetes clusters and to isolate the clusters from each other in separate cloud accounts or VPNs etc.

You can do this by installing the `Environment Controller` chart into your Staging or Production cluster.

## Goal

Our assumption with the Environment Controller is that we need something that:

* runs inside your Staging or Production cluster to avoid having to expose write/admin access to Staging/Production outside of your cluster
* has a small with minimal RBAC footprint so it can be installed in any namespace in any Staging/Production cluster which are usually really locked down for security
* makes few assumptions about the cluster (e.g. does not depend on a particular Ingress controller)
* does not require access to the development cluster or anything else in Jenkins X other than the environments git repository and a docker + chart repository


## Installing

There is a single simple install command [jx create addon envctl](https://jenkins-x.io/commands/jx_create_addon_environment/). 

You need to specify the environments git repository and docker registry host and on GCP the project ID:

``` 
jx create addon envctl -s https://github.com/myorg/env-production.git --project-id myproject --docker-registry gcr.io --cluster-rbac true
```

The installer needs a user + API token for the git repository which it will prompt you for the known values from your `~/.jx/gitAuth.yaml` file so if you already installed Jenkins X it should be able to default those values for you.

If you prefer you can install the helm chart `jenkins-x/environment-controller` directly with helm by specifying the [required values from the values.yaml file](https://github.com/jenkins-x-charts/environment-controller/blob/master/environment-controller/values.yaml#L3-L19) 


## How it works

On startup the Environment Controller registers itself into the github repository as a webhook endpoint using its LoadBalancer service IP address. If you are using a custom ingress/DNS endpoint you can override this via the `webhookUrl` chart value or [--webhook-url CLI option](https://jenkins-x.io/commands/jx_create_addon_environment/)

Whenever there is a push to the `master` branch (PRs and feature branches are handled by your Development cluster) the Environment Controller triggers a new [Jenkins X Pipeline](/architecture/jenkins-x-pipelines/) for the Promotion. All other push events on other branches are ignored (as they are processed by the Developmnet cluster).

Then the tekton controller turns this set of Pipeline resources is turned into one or more Pods which run the pipeline. By default promotion pipelines just use a single pod - but you can [customise your deployment pipeline](/architecture/jenkins-x-pipelines/#customising-the-pipelines) which may use sequential/parallel tasks which result in multiple pods.

Because Environment Controller reacts purely to merges to the environment git repository and we are using canonical git source code; it works with both Static Jenkins Servers and [serverless Jenkins X Pipelines and tekton](/architecture/jenkins-x-pipelines/) in the Development cluster.

## Demo

There was a demo of using environment controller in the [April 19, 2019 Office Hours](https://jenkins-x.io/community/april-18/)

## Known limitations

The following things are not yet automatically configured for you but we hope to automate them soon:

* currently you have to manually add the `CHART_REPOSITORY` environment variable into the `jenkins-x.yml` file in your environment git repository. e.g. a `jenkins-x.yml` file like this will do the trick - using the real URL to your chartmuseum (use `jx open` in your development cluster:

```yaml 
pipelineConfig:
  env:
  - name: CHART_REPOSITORY
    value: http://chartmuseum.jx.1.2.3.4.nip.io
 ```
 
You can do the above via the [jx create var -n CHART_REPOSITORY](/commands/jx_create_variable/) command if you are inside a clone of the staging/production git repository - then git commit + merge the change.

* You need to manually disable the release pipeline in the Dev cluster - e.g. by removing the `postsubmit` setting in your Prow configuration if you are using [serverless Jenkins X Pipelines and tekton](/architecture/jenkins-x-pipelines/) - or comment out the `jx step helm apply` command in your `Jenkinsfile`
 
 
