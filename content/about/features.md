---
title: Jenkins X Features
linktitle: Features
description: 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "about"
    weight: 20
weight: 20
sections_weight: 20
draft: false
aliases: [/about/features]
toc: true
---


## Command Line

Jenkins X comes with a handy [jx](/commands/jx) command line tool to easily:

* [install Jenkins X](/commands/jx_install) inside your existing kubernetes cluster
* [create a new kubernetes cluster](/commands/jx_create_cluster) and install Jenkins X into it
* [import projects](/commands/jx_import) into Jenkins X and their Continuous Delivery pipelines setup
* [create new Spring Boot applications](/commands/jx_create_spring) which get imported into Jenkins X and their Continuous Delivery pipelines setup

## Pipelines

Rather than having to have deep knowledge of the internals of Jenkins Pipeline, Jenkins X will default awesome pipelines for your projects that implements fully CI and CD using [DevOps best practices](/about/concepts)
     
## Environments

Each team gets a set of Environments. Jenkins X then automates the management of the Environments and the Promotion of new versions of Applications between Environments via GitOps.

## Preview Enviroments

Jenkins X automatically spins up Preview Environments for your Pull Requests so you can get fast feedback before changes are merged to master.


## Feedback

Jenkins X automatically comments on your Commits, Issues and Pull Requests with feedback as code is ready to be previewed, is promoted to environments or if Pull Requests are generated automatically to upgrade versions. 

## Applications

A collection of best of breed software tools packaged as helm charts that come pre-integrated with Jenkins X such as: Nexus, Artifactory, SonarQube, Prometheus, Elasticsearch, Grafana etc
upgrade versions. 