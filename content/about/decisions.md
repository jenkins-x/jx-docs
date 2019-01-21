---
title: Decisions
linktitle: Decisions
description: Documented decisions made by the Jenkins X project
date: 2018-06-29
publishdate: 2017-06-29
lastmod: 2018-06-29
menu:
  docs:
    parent: "about"
    weight: 40
weight: 40
sections_weight: 40
draft: false
aliases: [/about/decisions]
categories: [fundamentals]
toc: true
---

# Decisions

Jenkins X is an opinionated developer experience, here we will explain the background and decisions we have taken to help explain the reasons for these opinions.  You may also want to take a look at the [Accelerate](https://jenkins-x.io/about/opinions/) page for details on how Jenkins X implements the capabilities recommended by 

## Kubernetes

First is why Jenkins X is purely focused on Kubernetes and is only intended to run on it.

Kubernetes has won the cloud wars, every major cloud provider now either supports Kubernetes or is actively working on a Kubernetes solution.  Google, Microsoft, Amazon, Red Hat, Oracle, IBM, Alibaba, Digital Ocean, Docker, Mesos and Cloud Foundry to name a few.  We now have one deployment platform to target and develop first class portable applications for.

The Kuberetes ecosystem is rich with innovation and with a vibrant, forward thinking, diverse open source community which is inviting only suggests great things for all involved.

Jenkins X strongly recommends using public cloud managed Kubernetes clusters where possible. GKE, AKS and EKS all manage and run your Kubernetes masters for __free__ you pay for the worker resources required to run your applications.  This dramatically reduces risk of installing, upgrading and maintaining your Kubernetes cluster.  

i.e. let folks that know how to run containers and manage clusters at scale so you can focus on adding value to your business.


## Draft

[Draft](https://draft.sh) has a few capabilities but Jenkins X only uses the language detection and pack creation feature.  Jenkins X maintains it's own [draft packs](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) tailored to run with Jenkins X.

Draft provides a great way to bootstrap a source code project with the necessary packaging needed to run the application on Kubernetes.

The Draft project came from Deis who were acquired by Microsoft and continue to invest and evolve their Kubernetes developer story.

## Helm

[Helm](https://helm.sh) provides the templated packaging for running applications on Kubernetes.  We've received mixed feedback from our use of Helm.  From our experience being able to template and compose multiple Helm Charts together has been a very welcome find. This lead to our use of using Helm to compose, install and upgrade entire environments and being able to easily override values such as number of replicas or application resource limits per environment for example.

OpenShift Templates aimed to do a similar thing however they are OpenShift specific.

Lots of the concerns with Helm are being addressed with the major version upgrade of Helm 3.  Removing the use of Tiller the server side component of Helm is a big win as it's seen as being insecure given the elevated permissions it needs to run.  Jenkins X provides a way https://jenkins-x.io/architecture/helm3/ to use the beta version of Helm 3 for folks that would like to try this instead, we're using this ourselves and it's working great so far.  If there are issues we'd like to feedback to the Helm project so we can help get them to GA sooner.

The Helm project came from Deis who were acquired by Microsoft and continue to invest and evolve their Kubernetes developer story.

## Skaffold

Jenkins X uses [Skaffold](https://github.com/GoogleContainerTools/skaffold) to perform the build and push image actions in a pipeline.  Skaffold allows us to implement different image builder and registries services like [Google Container Buidler](https://cloud.google.com/container-builder/), [Azure Container Builder](https://github.com/Azure/acr-builder) and [ECR](https://aws.amazon.com/ecr/).  

For folks that aren't running on a public cloud with container builder or registry services then Skaffold can also work with [kaniko](https://github.com/GoogleContainerTools/kaniko), this allows pipelines to build docker images using rootless containers.  This is significantly more secure than mounting the docker socket from each node in the cluster.

## Jenkins

Jenkins as a large JVM that isn't highly available, may seem a surprise to be selected as the pipeline engine to use in the Cloud, however the adoption of Jenkins by developers and the community it has means it is ideal to use and evolve it's own cloud native story.  Already Jenkins X generates Kubernetes Custom Resource Definitions for pipeline activities that our IDE and CLI tooling uses rather than querying Jenkins.  We will be storing Jenkins builds and runs objects in Kubernetes rather than in the `$JENKINS_HOME` which means we can scale Jenkins masters.  We are also switching to Prow to intercept Git webhook events rather than using Jenkins, this means we can have a highly available solution as well as hand off the scheduling of builds to Kubernetes.  

TL;DR we are pushing more of the Jenkins master functionality down into the Kubernetes platform.

Taking this approach also means we will be able to support other pipeline engines in the future as well.

## Prow

[Prow](https://github.com/kubernetes/test-infra/tree/master/prow) handles Git events and can trigger workflows in Kubernetes.

Prow can run in a highly available mode where multiple pods for a webhook ingress URL.  In contrast with Jenkins if you perform an upgrade then Jenkins has some downtime where webhook events can be missed.  This is in our future plans and we hope to be available soon.

## Nexus

[Nexus](https://help.sonatype.com/repomanager3) is an overweight JVM that recently moved to OSGi however it does the job we need of it.  Cache dependencies for faster builds and provide a shared repository where teams can share their released artifacts.  

If someone developed an open source artifact repository server in a more cloud friendly language like Go then Jenkins X would likely switch to save on cloud bills.

Right now Jenkins X doesn't use the docker registry from Nexus.  The main reason was we needed to do some work to setup pod definitions with image pull secrets so we can use the authenticated registry.  Our preferred approach however is to switch to using native cloud provider registries like Amazon's [ECR](https://aws.amazon.com/ecr/), [Google Container Regitry](https://cloud.google.com/container-registry/) or Dockerhub for example with the help of Skaffold.

## Docker registry

As above, we don't intend to use [this registry](https://github.com/kubernetes/charts/tree/master/stable/docker-registry) long term as we prefer using cloud provider registries like Amazon's [ECR](https://aws.amazon.com/ecr/), [Google Container Regitry](https://cloud.google.com/container-registry/) or Dockerhub for example with the help of Skaffold.

## ChartMuseum

At time of creating Jenkins X there were few options of how to publish Helm Charts, the Kubernetes community uses GitHub pages but we wanted to find a solution that works for folks that use any git provider.  [ChartMuseum](https://github.com/kubernetes-helm/chartmuseum) is written in Go so performs well in the cloud, it supports multiple cloud storage and works great with Monocular.

## Monocular

We use [Monocular](https://github.com/kubernetes-helm/monocular) to discover our Teams published applications, we could use KubeApps by default instead if it is preferred by the community but we'll enable KubeApps as an addon regardless.

## Git

Jenkins X only works with Git.  There are a lot of dependencies and client implementations Jenkins X already needs to support for different Git providers, we don't hear enough demand to support other version control systems so for now Jenkins X is tied to Git.

## Programming languages

Jenkins X aims to help provide the right level of feedback for developers to understand how their applications are performing and give them easy ways to experiment with other languages which may suit both the feature and running on the Cloud better.  For example there are a lot of Java based organisations that only know how to write, run and maintain Java applications.  Java is extremely resource intensive compared with Golang, Rust, Swift, NodeJS to name a few, this results in much much higher cloud bills each month.  With Jenkins X we aim to help developers experiment with other options using quickstarts and metrics addons like Grafana and Prometheus to see how they behave in the cloud.

For example any new microservice that we build on the Jenkins X project tends to be in either Golang or NodeJS given the huge effect is has on our cloud billing.  It does take time to shift to a new programming language but with Jenkins X we hope we can mitigate a lot of risk using quickstarts, automated CI/CD and a relatively consistent way of working on all languages.

### Maven

Maven has some tooling that a lot of folks are used to using which doesn't suit CD particularly well.  For example the [maven release plugin](http://maven.apache.org/maven-release/maven-release-plugin/) will version a project and commit directly back to master the new next SNAPSHOT version which in CD world would trigger another release resulting in a recursive loop.

For Java projects Jenkins X uses the [maven version:set plugin](https://www.mojohaus.org/versions-maven-plugin/set-mojo.html) to update all poms in a project using the next release version following the #Versioning step mentioned above.

If a new major or minor version increment is needed users can create a new Git tag with the new major / minor number and Jenkins X will respect that.  Alternatively you can update the parent `pom.xml` and any child pom files yourself and Jenkins X will detect and use the new major or minor version.
