---
title: Getting Started
linktitle: Getting Started
description: Using Jenkins X to continuously deliver value to your customers
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: []
keywords: []
menu:
  docs:
    parent: "developing"
    weight: 1
weight: 45
draft: false
aliases: [/developing/]
toc: false
---


There are a couple of ways that you as a developer can quickly become productive when editing an app.  Jenkins X allows you to edit app code by using a Kubernetes Pod which we call `DevPod`.  This allows you to develop inside the cloud with the same container images and pod templates as the CI/CD pipelines.

There are specifics to each approach, and so we provide you a visual representation of each workflow, as well as the specific steps to quickly get started.

## Develop Using DevPods and an IDE
In this scenario, you are using an IDE such as Atom or VSCode which in fact has a plugin for `Jenkins X`.  You are making changes using your IDE and said changes are reflected immediately when you open the `url` assigned to your `DevPod`

{{% note %}}
See [IDE](http://localhost:1313/developing/ide/#vs-code) for more details on using VSCode
{{% /note %}}

To get started using this approach, simply execute the following command in the root of your app directory.

```bash
  jx create devpod --reuse --sync 
```
A successful execution will ensures the following happened:

- Output the `URLs` available to access the `Pod`
- App folder will sync with the `Pod`
- An ssh session is initiated to the `Pod`

Once this happens, you must execute one more command within your ssh session to the Pod to ensure any changes are synchronized.

```bash
./watch.sh
```

{{% note %}}
 From this point forward, any changes you make, trigger a Docker Image build, and you should see the output of that in your terminal
{{% /note %}}

<img src="/images/developing/developer_workflow_ide.png" class="img-thumbnail">

Once you are happy with changes to your app, you check-in your code, create a `Pull Request` and a `Jenkins X Pipeline` is triggered to promote your changes to `Staging` enviornment.



## Develop Using DevPods and Web-based IDE (Theia)
                    


