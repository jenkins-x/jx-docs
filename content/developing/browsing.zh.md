---
title: 浏览
linktitle: 浏览
description: 浏览 Jenkins X 中的资源
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
menu:
  docs:
    parent: "developing"
    weight: 50
weight: 50
sections_weight: 50
draft: false
toc: true
---

                
If you have used kubernetes before you're probably used the [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command line to view kubernetes resources:

```shell
kubectl get pods
```

The Jenkins X command line tool, [jx](/commands/jx), has a similar look and feel to [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) and lets you get the status of all the Jenkins X resources.

### View Jenkins Console
 
If you are familiar with the Jenkins console then you can use [jx console](/commands/jx_console):

```shell
jx console
```

to open it in a browser.

### Pipelines

To view the current pipelines use [jx get pipelines](/commands/jx_get_pipelines):

```shell
jx get pipelines
```

### Pipeline Build logs

To view the current pipeline build logs via [jx get build logs](/commands/jx_get_build_logs):

```shell
jx get build logs
```

You are then presented with all the possible pipelines to watch.

You can quickly filter that via

```shell
jx get build logs -f myapp
```

or if you wish to be explicit

```shell
jx get build logs myorg/myapp/master
```

### Pipeline Activity

To view the current pipeline activity [jx get activities](/commands/jx_get_activities):

```shell
jx get activities
```

If you want to watch whats going on with your app `myapp`  you can use:

```shell
jx get activities -f myapp -w
```

Which will watch the pipeline activities and update the screen whenever a significant change happens (e.g. a release completes, a PR is created to start [promotion](/developing/promote) etc).

### Applications

To view all the applications in your team across all your environments with URLs and pod counts use  [jx get applications](/commands/applications):

```shell
jx get applications
```

If you want to hide the URLs or the pod counts you can use `u` or `-p`. e.g. to hide the URLs:

```shell
jx get app -u
```

Or hide the pod counts:

```shell
jx get app -p
```

You can also filter the apps by an environment:

```shell
jx get app -e staging
```



### Environments

To view the [environments](/about/features/#environments) defined for your team use [jx get environments](/commands/jx_get_environments):

```shell
jx get environments
```

You can also 

* create a new environment via [jx create environment](/commands/jx_create_environment)
* edit an environment via [jx edit environment](/commands/jx_edit_environment)
* delete an environment via [jx delete environment](/commands/jx_delete_environment)
