---
title: Concepts
linktitle: Concepts
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
aliases: [/about/concepts]
toc: true
---
## DevOps

Jenkins X is designed to make it simple for developers to work to DevOps principles and best practices.

### Principles
---
*"DevOps is a set of practices intended to reduce the time between committing a change to a system and the change being placed into normal production, while ensuring high quality."*

The goals of DevOps projects are:

* Faster time to market
* Improved deployment frequency
* Shorter time between fixes
* Lower failure rate of releases
* Faster Mean Time To Recovery

High performing teams should be able to deploy multiple times per day compared to the industry average that falls between once per week and once per month. 

The lead time for code to migrate from 'code committed' to 'code in production' should be less than one hour and the change failure rate should be less than 15%, compared to an average of between 31-45%.

The Mean Time To Recover from a failure should also be less than one hour. 

Jenkins X has been designed from first principles to allow teams to apply DevOps best practices to hit top-of-industry performance goals.

### Practices
---
The following best practices are considered key to operating a successful DevOps approach:

* Loosely-coupled Architectures
* Self-service Configuration
* Automated Provisioning
* Continuous Build / Integration and Delivery
* Automated Release Management
* Incremental Testing
* Configuration as Code

Jenkins X brings together a number of familiar methodologies and components into an integrated approach that minimises complexity.

## Architecture

Jenkins X builds upon the DevOps model of loosely-coupled architectures and is designed to support you in deploying large numbers of distributed microservices in a repeatable and manageable fashion, across multiple teams.

## Building Blocks

Jenkins X builds upon the following core components:

### Kubernetes & Docker

At the heart of the system is Kubernetes, which has become the defacto virtual infrastructure platform for DevOps. The Kubernetes platform extends the basic Containerisation principles provided by Docker to span across multiple physical Nodes. In brief, Kubernetes provides a homogeneous virtual infrastructure that can be scaled dynamically by adding or removing Nodes. Each Node participates in a single large flat private virtual network space. 

The unit of deployment in Kubernetes is the Pod, which comprises one or more Docker containers and some meta-data. All containers within a Pod share the same virtual IP address and port space. Deployments within Kubernetes are declarative, so the user specifies the number of instances of a given version of a Pod to be deployed and Kubernetes calculates the actions required to get from the current state to the desired state, by deploying or deleting Pods across Nodes. The decision as to where specific instances of Pods will be instantiated is influenced by available resources, desired resources and label-matching. Once deployed, Kubernetes contracts to ensure that the desired number of Pods of each type remain operational by performing periodic health checks and terminating and replacing non-responsive Pods.

To impose some structure, Kubernetes allows for the creation of virtual Namespaces which can be used to seperate Pods logically, and to potentially associate groups of Pods with specific resources. Resources in a Namespace can share a single security policy, for example. Resource names are required to be unique within a Namespace but may be reused across Namespaces.

In the Jenkins X model, a Pod equates to a deployed instance of a Microservice (in most cases). Where horizontal scaling of the Microservice is required, Kubernetes allows multiple identical instances of a given Pod to be deployed, each with its own virtual IP address. These can be aggregated into a single virtual endpoint known as a Service which has a unique and static IP address and a local DNS entry that matches the Service name. Calls to the Service are dynamically remapped to the IP of one of the healthy Pod instances on a random basis. Services can also be used to remap ports. 

### Helm

### Jenkins

### Maven

### Draft

