---
title: What is Jenkins X?
linktitle: What is Jenkins X?
type: docs
description: Introduction to what Jenkins X is
weight: 10
aliases:
   - /v3/about/what/

---

Jenkins X automates and accelerates Continuous Integration and Continuous Delivery for developers on the cloud, so they can focus on building awesome software.

Embracing popular open source projects Jenkins X automates the setup and management to provide an integrated Cloud Native solution teams can use to develop better software faster and more reliably that traditional non cloud solutions.

Open Source projects that Jenkins X integrates with:

- [Kubernetes](https://kubernetes.io/) target platform Jenkins X is installed onto, optionally deploy and run applications built with Jenkins X
- [Tekton](https://tekton.dev/) Cloud Native pipeline orchestration
- [Kuberhealthy](https://comcast.github.io/kuberhealthy/) Periodic health checks of the systems
- [Grafana](https://grafana.com) __[optional]__ Centralised logs and Observability
- [Jenkins](https://www.jenkins.io/) __[optional]__ traditional pipeline orchestration
- [Nexus](https://www.sonatype.com/nexus/repository-oss) __[optional]__ artifact repository

At a high level Jenkins X can be split into a few areas:

### Infrastructure

Jenkins X aims to use the cloud well, Kubernetes to host the core services, storage buckets for long term storage, container registries and hosted serivces like secrets managers. All of this needs to be created and managed.  Jenkins X defers to [Terraform](https://www.terraform.io/) to setup and manage the Cloud infrastructure needed by Jenkins X.

### GitOps

The entire Jenkins X experience is based around Git.  The installation, extensions and applications you develop are managed via a cluster Git repository which is the desired state of your Kubernetes cluster.  A Kubernetes operator runs inside the cluster and polls for changes in the Git repository, applying verified and approved updates.  The cluster Git repository uses [Helmfile](https://github.com/roboll/helmfile/) to describe the helm charts that should be used to install software.  Jenkins X generates the Kubernetes resources defined in the Helmfiles, commits back to Git so the exact state can always be seen via Git.

Using GitOps means familiar processes can be followed when making any change to the cluster, using reviews, automation, traceability and rollbacks to give better control over consuming changes.

Jenkins X also uses GitOps as the way to [upgrade](/v3/admin/setup/upgrades), including new releases of images, helm charts and pakages.

### Secret Management

Using GitOps as above does present a challenge of where to store secrets for your cluster as keeping them in Git is insecure.  There is a way to [encrypt secrets and store them in Git](https://github.com/bitnami-labs/sealed-secrets) but there is a usability issue which makes the approach non trivial to use.  Jenkins X prefers to work with real secret provider solutions like [Vault](https://www.vaultproject.io/) or where possible cloud hosted solutions like [Google](https://cloud.google.com/secret-manager), Azure or Amazon Secrets managers.

Jenkins X GitOps works with [External Secrets](https://github.com/external-secrets/kubernetes-external-secrets) to provide an integrated experience so your secrets source of truth is a secrets manager and the values are replicated into the cluster when needed.

### Pipelines

By default Jenkins X ships with Tekton for a clean declarative cloud native way to describe [pipelines](/v3/develop/pipelines/).  Combined with Lighthouse Jenkins X makes it easy to inherit versioned shared pipeline steps via Git and a simple syntax providing flexibility and easy maintenance.

Jenkins X can also work well with Jenkins for users that have traditional workloads.  This is not installed by default but with Jenkins X it is easy to install any helm chart and so designed to work great with our inspirational project Jenkins.

### ChatOps

With the ever growing number of microservices needing automation, Jenkins X provides the ability to interact with pipelines via comments on pull requests.  [Lighthouse](https://github.com/jenkins-x/lighthouse) has evolved from [Prow](https://github.com/kubernetes/test-infra/tree/master/prow#) which is used heavily in the Kubernetes ecosystem to provide a consistent developer workflow for triggering tests, approvals, hold and other common commands developers use in their everyday activities.

### Developer experience

Along with ChatOps mentioned above Jenkins X aims to help developers have a consistent way of working with their microservices, using a CLI or GUI developers can leverage proven approaches recomended by the [Accelerate book](https://www.amazon.co.uk/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339).

Whether creating or importing new projects that automates the setup of CI and CD, packaging applications so they can deploy and run on Kubernetes or simply release as libraries for downstream applications to use.  Jenkins X helps teams have consistency in the way they are built, developed and improved.

The `jx` CLI helps developers interact with Jenkins X using their terminal.

[For GUI's](/v3/develop/ui), Jenkins X has a plugin for [Octant](https://octant.dev/).  Octant runs outside of the cluster and uses the authentication and permissions users have to interact with Kubernetes resources.

There is also a read only in cluster pipeline dashboard that links via pull requests so users can view logs of builds.
