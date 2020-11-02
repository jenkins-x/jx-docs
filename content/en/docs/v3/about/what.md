---
title: What is Jenkins X?
linktitle: What is Jenkins X?
description: Introduction to what Jenkins X is
weight: 10
---
 
Jenkins X aims to automate and accelerate Continuous Integration and Continuous Delivery for developers on the cloud and/or Kubernetes so they can focus on building awesome software and not waste time figuring out how to use the cloud or manually create and maintain pipelines.

Jenkins X 3 focuses on a few main areas:
 
### Infrastructure
 
Moving management of infrastructure outside of Jenkins X, favouring solutions like Terraform.  This reduces the surface area of Jenkins X and leverages expert OSS projects and communities around managing infrastructure and cloud resources.
 
### Secret Management
 
Adding an abstraction layer above secret management solutions so users can choose where the source of secrets can be stored, preferably outside of the Kubernetes cluster.  This is a good practice for disaster recovery scenarios.
 
### Developer experience
 
Jenkins X 3.x includes a revived focus on developer experience.  The introduction of Jenkins X plugins for [Octant](https://octant.dev/) has addressed a long standing request from the open source community.  Jenkins X 3.x will be focussing on new visualisations  to help developers, operators and cross functioning teams.
 
With the jx CLI refactoring described below Jenkins X 3.x is reviewing consistency and usability around CLI experience, please continue to raise [issues](https://github.com/jenkins-x/jx-docs/issues) and reach out in slack / [discourse](https://jenkinsx.discourse.group/) to help improve.
 
### Maintainability
 
Created a new `jx` CLI which includes an extensible plugin model where each main subcommand off the jx base is it's own releasable git repository.  This has significantly improved the Jenkins X codebase which helps with maintainability and contributions.
 
### Removing complexity and magic
 
Removing complexity out of Jenkins X and reusing other solutions wherever possible.  Jenkins X 2.x was tightly coupled to helm 2 for example.  There were `jx` CLI steps that wrapped helm commands when installing applications into the cluster which injected secrets from an internal Vault and ultimately made it very confusing for users and maintainers. 
 
Jenkins X 3.x prefers to avoid wrapping other CLIs unless a consistent higher level UX is being provided say around managing secrets and underlying commands being executed are clearly printed in users terminals.
 
### Documentation
 
We had lots of feedback from users about the Jenkins X documentation was incomplete, inconsistent, old, not relevant or claimed to work but simply did not.
 
Jenkins X 3.x will clearly mark areas that have not been tested and are more experimental while also providing a clearer capability matrix indicating to users the maturity of features and supported platforms.  Added to this we plan to make it easier for users, teams, companies to contribute to Jenkins X.
 
A [special interest group](https://github.com/jenkins-x/jx-community/tree/master/sig-docs) for docs has been set up with the focus on Jenkins X 3.x and will continue to evolve.
 
### Open source
 
Jenkins X 3.x is not only open source but developed and maintained in open source communities. Slack, Discourse and focused special interest groups provide ways for developers, users or keen people to be part of the Jenkins X journey.
 
Jenkins X 3.x will provide clear extension points for non open source functionality to be added but not affect the OSS core.
