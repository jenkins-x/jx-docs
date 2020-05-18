---
title: Components
linktitle: Components
description: Component overview of a typical Jenkins X installation
weight: 10
---

An installation of Jenkins X consists of:

* a Development Environment per team which is a [kubernetes namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
* zero to many other [Permanent Environments](/about/concepts/features/#environments) 
  * the out of the box is for each team to get their own `Staging` and `Production` environments
  * each team can have as many environments as they wish and can call them whatever they like 
* optional [Preview Environments](/about/concepts/features/#preview-environments) 

Typically each environment is associated with its own [kubernetes namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) which are usually different to ensure clean isolation between the environments. 

Though technically 2 teams could share the same underlying namespace for, say, `Staging` though we advise separation to keep things simple - otherwise changes in one git repo could conflict with changes in another if they both configure the same namespace; due to, say, service resource name or DNS conflicts. If you wish 2 teams to share the same underlying microservices its much simpler to just use `service linking` to link services in one namespace to another so that they appear as local services with local DNS.

See the full list of [components of Jenkins X](/docs/reference/components/)

## Development Environment

In the dev environment we have installed a number of core applications we believe are required at a minimum to start folks off with CI/CD on Kubernetes. 

We also support [addons](/about/concepts/features/#applications) to extend this core set. 

Jenkins X comes with configuration that wires these services together meaning everything works together straight away. This dramatically reduces the time to get started with Kubernetes as all the passwords, environment variables and config files are all setup up to work with each other.

1. __Jenkins__  — provides both CI and CD automation. There is an effort to decompose Jenkins over time to become more cloud native and make use of Kubernetes concepts around CRDs, storage and scaling for example.
2. __Nexus__ — acts as a dependency cache for NodeJS and Java applications to dramatically improve build times. After an initial build of a SpringBoot application the build time is reduced from 12 minutes to 4. We have not yet but intend to demonstrate swapping this with Artifactory soon.
3. __Docker registry__  — an in cluster docker registry where our pipelines push application images, we will soon switch to using native cloud provider registries such as Google Container Registry, Azure Container Registry or Amazon Elastic Container Registry (ECR) for example.
4. __ChartMuseum__ — a Repository for publishing Helm charts
5. __Monocular__  — a UI used for discovering and running Helm charts

## Permanent Environments

These [environments](/about/concepts/features/#environments), like `Staging` and `Production` use GitOps to manage themselves and so each have a git repository containing the source code to configure all the applications and services which are deployed there.

Typically we use Helm charts in these git repositories to define which charts are to be installed, which versions of them and any environment specific configuration and additional resources (e.g. Secrets or operational applications like Prometheus etc)

## Preview Environments

[Preview Environments](/about/concepts/features/#preview-environments) are similar to [Permanent Environments](/about/concepts/features/#environments) in that they are defined in source code using Helm charts.

The main difference is preview environments are configured inside the application source code in the `./chart/preview` folder.

Also they are not permanent but created on a Pull Request to an applications git repository and then deleted some time after (manually or via automatic garbage collection).


## Ingress Custom Annotations

To learn how to add custom annotations to the ingress controller, please see [How To Add Custom Annotations to Ingress Controller?](/docs/resources/guides/using-jx/faq/#how-to-add-custom-annotations-to-ingress-controller)

