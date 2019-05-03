---
title: Progressive Delivery
linktitle: Progressive Delivery
description: Gradually rollout changes and canary releases
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 230
weight: 230
sections_weight: 230
draft: false
toc: true
---

It's likely you have heard of "blue green deployment" or "canary deployment". The idea is to carefully roll out new versions of your application, if problems happen (gasp!) in production, then the system will automatically roll them back, and the majority of users will not be impacted. 

This has become a popular CD technique over the years. 

As Jenkins X runs on top of Kubernetes, there are some additional built in protections about starting new versions: if a new application fails to start, it is likely that it will never really make it to production, this is a good thing! And you get it for free!

Progressive Delivery takes this a bit further: changes can be rolled out to a small percentage of users or traffic (say 1%) and then progressively released to more users (say 5%) before the delivery is considered complete. 

At each stage, metrics and health checks are continuously monitored: should things go wrong, the application will automatically be rolled back to the previous known good version.

With Jenkins X applications and environments, you can have this happen automatically for you, without any per app specific configuration (you can override certain settings on a case by case basis). This includes metrics and health checks and more. 

## How to setup

As this is a larger topic, and an evolving feature - please read the instructions on Carlos blog here: https://blog.csanchez.org/2019/03/05/progressive-delivery-with-jenkins-x-automatic-canary-deployments/

This page will be updated as the feature evolves over time to be easier to use. 



