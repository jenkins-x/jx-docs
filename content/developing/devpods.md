---
title: Dev Pods
linktitle: Dev Pods
description: Develop in a pod on your cloud 
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 220
weight: 220
sections_weight: 220
draft: false
toc: true
aliases: [/developing/devpods/]
---

The initial focus of Jenkins X is around automating and improving CI/CD for kubernetes. The use of [Preview Environments](/about/features/#preview-environments) really helps to validate and approve Pull Requests before they get merged to `master`; but how do you try things out before you are ready submit a Pull Request?

Jenkins X has a concept of `Dev Pods` which are pods for developers to use as a terminal/shell which are based on the exact same operating system, docker containers and tools installed as the [pod templates](/architecture/pod-templates/) used in the Jenkins X CI/CD pipelines.
 
This lets build, run tests or redeploy apps before you commit to git safe in the knowledge you're using the exact same tools as the CI/CD pipelines!

## Creating a DevPod

To create your own `DevPod` use the command [jx create devpod](/commands/jx_create_devpod/). For example if you want to create a `maven` based DevPod use:

```shell 
jx create devpod -l maven
```     

This will then create a new `DevPod` based on the maven based [pod template](/architecture/pod-templates/) and open your terminal inside that pod. You are now free to use the various tools like `git, docker, maven, skaffold, jx` which will all be using the same exact configuration as the CI/CD pipelines will.

## Opening a DevPod shell

If you have other terminals that want to connect into an existing `DevPod` use [jx rsh -d](/commands/jx_rsh/)

```shell 
jx rsh -d
```  

If you have more than one `DevPod` active you will be prompted for the list of available `DevPod`s to pick from. Otherwise your shell will open in the `DevPod` directly.

### Viewing my DevPods

Use the [jx get devpod](/commands/jx_get_devpod/) command:

        
```shell 
jx get devpod
```   

### Deleting a DevPod

Use the [jx delete devpod](/commands/jx_delete_devpod/) command:

        
```shell 
jx delete devpod
```   

Then pick the devpod to delete and confirm. Or pass in the name of the devpod you want to delete as an argument.


## Synchronizing

Having a DevPod is cool and all but many folks want to edit source code in their preferred IDE like [VS Code](https://code.visualstudio.com/) or [IDEA](https://www.jetbrains.com/idea/).

So once you have a DevPod you can synchronise your local source code into your DevPod via the [jx sync](/commands/jx_sync/) command in the directory of your source code:

```shell
cd myApp 
jx sync
```   

This command will download and install the excellent [ksync](https://github.com/vapor-ware/ksync) tool if its not already installed, run `ksync init` to add it to your cluster and then run `ksync watch` and then use `ksync create` to create a synchronisation spec.

Then by default the code with be bidirectionally synchronized between the current directory and the `/code` folder in the `DevPod`. You can now edit the code in your IDE and run build/test commands inside the `DevPod`!

e.g. you can build your code with whatever tools you are using (`maven, gradle, make` etc), perform `docker` builds or run `skaffold` in developer mode.

Over time we are hoping to polish this experience to make it super easy to edit code in your IDE and get fast reloading working inside the kubernetes cluster using the same kubernetes resources, manifests and services!

## Incremental building

One of the benefits of integrating with [skaffold](https://github.com/GoogleContainerTools/skaffold) for building docker images is that we can perform incremental rebuilds of docker images and redeploys of the associated helm charts.

So inside of your DevPod you can perform a regular build if your app is Java based. e.g. via maven:

```shell
mvn install
```
    
Then to trigger incremental rebuilding and deploying of the local code in the DevPod you can use:

```shell
skaffold dev -p dev
```
    
This will use the `dev` profile to generate a new docker image using the generated _digest_ then use it in the helm chart to deploy.

When you created your DevPod it was associated with an _Edit Environment_ for your _username_ so that any apps deployed in a DevPod will appear in your _Edit Environment_.

So once the `skaffold dev -p dev` command has built the docker image and installed the helm chart, your app will show up via  [jx get applications](/commands/applications):
                                                                                                 
```shell
jx get applications
```

Now if you edit code and trigger a docker rebuild, which for most languages is just changing the source code; though for Java apps its whenever you rebuild the jar - the image is regenerated and the helm chart updated!        






