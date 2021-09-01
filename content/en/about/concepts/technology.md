---
title: Technology Questions
linktitle: Technology Questions
description: Technology questions on Kubernetes and the associated opens source projects
weight: 50
---

## What is Helm?

[helm](https://www.helm.sh/) is the open source package manager for Kubernetes.

It works like other package mangers (brew, yum, npm etc) where there's one or more repositories with packages to install (called `charts` in helm to keep with the nautical kubernetes theme) which can be searched/installed and upgraded.

A [helm chart is basically a versioned tarball of kubernetes yaml](https://docs.helm.sh/developing_charts/#charts) which can be easily installed on any kubernetes cluster.

Helm supports composition (a chart can contain other charts) via the `requirements.yaml` file.

## What is Skaffold?

[skaffold](https://github.com/GoogleContainerTools/skaffold) is an open source tool for building docker images on kubernetes clusters and then deploying/upgrading them via `kubectl` or `helm`.

One of the challenges of building docker images inside a kubernetes cluster is there are various different approaches to handle this:

* use the local docker daemon and socket of your kubernetes cluster
* use a cloud service such as Google Cloud Builder
* use a docker-daemon less approach such as [kaniko](https://github.com/GoogleContainerTools/kaniko) which does not require access to the docker daemon

Whats nice about skaffold is it abstracts your code or CLI away from those details; you can define the policy for building docker images in your `skaffold.yaml` file to switch between docker daemon, GCB or kaniko etc.

Skaffold is also really useful inside [DevPods](/docs/reference/devpods/) for doing fast incremental builds if you change the source code.

## How does Helm compare to Skaffold?

`helm` lets you install/upgrade packages called charts which use one or more docker images which are in some docker registry along with some kubernetes YAML to install/upgrade apps in a kubernetes cluster.

`skaffold` is a tool for performing docker builds and optionally redeploying apps via `kubectl` or `helm` - either inside a CI/CD pipeline or when developing locally.

Jenkins X uses `skaffold` in its CI/CD pipelines to create docker images. We release versioned docker images and helm charts on each merge to master. Then we promote to environments via `helm`.

## Whats is exposecontroller?

It turns out that exposing services outside of the Kubernetes cluster can be complex. e.g.

* What domain to use?
* Should you use TLS & generate certificates and associate them with the domains?
* Are you using OpenShift if so then maybe using `Route` is better than using `Ingress`?

So we simplify microservices in Jenkins X by delegation to a microservice called [exposecontroller](https://github.com/jenkins-x/exposecontroller) who's job is to take care of that stuff - expose all `Service` resources which have a label to indicate they are intended to be exposed using the current cluster and namespaces's expose rules like the domain and whether or not to use TLS or `Route` versus `Ingress` etc.

If you look inside your environment git repository you may notice 2 `exposecontroller` [charts are there by default](https://github.com/jenkins-x/default-environment-charts/blob/master/env/requirements.yaml)

Those are 2 jobs we use by default to automate generating or cleaning `Ingress` resources to expose labeled `Services`resources that you want to access from outside of the cluster. Eg web apps or rest apis.

You can opt out of exposecontroller if you want - just don’t use the exposecontroller labels on your services. You could remove the exposecontroller job from an environment if you want - though none of our QuickStarts will be accessible from outside the cluster if you do!
