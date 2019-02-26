---
title: Custom Jenkins Servers
linktitle: Custom Jenkins Servers
description: How to work with Custom Jenkins Servers in Jenkins X
date: 2019-01-08
publishdate: 2019-01-08
lastmod: 2019-01-08
menu:
  docs:
    parent: "architecture"
    weight: 150
weight: 150
sections_weight: 150
draft: false
toc: true
---

Jenkins X provides automated CI/CD for your libraries and microservices you want to deploy on Kubernetes, but what about those other pipelines you have created on a custom Jenkins Server?

Jenkins X now has a [Jenkins App](https://github.com/jenkins-x-apps/jx-app-jenkins) that makes it easy to add one or more custom Jenkins servers to your Team and use the custom Jenkins Server to implement any custom pipelines you have developed.

This lets you maintain your investment in your existing Jenkins pipelines while you start to use more of the automated CI/CD in Jenkins X for new libraries and microservices. You can then mix and match between the automated CI/CD in Jenkins X and your custom Jenkins pipelines - all orchestrated nicely together with Jenkins X.


## Installing a custom Jenkins

To install the custom Jenkins server you need to run the following command:

```shell 
jx add app jx-app-jenkins
```

This will install a new Jenkins Server in your current Team. It should then show up via...

```
jx open
```    

## Using the custom Jenkins

The `jx` command which work with Jenkins servers can all work directly with your new custom Jenkins server; though you need to specify that you want to interact with a custom Jenkins Server as opposed to the built in execution engine in Jenkins X (e.g. [serverless Jenkins](http://localhost:1313/news/serverless-jenkins/) or the built in Jenkins server inside Jenkins X)

If you only have one custom Jenkins App in your Team you can use `-m` to specify you want to work with a custom Jenkins server. Otherwise you can specify `-n myjenkinsname`.

```shell
# view the pipelines 
jx get pipeline -m

# view the log of a pipeline
jx get build log -m

# view the Jenkins console
jx console -m

# lets start a pipeline in the custom jenkins
jx start pipeline -m
```