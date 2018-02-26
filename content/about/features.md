---
title: Jenkins X Features
linktitle: Jenkins X Features
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

Reusable pipeline flows that work out of the box for most common languages for full CI / CD on kubernetes

## Environments

Automatically migrate your application through separate environments via helm and GitOps

## Applications

A collection of best of breed software tools packaged as helm charts that come pre-integrated with Jenkins X such as: Nexus, Artifactory, SonarQube, Prometheus, Elasticsearch, Grafana etc

