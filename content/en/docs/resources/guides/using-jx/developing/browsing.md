---
title: Browsing
linktitle: Browsing
description: Browsing resources in Jenkins X
weight: 10
aliases:
  - /developing/browsing
---


If you have used kubernetes before you're probably used the [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) command line to view kubernetes resources:

```sh
kubectl get pods
```

The Jenkins X command line tool, [jx](/commands/jx/), has a similar look and feel to [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) and lets you get the status of all the Jenkins X resources.

### View Jenkins Console

If you are familiar with the Jenkins console then you can use [jx console](/commands/deprecation/):

```sh
jx console
```

to open it in a browser.

### Pipeline Activity

To view the current pipeline activity [jx get activities](/commands/jx_get_activities/):

```sh
jx get activities
```

If you want to watch whats going on with your app `myapp`  you can use:

```sh
jx get activities -f myapp -w
```

Which will watch the pipeline activities and update the screen whenever a significant change happens (e.g. a release completes, a PR is created to start [promotion](/developing/promote/) etc).

### Pipeline Build logs

To view the current pipeline build logs via [jx get build logs](/commands/jx_get_build_log/):

```sh
jx get build logs
```

You are then presented with all the possible pipelines to watch.

You can quickly filter that via

```sh
jx get build logs -f myapp
```

or if you wish to be explicit

```sh
jx get build logs myorg/myapp/master
```

### Pipelines

To view the current configured pipelines use [jx get pipelines](/commands/jx_get_pipelines/):

```sh
jx get pipelines
```

### Applications

To view all the applications in your team across all your environments with URLs and pod counts use  [jx get applications](/commands/jx_get_applications/):

```sh
jx get applications
```

If you want to hide the URLs or the pod counts you can use `u` or `-p`. e.g. to hide the URLs:

```sh
jx get applications -u
```

Or hide the pod counts:

```sh
jx get applications -p
```

You can also filter the apps by an environment:

```sh
jx get applications -e staging
```



### Environments

To view the [environments](/about/concepts/features/#environments) defined for your team use [jx get environments](/commands/jx_get_environments/):

```sh
jx get environments
```

You can also

* create a new environment via [jx create environment](/commands/jx_create_environment/)
* edit an environment via [jx edit environment](/commands/jx_edit_environment/)
* delete an environment via [jx delete environment](/commands/jx_delete_environment/)
