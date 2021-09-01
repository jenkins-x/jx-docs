---
title: "Continuous microservices with databases in Jenkins X"
date: 2021-06-25
draft: false
description: automate your CI/CD with microsevices, databases and preview environments
categories: [blog]
keywords: [Community, 2021]
slug: "jx-cd-databases-2021"
aliases: []
author: Jenkins Strachan
---

A common question we get asked on the [Jenkins X project](https://jenkins-x.io/) is how to get started creating microservices that use databases with [automated CI/CD](/v3/develop/create-project/) with [GitOps Promotion](/v3/develop/environments/promotion/) and [Preview Environments](/v3/develop/environments/preview/).

To make things a little easier to get started we've created a new [node-postgresql](https://github.com/jenkins-x-quickstarts/node-postgresql) quickstart.

## Before you start

If you are using the cloud then we prefer [cloud over kubernetes](/v3/devops/patterns/prefer_cloud_over_kube/) for things like databases, storage, ingress and secret managers so please try use your clouds managed databases if you can.

So ideally you'd set up your database via your infrastructure as code solution, such as [terraform](https://www.terraform.io/), and then associate your [kubernetes Service Account to a cloud IAM role](/v3/devops/patterns/map-sa-to-cloud-iam/) to access the database.

However to provide something simple that just works in any kubernetes cluster this quickstart uses the [postgres-operator](https://github.com/zalando/postgres-operator) to manage setting up each database cluster in each environment. So to be able to use this quickstart you will need to install this operator into your cluster.

You can [add charts to your cluster via the CLI](/v3/develop/apps/#using-the-cli). From inside a git clone of your cluster git repository run the following command:

```bash
jx gitops helmfile add --chart commonground/postgres-operator --repository https://charts.commonground.nl/ --namespace postgres --version 1.6.2
```

This will modify the `helmfile.yaml` to point at a new `helmfiles/postgres/helmfile.yaml` file to deploy the [postgres-operator](https://github.com/zalando/postgres-operator) chart.

Then git commit and push that change to your cluster. You can watch it run via `jx admin log -w`.

## Create the quickstart

Make sure you have an [up to date cluster](/v3/admin/setup/upgrades/cluster/) as this particular quickstart is new and only shows up in recent clusters.

Now [create the quickstart](/v3/develop/create-project/#create-a-new-project-from-a-quickstart) in the usual way...

```bash
jx project quickstart
```

If you know you want to create the [node-postgresql](https://github.com/jenkins-x-quickstarts/node-postgresql) quickstart you can do this to pre-filter the list for you:

```bash
jx project quickstart -f postgres
```

Once you have finished the import process will [set up the webhooks and enable CI/CD](/v3/about/how-it-works/#importing--creating-quickstarts) and the application will be released and promoted to the staging environment.

If you want to know more about what happens as you create quickstarts or import projects [see how it works](/v3/about/how-it-works/#importing--creating-quickstarts).

You can watch via the various pipelines run in the various [UI options](/v3/develop/ui/) or via the CLI use:

```bash
jx pipeline grid 
```

When the release is done and the promotion has completed you should be able to try it out via:

```bash
jx application get 
```

You should be able to click on the URL for the new quickstart and try it out once the database is initialised and the pods start up.

It can take a few minutes first time you deploy the quickstart for the database cluster to be setup and initialised; so you can watch the pods run via

```bash
kubectl get pod -n jx-staging -w 
```

For a deeper look into whats going on try:

```bash
jx ui
```

Which will open the [Octant UI with the Jenkins X plugin](/v3/develop/ui/octant/) which lets you navigate around namespaces and look at all of your kubernetes resources, deployments, pods and so forth in real time.

## How does it work

In many ways this chart is fairly similar to other quickstarts in that it uses the Jenkins X pipeline catalog with tekton to add automated CI/CD pipelines and so forth.

However to support the database there is a custom chart included inside this quickstart that does a few different things...

* it creates a `Postgresql` custom resource for the [postgres-operator](https://github.com/zalando/postgres-operator) which will instruct the [postgres-operator](https://github.com/zalando/postgres-operator) to spin up a database cluster and generate a `Secret` to access the database. You can view this in your file at `charts/$myAppName/templates/` or [this file in the quickstart](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/charts/templates/db-postgresql.yaml)
* there is a `charts/$myAppName/init.sql` file or [this file in the quickstart](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/charts/init.sql) which is used to setup the database tables and populate any initial data. You can use this file to perform any startup schema migration or data population. For more realistic applications you could use a custom tool and image to implement schema migration in a more sophisticated way.
* the `init.sql` script is then installed as a `ConfigMap` via the `charts/$myAppName/templates/initdb-cm.yaml` file or [this file in the quickstart](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/charts/templates/initdb-cm.yaml)
* the `charts/$myAppName/templates/deployment.yaml` file or [this file in the quickstart](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/charts/templates/deployment.yaml#L41-L57) defines:
  * an in [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) which sets up the database before the application starts to run. The nice thing about using an init container for schema migration is that it runs before any new version of your application gets any network traffic so that you can keep iterating on your microservice and keep changing your database schema across all of your environments and things work well.
    * Though make sure your init container performs database locking correctly so that multiple init containers running concurrently don't block each other unnecessarily. If this becomes an issue you could introduce something a little more complex. e.g. include a `Job` with a unique name for each release in your chart to perform the migration so that only one migration Job runs at once and have your [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) wait for your job to complete.
  * the Deployment also uses [a secret created by the postgresql operator](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/charts/templates/deployment.yaml#L69-L73) to be able to connect to the database

### Previews

Databases often need a fair amount of maintenance, backup, upgrading and clean up over time. e.g. you may periodically update your Staging database with data from Production (maybe anonymised in some way?).

So creating a whole new database from scratch for every [Preview Environment](/v3/develop/environments/preview/) to test every code change in your microservice is maybe overkill.

By default the preview environment of this quickstart is configured to reuse the Staging environments database. This speeds up the preview startup time and reduces your cloud footprint and infrastructure cost.

This is done via:

* [configuring the preview environment](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/preview/values.yaml.gotmpl#L1-L7) to point at the database in the staging namespace and disabling the creation of the Posgresql custom resource to create a new database cluster in the preview environment
* using the [helmfile hooks mechanism](https://github.com/roboll/helmfile#hooks) in previews to [copy the required database secrets from the staging namespace](https://github.com/jenkins-x-quickstarts/node-postgresql/blob/master/preview/helmfile.yaml#L32-L44) so that the preview can connect to the staging database.

## How we can improve

This quickstart is just a start but we can improve in a number of directions - fancy [helping out](https://jenkins-x.io/community/)?

### More languages and frameworks

It should be easy to replicate the same kind of quickstart mechanism for other languages and frameworks if anyone fancies trying it out? :) We [love contributions](https://jenkins-x.io/community/)! Pop by and chat with us on [slack](https://jenkins-x.io/community/#slack) if you want to discuss it further.

### Cloud databases

Longer term it would be nice to support other kinds of database operators too.

We prefer [cloud over kubernetes](/v3/devops/patterns/prefer_cloud_over_kube/) so if you are using a cloud it would be better to default to a cloud database instead of a kubernetes hosted one.

There are a number of other ways to define cloud infrastructure via [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) such as:

* [AWS Controllers for Kubernetes](https://aws-controllers-k8s.github.io/community/)
* [Azure Service Operator](https://github.com/Azure/azure-service-operator)  
* [Crossplane](https://crossplane.io/)
* [Google Config Connector](https://cloud.google.com/config-connector/docs/overview)

So it'd be interesting to see if we can replicate this model for other kinds of cloud database on different cloud providers. Mostly it'd be a [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) to define the database instance and a way to inject the host and secret.  Some database providers require an additional sidecar proxy too.

It would be easy to add optional configuration in the quickstart to support either the [postgres-operator](https://github.com/zalando/postgres-operator) or equivalents in [AWS Controllers for Kubernetes](https://aws-controllers-k8s.github.io/community/), [Azure Service Operator](https://github.com/Azure/azure-service-operator), [Crossplane](https://crossplane.io/) or [Google Config Connector](https://cloud.google.com/config-connector/docs/overview) via a simple flag in the `chart/$name/values.yaml` file

### More modularity options

In a pure microservice kind of world, each database would be owned by a single microservice; so embedding the database definition and schema migration into a single helm chart is the simplest thing that can work across multiple environments and with progressive delivery etc. It makes it easier to tie changes to the microservice and schema together into a single chart.

However sometimes you want to have multiple services sharing a database. For that you could have 1 microservice be the owner of the database and other services reuse it. Or you could separate out the database definition + migration to a separate helm chart which is released independently.

So it might make sense to make separate quickstart just to define the database definition and schema migration for these use cases: maybe via a `Job` rather than an [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)).

## Conclusion

So there's a really quick way to spin up a node based microservice using a database with an operator handling the setup of the database cluster which works well with [multiple environments](/v3/develop/environments/promotion/), progressive delivery and [Preview Environments](/v3/develop/environments/preview/).

Give it a try and [let us know how you get on or if you can think of any more ways we can improve](/community/)
