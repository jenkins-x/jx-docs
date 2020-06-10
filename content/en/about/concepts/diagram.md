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


# What gets deployed in Kubernetes?
Below are two diagrams depicting this.  We have one diagram with Prow enabled.  The other diagram is using Lighthouse, the Prow replacement.

{{% alert color="info" %}}

NOTE:  In the lighthouse edition of the diagram, we also show the HashiCorp Vault deployments

{{% /alert %}}

## Diagram shows all Deployments when using Prow
{{< svg "static/images/deployments_prow.svg" >}}


## Diagram shows all Deployments when using Lighthouse
{{< svg "static/images/deployments_lighthouse.svg" >}}

