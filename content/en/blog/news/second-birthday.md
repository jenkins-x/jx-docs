---
title: "Happy Second Birthday Jenkins X!"
date: 2020-01-14
description: >
    Second year of Jenkins X
categories: [blog]
keywords: []
slug: "happy-second-birthday"
aliases: []
author: Rob Davies
---

The Jenkins X project started the beginning of 2019 by celebrating its first birthday on the 14th January, a big event for any open source project, and we have just celebrated our 2nd - hooray!

<!-- <figure>
<img src="/images/second-birthday/cupcake.png" width="40%" float="left">
</figure> -->

<figure>
<img src="/images/second-birthday/7TH_BIRTHDAY.png" width="55%" float="center">
</figure>

image by Ashley McNamara, [creative commons license](https://github.com/ashleymcnamara/gophers/blob/master/7TH_BIRTHDAY.png)

## Two Years of Jenkins X!

Jenkins X has evolved from a vision of how CI/CD could be reimagined in a cloud native world, to a fast-moving, innovative, rapidly maturing open source project.  


Jenkins X was created to help developers ship code fast on Kubernetes. From the start, Jenkins X has focused on improving the developer experience. Using one command line tool, developers can create a Kubernetes cluster, deploy a pipeline, create an app, create a GitHub repository, push the app to the GitHub repository, open a Pull Request, build a container, run that container in Kubernetes, merge to production. To do this, Jenkins X automates the installation and configuration of a whole bunch of best in breed open source tools, and automates the generation of all the pipelines. Jenkins X also automates the promotion of an application through testing, staging, and production environments, enabling lots of feedback on proposed changes. For example, Jenkins X preview environments allow for fast and early feedback as developers can review actual functionality in an automatically provisioned environment. We’ve found that preview environments, created automatically inside the pipelines created by Jenkins X, are very popular with developers, as they can view changes before they are merged to master.


Jenkins X is opinionated, yet easily extensible. Built to enable DevOps best practices, Jenkins X is designed to the deployment of large numbers of distributed microservices in a repeatable and manageable fashion, across multiple teams. Jenkins X facilitates proven best practices like trunk based development and GitOps. To get you up and running quickly, Jenkins X comes with lots of example quickstarts.


# Highlights of 2019

## February 2019: The rise of Tekton!

In the second half of 2018, Jenkins X embarked on a journey to provide a Serverless Jenkins and run a pipeline engine only when required. That pipeline engine was based on the knative build-pipeline project which evolved into Tekton with much help and love from both the Jenkins and Jenkins X communities. [The Jenkins X project completed its initial integration with Tekton in February 2019](https://jenkins-x.io/blog/2019/02/19/jenkins-x-next-gen-pipeline-engine/). Tekton is a powerful and flexible kubernetes-native open source framework for creating CI/CD pipelines, managing artifacts and progressive deployments.

<figure>
<img src="/images/second-birthday/plane.png" width="40%" float="left">
</figure>

## March 2019: Jenkins X joined The Continuous Delivery Foundation!

<figure>
<img src="/images/logo/cdf-logo.png" width="40%" float="left">
</figure>

Jenkins X joined the Continuous Delivery Foundation (CDF) as a founding project alongside Jenkins, Spinnaker, and Tekton. Joining a vendor-neutral foundation, focused on Continuous Delivery, made a lot of sense to the Jenkins X community. There had already been a high level of collaboration with the Jenkins and Tekton communities, and there have been some very interesting and fruitful (in terms of ideas) discussions about how to work better with the Spinnaker communities also.

## June 2019: Project Lighthouse

When Jenkins X embarked on its serverless jenkins journey, it chose to use [Prow](https://github.com/kubernetes/test-infra/tree/master/prow), an event handler for GitHub events and ChatOps. Prow is used by the Kubernetes project for building all of its repos and includes a powerful webhook event handler. Prow is well proven, but heavily tied to GitHub, and not easily extendable to other SCM providers.  At the end of June 2019, work commenced on a lightweight, extensible alternative to Prow, called [Lighthouse](https://jenkins-x.io/docs/reference/components/lighthouse/). Lighthouse supports the same plugins as Prow (so you can still ask via ChatOps for cats and dogs) and the same config - making migration between Prow and Lighthouse extremely easy.

## June 2019: Jenkins X Boot!

We were very busy in June - a frantic burst of activity before summer vacations!  One common problem Jenkins X users were facing was the installation of Jenkins X on different Kubernetes clusters.  Installing services, ensuring DNS and secrets are correct, and done in the right order is completely different from vendor to vendor, and sometimes cluster to cluster. We realised that to simplify the install, we really needed a pipeline, and whilst this may sound a little like the plot to a film, running a  Jenkins X pipeline to install jx really is the best option. The [jx boot command](https://jenkins-x.io/docs/getting-started/setup/boot/) interprets the boot pipeline using your local jx binary. The jx boot command can also be used for updating your cluster.

<!-- <figure>
<img src="/images/second-birthday/street.png" width="40%" float="left">
</figure> -->

## July 2019: A New Logo!

As part of the move to the CDF the Jenkins X project took the opportunity to redesign its  logo. An automaton represents the ability of Jenkins X to provide automated CI/CD on Kubernetes and more!  

<figure>
<img src="/images/second-birthday/jx-logo-stacked-color.png" width="80%" float="left">
</figure>

## Second half 2019: Big focus on Stability and Reliability

The Jenkins X project has been fast paced with lots of different components and moving parts. This fast pace unfortunately led to some instability and a growth of serious issues that risked undermining all the great work there had been on Jenkins X. There has been a concerted effort by the community to increase stability and reduce outstanding issues - the graph below shows the trend over the last year, with a notable downward trend in the number of issues being created in the last 6 months.

<figure>
<img src="/images/second-birthday/graph.png" width="80%" float="left">
</figure>


CloudBees also aided this effort by introducing the [CloudBees Jenkins X Distribution](https://www.cloudbees.com/products/cloudbees-jenkins-x-distribution/overview) with increased testing around stabilized configurations and deployments and regular releases every month.

## October 2019: Jenkins X Steering Committee inaugural meeting

The Jenkins X Bootstrap Steering Committee is tasked with organising the transition to an elected steering committee, as well as determining what responsibilities the steering committee will have in guiding the Jenkins X project.

## December 2019: First Jenkins X Outreachy mentee!

<figure>
<img src="/images/community/events/outreachy.png" width="80%" float="left">
</figure>

Neha Gupta is adding support for Kustomize in Jenkins X, to enable Kubernetes native configuration management, while participating in Outreachy from December 2019 to March 2020. We welcome Neha’s work on Jenkins X and look forward to building on our culture of continuous mentoring!

## Jenkins X usage in Products

The easiest way to try out Jenkins X is undoubtedly through [CloudBees CI/CD powered by Jenkins X](https://www.cloudbees.com/products/cloudbees-ci-cd/overview) which provides Jenkins X through the convenience and ease of use of SaaS. No cluster setup, no Jenkins X install, that is all done for you! Currently, [CloudBees CI/CD powered by Jenkins X](https://www.cloudbees.com/products/cloudbees-ci-cd/overview) is available for preview. Sign up [here to try out the new Jenkins X Saas](https://www.cloudbees.com/products/cloudbees-ci-cd/overview)!

<figure>
<img src="/images/second-birthday/boxes.png" width="40%" float="left">
</figure>

## What’s next?

The Jenkins X project is going to be encouraging the community to get involved with more innovation. There are a lot of great ideas to extend the continuous story with integrated progressive delivery (A/B testing, Canary and Blue/Green deployments) and Continuous Verification, alongside more platforms support. We are expecting lots of awesome new features in the [CloudBees UI for Jenkins X](https://docs.cloudbees.com/docs/cloudbees-jenkins-x-distribution/latest/user-interface/) too.


Expect lots more exciting new announcements from Jenkins X in 2020!

