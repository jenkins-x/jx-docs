---
title: "Jenkins X 3.x walkthroughs"
date: 2021-01-26
draft: false
description: A collections of Jenkins X 3 guides
categories: [blog]
keywords: [Community, jx3, 2021]
slug: "jx3-walkthroughs"
aliases: []
author: James Rawlings
---
 
Jenkins X 3.x is now looking ahead towards a GA release, with that we are producing walkthroughs for key areas to help users not only get started but get the most out of Jenkins X.

To kick this off we are going to start with 9 videos that we'll follow up with more dedicated blogs over the coming weeks.  The complete playlist can be found [here](https://www.youtube.com/playlist?list=PLr_PmC4W69dKM3fo8OK729fdmX_MTqdHd) however the blog below gives a more context for each one.

There are a few key areas we are focusing on here:

## Intro + high level architecture

Starting off with a very quick introduction including what to expect from the walkthrough series.

<iframe width="600" height="300" src="https://www.youtube.com/embed/kDCNDAyqwpo?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Jenkins X 3.x has focussed on clearer lines of separation, making the architecture significantly more pluggable, extensible and maintainable.  With better tooling including UIs and more reliable guard rails for installations and upgrades.  Jenkins X 3 also minimises abstractions and wrapping; so it promotes the direct use of open source projects like Helm, Helmfile and Tekton.

<iframe width="600" height="300" src="https://www.youtube.com/embed/bVp5_tZ21AA?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Installation and setup

## Infrastructure and provisioning

Decoupling the management of Cloud infrastructure away from Jenkins X to tools that are better suited for the job.  Jenkins X has started with Terraform and this manages all the cloud resources needed by Jenkins X

- Kubernetes cluster
- Cloud Service Accounts
- IAM bindings
- Storage buckets

Over time Jenkins X plans to support other tools (aided by the [Kubernetes Cluster API](https://github.com/kubernetes-sigs/cluster-api)) users in the Kubernetes ecosystem leverage such as [crossplane.io](https://crossplane.io/), [Google Config Connector](https://cloud.google.com/config-connector/docs/overview), [AWS Controller](https://github.com/aws/aws-controllers-k8s) etc.  These make use of cloud resources declared as custom resources with a Kubernetes operator managing CRUD activities for them.

Once the cloud infrastructure is created, self provisioning happens using GitOps and incluster installation.  No more flakey client side installs.

<iframe width="600" height="300" src="https://www.youtube.com/embed/fKGZrNgs8So?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## TLS and DNS

A large number of deployments require inbound traffic, whether that is for access to their applications, websites, REST endpoints, Webhook handlers there is often a need for Ingress HTTP traffic into a cluster and to ensure communication is secure.

To achieve this there are two common efforts needed

DNS - configuring a custom owned domain and using DNS to route traffic to endpoints
TLS - providing end to end security for web traffic on the internet

In fact many web services do not accept working with insecure endpoints and others require manual override to accept the risk before being able to use the service.

Jenkins X uses two OSS projects to automatically manage DNS ([External DNS](https://github.com/kubernetes-sigs/external-dns)) and handle the management of TLS certificates ([Cert-manager](https://cert-manager.io/))

Once a domain is owned, External DNS will work with cloud providers to create A records that route traffic from the internet to users clusters.  Cert-manager will react to a request from Jenkins X to verify a cluster owns a domain and will issue a wildcard TLS certificate using Lets Encrypt that is used for all Ingress into the cluster.  Cert-manager will also handle certificate renewals.  This is all handled automatically following the setup of Jenkins X.

<iframe width="600" height="300" src="https://www.youtube.com/embed/OqsSqZqF0gY?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Using Jenkins X

## GitOps

Initially started out as an implementation detail of Jenkins X but has evolved much more into an administrators typical workflow.  Managing installs, upgrades and rollbacks via Git provides approvals, reviews, traceability, RBAC in the same way we manage code.  This is the backbone of Jenkins X and provides us with the peace of mind for disaster recovery.

Jenkins X ships with a git operator which is responsible for applying generated Kubernetes resources which live in the cluster Git repository.  Every application and configuration for the cluster is in this repository.

## Health

In any Kubernetes installation there can be a lot of microservices each with the responsibility to provide functionality that is needed by the overall system.  Understanding when things go wrong and the impact of these issues can be difficult to evaluate.  It is also useful to have a status page of sorts to quickly check the health of your system.

Jenkins X uses [Kuberhealthy](https://github.com/Comcast/kuberhealthy) and a lot of custom health checks to periodically report on the health of a Jenkins X installation.  These custom health checks are easy to extend in any language, already the Jenkins X community has been contributing their own.

There is a CLI which can be used to query the health report as well and a UI.

The health statuses can be easily integrated into users operational alerting systems too.

<iframe width="600" height="300" src="https://www.youtube.com/embed/4wqwulEzseM?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Extending pipelines

Jenkins X uses vanilla Tekton pipeline resources and has deprecated the v2 `jenkins-x.yml`.

We will show a demo shortly of working with Tekton pipelines and inheriting shared Tasks but for now we can see it is easy using Lighthouse to trigger shared Pipelines from a git repository.  The demo uses the old favorite from the Jenkins project Chuck Norris, only here we are invoking a cloud native pipeline to comment with the joke on a Pull Request.

<iframe width="600" height="300" src="https://www.youtube.com/embed/cJcwV4jgE0Y?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Secrets

Secrets management stores (e.g. AWS Secrets Manager, Hashicorp Vault, Google Secrets Manager) have gained popularity from both Administrators and Developers.  Having a single source of truth for a secret is extremely useful especially when obtaining and changing values, some solutions even offer automatic secret rotation.

With GitOps as described above we need a way to inject real secrets into a cluster rather than storing them in Git.

Jenkins X uses [External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) from which runs as a Kubernetes controller, using a Kubernetes Custom Resource it knows how to automatically map values from a Secret Management Store into Kubernetes Secrets.  This makes it easy for applications to leverage GitOps while keeping the benefits of using a secrets management solution.

<iframe width="600" height="300" src="https://www.youtube.com/embed/_gjGfwlxEY4?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Upgrades

Jenkins X now uses GitOps for the whole cluster, one repository keeps all applications and configurations that should be applied to a cluster.  This cluster repository also includes a copy of the version stream mentioned below.  Jenkins X uses a tool called [kpt](https://github.com/GoogleContainerTools/kpt) which reliable syncrosises released version configuration into their own repository that can then be committed and applied to your cluster.

## Version Streams

The world of continuous delivery can bring challenges.  One of the biggest challenges Jenkins X itself had while embracing CD was how people handle receiving constant change via releases.

Some people wanted to live on the bleeding edge, receiving fixes, improvements and new features as fast as possible so they can help provide feedback and continually improve.  Others had more stable requirements which expect more mature features along with corresponding complete documentation that gave better confidence an upgrade will not cause any adverse effects.

Jenkins X has had the concept of version streams which allows the project to collect a number of helm charts, CLI, Docker image version changes together, run further automated testing and release together for users to consume in an upgrade.  This acts as a quality gate.

For Jenkins X 3 we have extended this to include a second version stream which gets automatically updated via a Pull Request however that is merged on a slower cadence to cater for users that want greater confidence in the release.  We call this the [Long Term Support (LTS) version stream](/v3/guides/upgrades/lts).

Users can decide which version stream to track or even use a custom one that they maintain themselves.

<iframe width="600" height="300" src="https://www.youtube.com/embed/9ZaqdwD3cTs?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Cluster recovery

Clusters can be recreated if they move regions, are accidentally deleted or part of intentional housekeeping to continually verify disaster recovery processes.

Because Jenkins X uses Terraform for infrastructure checked into Git and a another Git repository specifically for the cluster, it means we can recreate a cluster and resume all services with very little manual intervention.  This video deletes and recovers a cluster on GCP using Jenkins X.

<iframe width="600" height="300" src="https://www.youtube.com/embed/2QgX3cn0GqU?VQ=HD1080" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
