---
title: Multiple Clusters
linktitle: Multiple Clusters
description: Use separate cluster, account or clouds
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
weight: 30
---

A common requirement for a production setup is to isolate your Development, Staging and Production environments onto separate kubernetes clusters and to isolate the clusters from each other in separate cloud accounts or VPNs etc.

You can do this by installing the `Environment Controller` chart into your Staging or Production cluster.

## Goal

Our assumption with the Environment Controller is that we need something that:

* runs inside your Staging or Production cluster to avoid having to expose write/admin access to Staging/Production outside of your cluster
* has a small with minimal RBAC footprint so it can be installed in any namespace in any Staging/Production cluster which are usually really locked down for security
* makes few assumptions about the cluster (e.g. does not depend on a particular Ingress controller)
* does not require access to the development cluster or anything else in Jenkins X other than the environments git repository and a docker + chart repository


## Creating your Dev cluster

If you are creating a new installation then when you use [jx create cluster](/commands/jx_create_cluster) or [jx install](/commands/jx_install) then please specify `--remote-environments` to indicate that `Staging/Production` environments will be remote from the development cluster.

e.g.

```sh
jx create cluster gke --remote-environments --tekton
```

When creating your Environments via [jx create environment](/commands/jx_create_environment) you can also specify the environment is remote via the `--remote` or answering `Y` to the question when prompted.

What this means is that if an environment is remote to the development cluster then we don't register the release pipeline
of the environment in the Dev cluster; we leave that to the Environment Controller to perform running inside the remote cluster.


## Configure an existing Dev cluster

If you already have a Dev cluster that was setup with `Staging` and `Production` namespaces inside your Dev cluster then please do the following:

Edit the environments to mark them as remote via [jx edit environment](/commands/jx_edit_environment):

```sh
jx edit env staging --remote
jx edit env production --remote
```

You need to manually disable the release pipeline in the Dev cluster.

e.g. by removing the `postsubmit` setting in your Prow configuration if you are using [serverless Jenkins X Pipelines and tekton](/docs/concepts/jenkins-x-pipelines/) - or comment out the `jx step helm apply` command in your `Jenkinsfile` if using static jenkins server


## Installing Environment Controller

First you need to connect to your remote kubernetes cluster for `Staging` or `Production` using your managed kubernetes provider's tooling.

You also need to have RBAC karma to be able to [escalate roles](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#privilege-escalation-prevention-and-bootstrapping) for `Role` and/or `ClusterRole` permissions.

Then to install the Environment Controller use [jx create addon envctl](/commands/jx_create_addon_environment/).

You need to specify the environments git repository and docker registry host and on GCP the project ID:

```sh
jx create addon envctl -s https://github.com/myorg/env-production.git --project-id myproject --docker-registry gcr.io --cluster-rbac true --user mygituser --token mygittoken
```

The installer needs a user + API token for the git repository which it will prompt you for the known values from your `~/.jx/gitAuth.yaml` file so if you already installed Jenkins X it should be able to default those values for you.

If you prefer you can install the helm chart `jenkins-x/environment-controller` directly with helm by specifying the [required values from the values.yaml file](https://github.com/jenkins-x-charts/environment-controller/blob/master/environment-controller/values.yaml#L3-L19)


## Installing Ingress Controller

If you don't already have any kind of Ingress Controller in your remote `Staging` / `Production` cluster then it is recommend - particularly if you want to try out our [quickstarts](/docs/getting-started/first-project/create-quickstart/) which depend on Ingress to be able to be used from a web browser.

To install the default ingress controller into a remote cluster (which doesn't have Jenkins X installed) you can use the command [jx create addon ingctl](/commands/jx_create_addon_ingress/)

```sh
jx create addon ingctl
```

This will setup the Ingress Controller; find its external domain and then setup a Pull Request on the environments git repository so that future promotions in the environment will use the correct `domain` value on the generated `Ingress` resources.


## How it works

On startup the Environment Controller registers itself into the github repository as a webhook endpoint using its LoadBalancer service IP address. If you are using a custom ingress/DNS endpoint you can override this via the `webhookUrl` chart value or [--webhook-url CLI option](/commands/jx_create_addon_environment/)

Whenever there is a push to the `master` branch (PRs and feature branches are handled by your Development cluster) the Environment Controller triggers a new [Jenkins X Pipeline](/docs/concepts/jenkins-x-pipelines/) for the Promotion. All other push events on other branches are ignored (as they are processed by the Development cluster).

Then the tekton controller turns this set of Pipeline resources is turned into one or more Pods which run the pipeline. By default promotion pipelines just use a single pod - but you can [customise your deployment pipeline](/docs/concepts/jenkins-x-pipelines/#customising-the-pipelines) which may use sequential/parallel tasks which result in multiple pods.

Because Environment Controller reacts purely to merges to the environment git repository and we are using canonical git source code; it works with both Static Jenkins Servers and [serverless Jenkins X Pipelines and tekton](/docs/concepts/jenkins-x-pipelines/) in the Development cluster.

## Demo

There was a demo of using environment controller in the [April 19, 2019 Office Hours](/community/april-18/)

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


