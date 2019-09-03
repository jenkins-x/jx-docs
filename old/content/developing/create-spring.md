---
title: Create Spring Boot
linktitle: Create Spring Boot
description: How to create new Spring Boot applications and import them into Jenkins X
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 40
weight: 40
sections_weight: 40
categories: [fundamentals]
draft: false
toc: true
---

                
If you are developing Java microservices then you may well be using the popular [Spring Boot](https://projects.spring.io/spring-boot/). 

You can create new Spring Boot applications using the [Spring Boot Initializr](http://start.spring.io/) and then [import them into Jenkins X](/developing/import) via the [jx import](/commands/jx_import) command.
 
However another alternative is to use the [jx create spring](/commands/jx_create_spring) command which provides a fast automated path.

There is a [demo of using the command: jx create spring](/demos/create_spring/) or you can try it out yourself in a terminal:


```shell
$ jx create spring -d web -d actuator
```

The `-d` argument lets you specify the Spring Boot dependencies you wish to add to your spring boot application.  You can omit the `-d` arguments and let the `jx` command prompt you to pick the dependencies via a CLI wizard

We highly recommend you always include the **actuator** dependency in your Spring Boot applications as it helps provide health checks for [Liveness and Readiness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/).

The [jx create spring](/commands/jx_create_spring) will then:

* create a new Spring Boot application in a subdirectory
* add your source code into a git repository 
* create a remote git repository on a git service, such as [GitHub](https://github.com)
* push your code to the remote git service
* adds default files:
  * `Dockerfile` to build your application as a docker image
  * `Jenkinsfile` to implement the CI / CD pipeline
  * helm chart to run your application inside Kubernetes
* register a webhook on the remote git repository to your teams Jenkins
* add the git repository to your teams Jenkins
* trigger the first pipeline 

