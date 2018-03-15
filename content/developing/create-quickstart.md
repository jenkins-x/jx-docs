---
title: Create Quickstart
linktitle: Create Quickstart
description: How to create a new quickstart application and import it into Jenkins X
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 45
weight: 45
sections_weight: 45
categories: [fundamentals]
draft: false
toc: true
---

                
You can create new applications from our list of curated Quickstart applications via the [jx create quickstart](/commands/jx_create_quickstart) command.


```shell
$ jx create quickstart
```

You are then prompted for a list of quickstarts to choose from.

If you know the language you wish to use you can filter the list of quickstarts shown via:

```shell
$ jx create quickstart  -l go
```

Or use a text filter to filter on the project names:

```shell
$ jx create quickstart  -f http
```

Once you have chosen the project to create and given it a name the following is automated for you:

* creates a new application from the quickstart in a sub directory
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

