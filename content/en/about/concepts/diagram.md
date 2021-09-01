---
title: Diagram
linktitle: Diagram
description: A diagram of the Jenkins X architecture
weight: 20
---

There are several architectures based on how you choose to install Jenkins X. We show you two common architectures below.

## Jenkins X with Tekton

This is the default setup of Jenkins X

<figure>
<img src="/images/ArchitectureServerlessJenkins.png"/>
<figcaption>
<h5>Architecture for a serverless deployment using Tekton Pipelines</h5>
</figcaption>
</figure>

## Jenkins X with Tekton & Lighthouse

This is a setup of Jenkins X with [Lighthouse](https://github.com/jenkins-x/lighthouse) instead of Prow (soon to be default)

<figure>
<img src="/images/ArchitectureServerlessJenkinsLighthouse.png"/>
<figcaption>
<h5>Architecture for a serverless deployment using Tekton Pipelines and Lighthouse</h5>
</figcaption>
</figure>
