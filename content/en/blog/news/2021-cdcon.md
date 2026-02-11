---
title: "Jenkins X at cdCon"
date: 2021-06-22
draft: false
description: overview of Jenkins X related sessions at cdCon 2021
categories: [blog]
keywords: [Community, 2021]
slug: "jx-cdCon-2021"
aliases: []
author: Jenkins Strachan
---

[cdCon 2021](https://events.linuxfoundation.org/cdcon/) is about to start with lots of [great sessions](https://events.linuxfoundation.org/cdcon/program/schedule/).

Here' a list of the [Jenkins X related](https://jenkins-x.io/) sessions:
            
## Tuesday, June 22 GitOps Summit

* [Best Practices for Secret Management with GitOps](https://sched.co/il6v) - [Kara de la Marck](https://gitopssummit2021.sched.com/speaker/kdelamarck), CloudBees
    * GitOps uses Git as the “single source of truth” for declarative infrastructure and enables developers to manage infrastructure with the same Git-based workflows they use to manage a codebase. Having all configuration files version-controlled by Git has many advantages, but best practices for securely managing secrets with GitOps remain contested. Join us in this presentation about GitOps and Secret Management. Attendees will learn about different approaches to secret management with GitOps, the issues involved, and the secret management solutions offered by various tools and platforms. We will discuss the pros and cons of Vault, SOPS, offerings by public cloud providers, and more.

## Wednesday, June 23
                 
* [MLOps with Jenkins-X: Production-ready Machine Learning](https://sched.co/ios6) by [Terry Cox](https://cdcon2021.sched.com/speaker/terry289)
    * Explore ways to treat Machine Learning assets as first class citizens within a DevOps process as Jenkins-X MLOps Lead, Terry Cox demonstrates how to automate your training and release pipeline in Cloud environments, using the library of ML template projects provided with Jenkins-X.
* [Enabling a DevOps Mindset at Scale in an Enterprise](https://sched.co/iouo) by Jimmy McNamara & Nick Penston, Fidelity Investments
    * Talk through the cultural enablers to create a strong DevOps culture within large organisations. Nick and Jimmy will talk through the cultural enablers to support large numbers of very talented and ambitious cloud engineers. Touching on strategies supporting strong communication and talent development for cloud engineers. Key themes: Talent Development Enabling DevOps culture Harnessing the voice of the developer/cloud engineer
* [BoF Session: Jenkins X - James Strachan & James Rawlings, Cloudbees](https://sched.co/j06v) by James Strachan & James Rawlings
    * This BoF will be an open discussion on anything related to Jenkins X, automating Continuous Delivery, Kubernetes, cloud and how to Accelerate delivering value to your customers


## Thursday, June 24

* [How Jenkins X is Integrating Observability from the Inside, and the Benefits for its Users](https://sched.co/ios0) by [Vincent Behar](https://cdcon2021.sched.com/speaker/vincent.behar1), Dailymotion
    * In this session, we'll focus on observability for Jenkins X: what observability means for a Continuous Delivery platform such as Jenkins X, and why it's important.
    * We'll see how Jenkins X v3 is integrating observability from the inside, using standards such as OpenTelemetry, and packaging a full observability stack using Grafana - with Loki, Promtail, Tempo, and Prometheus.
    * And we'll highlight the benefits for the users:
      * platform observability with alerting for all the Kubernetes components (Lighthouse, Tekton, Cert-Manager, ...)
      * out-of-the-box dashboards for Continuous Delivery Indicators (Mean Lead Time, Time To Review, Release, and Deployment Frequency, ...)
      * distributed traces for your pipelines
* [What's new with Jenkins X 3](https://sched.co/iotV) by James Rawlings & James Strachan, CloudBees
    * This session will cover the architectural improvements and new features of Jenkins X v3. 
    * We'll dive into the key areas that have undergone major development. 
    * GitOps: a better approach to installation and upgrades leveraging Helmfile, using an in-cluster operator to apply desired state stored in Git. 
    * Secrets: out of the box integration with external secret management solutions such as Google + Amazon cloud services Infrastructure: decoupled infrastructure management using Terraform UX: hosted dashboard to link your pull request logs along with a local Octant UI for deeper cluster visualisations
    * Cloud Native Pipelines: now using vanilla Tekton pipelines with no abstraction layer. 
    * Along with Lighthouse to handle both in repo and shared pipeline definitions we now have a clean, extendable way to describe pipelines. Health: health checks and insight via Grafana
    
* [Embrace ChatOps by Following the git-flow as Usual](https://sched.co/iote) by [Rick Zhao](https://cdcon2021.sched.com/speaker/rick417), Qingcloud
    * Simplicity matters. It’s not desirable for us to invest in more systems or platforms. The best scenario is to keep our daily work unchanged. For example, software engineers usually spend a lot of time writing codes or documents and also have interactions with various pull requests. Lighthouse is similar to Prow, but it supports multiple git providers. We can speed up delivery no matter if you're using GitHub, Gitlab, or Gitea.
