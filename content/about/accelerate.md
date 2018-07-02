---
title: Accelerate
linktitle: Accelerate
description: Jenkins X uses Capabilities identified by the Accelerate book
date: 2018-07-01
publishdate: 2018-07-01
lastmod: 2018-07-01
menu:
  docs:
    parent: "about"
    weight: 10
weight: 10
sections_weight: 0
draft: false
aliases: [/about/accelerate]
categories: [fundamentals]
toc: true
---

Jenkins X is an implementation heavily influence by the State of DevOps reports and more recently the [Accelerate](https://www.amazon.co.uk/Accelerate-Software-Performing-Technology-Organizations/dp/1942788339) book from [Nicole Forsgren](https://twitter.com/nicolefv), [Jez Jumble](https://twitter.com/jezhumble) and [Gene Kim](https://twitter.com/RealGeneKim?).  

Years of gathering data from real world teams and organisations which has been analysed by inspiring thought leaders and data scientists from the DevOps world.  The Accelerate book recommends a number of capabilites that Jenkins X is implementing so users gain the scientifically proven benefits, out of the box.  Below we have started describing how Jenkins X helps address the identified capabilities are easier than others so we will be continually improving these implementations as we gather more feedback from the OSS community.

# Capability: Use version control for all artifacts

The Weaveworks folks coined the term GitOps which we love.  Any change to an environment, whether it be a new application, version upgrade, resource limit change or simple application configuration should be raised as a Pull Request to Git, have checks run against it like a form of CI for environments and approved by a team that has control over what goes into the related environment.  We now enable governance have full traceability for any change to an environment.

_Related Accelerate capability:  Use version control for all production artifacts_

# Capability: Automate your deployment process

## Environments

Jenkins X will automatically create Git backed environments during installation and makes it easy to add new ones using `jx create environment`.  Additionally when creating new applications via a quickstart (`jx create quickstart`), Java based SpringBoot (`jx create spring`) or importing existing applications (`jx import`), Jenkins X will both automatically add CI / CD pipelines and setup the jobs, git repos and webhooks to enable an automated deployment process.

Out of the box Jenkins X creates Staging and Production (this is customisable) perminant environments as well as temporary environments for preview applications from Pull Requests.

### Previews Environments

We are trying to move as much testing, security, validation and experimentation for a change before it's merged to master.  With the use of temporary dynamically created Preview Environments any pull request can have a preview version built and deployed, including libraries that feed into a downstream deployable application.  This means we can code review, test, collaborate better with all teams that are involved in agreeing that change can go live.

Ultimatelty Jenkins X wants to provide a way that developers, testers, designers and product managers can be as sure as they can that when a change is merged to master it works as expected.  We want to be confident the proposed change does not negatively affect any service or feature as well as deliver the value it is intended to.

Where Preview Environments get really interesting is when we are able to progress a PR through various stages of maturity and confidence where we begin to direct a percentage of real production traffic like beta users to it.  We can then analyse the value of the proposed change and possible run multiple automated experiments over time using Hypothesis Driven Development.  This helps give us better understanding of how the change will perform when released to all users.

_Related Accelerate capability: Foster and enable team experimentaion_

Using preview environments is a great way to introduce better test automation.  While Jenkins X enables this we don't yet have examples of automated tests being run against a preview environment.  A simple test would be to ensure the application starts ok and Kubernetes liveness check pass for an amount of time. This relates to 

_Related Accelerate capability: Implement Test Automation_
_Related Accelerate capability: Automate your deployment process_

### Perminant Environments

In software develelopment we're used to working with multiple environments in the lead up to a change being promted to a live production environment.  Whilst this seems business as unual it can cause significant delays to other changes if for any reason that it is deemed not fit via some process that didn't happen pre merge to master.  Subsequest commits then become blocked and can cause delay of urgent changes being promoted to production.

As above Jenkins X wants any changes and experiments to be validated before it is merged to master.  We would like changes in a staging environment to be held there for a short amount of time before being promoted, ideally in an automated fasion.

The default Jenkins X pipelines provide deployment automation via environments.  These are customizable to suite your own CI / CD pipeline requirements.

Jenkins X recommends Staging should act as a near as possible reflection on production, ideally with real production data shadowed to it using a service mesh to understand the behaviour.  This also helps when developing changes in preview where we can link to non production services in staging.

_Related Accelerate capability: Automate your deployment process_

# Capability: Use trunk-based developement

The Accelerate book found that teams which use trunk based development with short lived branches performed better.  This has always worked for the Jenkins X core team members so this was an easy capability for Jenkins X to implement when setting up Gir repositries and CI/CD jobs.

# Capability: Implement Continious Integration

Jenkins X sees CI as the effort of validating a proposed change via pull requests before it is merged to master.  Jenkins X will autmatically configure source code repositories, Jenkins and Kubernetes to provide Continuos Integration of the box.

# Capability: Implement Continious Delivery

Jenkins X sees CD as the effort of taking that change after it's been merged to master through to running in a live environment.  Jenkins X automates many parts in a release pipeline:

Jenkins X advoates the use of semantic versioning.  We use git tags to calculate the next release version which means we don't need to store the latest release version in the master branch.  Where release systems do store the last or next version in Git repos it means CD becomes hard, as a commit in a release pipeline back to master triggers a new release.  This results in a recursive release trigger.  Using a Git tag helps avoid this situation which Jenkins X completely automates.

Jenkins X will automatically create a released version on __every__ merge to master which can then potentially progress through to production.

# Capability: Use loosly coupled architecture

By targetting Kubernetes users of Jenkins X can take advantage of many of the cloud features that help design and develop loosly coupled solutions.  Service discovery, fault tolerance, scalability, health checks, rolling upgrades, container scheduling and orchestration to name just a few examples of where Kubernetes helps.

# Capability: Architect for empowered teams

Jenkins X aims to help polyglot application developers.  Right now Jenkins X has quickstarts and automated CI/CD setup with language detection for Golang, Java, NodeJS, .Net, React, Angular, Rust, Swift and more to come.  What this also does is provide a consistent Way Of Working so developers can concentrate on developing.

Jenkins X also provides many addons, for example Grafana and Prometheus for automated metrics collection and vilualisation.  In this example centralised metrics help understand how your applications behave when built and deployed on Kubernetes.

[DevPods](https://jenkins-x.io/developing/devpods/) are another feature which enables developers to edit source code in their local IDE, behind the scenes it is then synced to the cloud and rapidly built and redeployed.

Jenkins X believes providing developers automation that helps them experiment in the cloud, with different technoligies and  feedback empoweres them to make the best decisions - faster.