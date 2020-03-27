---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 1
description: >
  How to get up and running with Jenkins X
aliases:
  - /getting-started
---

<!-- If you're looking to take Jenkins X for a spin (or not interested in running it yourself) the quickest way to get up and running, is using the [CloudBees CI-CD powered by Jenkins X](https://www.cloudbees.com/products/cloudbees-ci-cd/overview) which is a SaaS running on Jenkins X. -->

<!--
The simplest way to get started is via the [Google Cloud Tutorials](/docs/managing-jx/tutorials/google-hosted/). -->


### Latest Jenkins X

* Install [the jx command line tool](/docs/getting-started/setup/install/) for your platform. 

* Next Create a cluster. You can use the [jx command line](/commands/jx_create_cluster/) to create a cluster or [follow instructions for your platform of choice](/docs/getting-started/setup/create-cluster/). 

* Once you have a Kubernetes cluster, then [install Jenkins X on your Kubernetes cluster with Jenkins X Boot](/docs/getting-started/setup/boot/).

* Then check out [your next steps](/docs/getting-started/next/).


There are a few other ways for users to trial and run Jenkins X in production that have been developed from the Jenkins X open source project:

## Stable distribution

* The [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview) - is released monthly based on the open source binary that is then battle tested and verified by CloudBees. CJXD is free to download and use, with optional paid [commercial support](https://www.cloudbees.com/products/cloudbees-jenkins-x-support/overview) available should you need it. 

## Jenkins X as a service

* [CloudBees CI-CD powered by Jenkins X](https://www.cloudbees.com/products/cloudbees-ci-cd/overview) - is CI/CD as a service so you don't need to worry about setting up and managing Jenkins X. A Preview Experience of the new Jenkins X SaaS is currently available. Sign up [here to try out the new Jenkins X Saas](https://www.cloudbees.com/products/cloudbees-ci-cd/overview)!

## Step by Step Guide

There are many guides available that can take you through nuances for your platform if you search the web. [This guide](http://sharepointoscar.com/2020-01-10-Installing-Jenkins X/) takes you through setting up a cluster on GKE and using GitHub with a custom DNS name.

