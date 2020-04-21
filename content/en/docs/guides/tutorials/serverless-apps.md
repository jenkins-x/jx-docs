---
title: Serverless Apps
linktitle: Serverless Apps
description: Develop serverless applications with Knative
weight: 40
---

Serverless applications are regular applications that "scale to zero". This means when your application isn't in use - no resources at all will be used. You only pay for what you use. These applications scale up elastically to meet the workload.

Once you have this feature enabled - all new apps you import or quickstarts you use by default will be serverless style (you can override as needed - see below). You don't have to change the way you build web apps. This is currently in a preview state (but works well), and in future most web apps will work in this fashion (and this will be the default).

## Enabling serverless apps

```sh
jx create addon gloo
```

And you are then good to go. Any new projects you create will be created in this serverless style.


## Converting existing applications

If you already have a microservice and you want to convert it over to Knative Serve just [import the source repository into Jenkins X](/docs/guides/using-jx/creating/import/) and you should be all done.

If your application was imported recently into Jenkins X but before you installed and enabled Knative Serve you can use [jx edit deploy](/commands/deprecation/) to switch between the `default` deployment kind (using kubernetes `Deployment` and `Service` resources) and the `knative` kind (using Knative `Service` resource)

```sh
jx edit deploy
```

This command will modify the `knativeDeploy` flag in your helm `charts/myapp/values.yaml` file to enable / disable Knative Serve. Once you have committed that code change and merged to master your application will be released to staging using Knative Serve by the automated CI/CD pipeline in Jenkins X.


## Edit your team’s deploy kind

You can edit the default deployment kind for your team which is used when’re you create a QuickStart or import a repository via the [jx edit deploy](/commands/deprecation/) command with the `-t` argument:

```sh
jx edit deploy -t
```


### How it works

We use an open source project called [Knative](https://www.knative.dev/) to provide the elastic scaling of your applications and functions.

[Knative Serve](https://www.knative.dev/) exposes functions in any programming language over HTTP with elastic scaling from zero to many pods. This lets you build serverless applications which run on any cloud or kubernetes cluster and make an efficient use of resources.

[Knative](https://www.knative.dev/) works with service mesh technologies like [Istio](https://istio.io/) or [Gloo](https://gloo.solo.io/).

The Jenkins X builld packs create a Knative Serve resource in your helm chart at `charts/myapp/templates/ksvc.yaml`. This resource is only created if the `knativeDeploy` flag is true / otherwise the default kubernetes `Service` & `Deployment` are created.



## Installing Knative Serve

[Gloo](https://gloo.solo.io/) is much smaller and simpler to install than [Istio](https://istio.io/) so in this guide we are going to use that.

We have a simple command [jx create addon gloo](/commands/jx_create_addon_gloo/) to install Gloo and Knative Serve on Jenkins X:

```sh
jx create addon gloo
```
This command will install Knative Serve into the `knative-serving` namespace and Gloo into the `gloo-system` namespace. You can check it’s all installed and working via:

```sh
kubectl get pod -n knative-serving
kubectl get pod -n gloo-system
```

Or you can follow the [Knative install guide](https://www.knative.dev/docs/install/) to install it directly via istio or gloo.

## Using Knative Serve

Now you have installed [Knative Serve](https://www.knative.dev/) snd [Gloo](https://gloo.solo.io/) you can [create a new quicktart](/docs/getting-started/first-project/create-quickstart/) or [create a new spring boot application](/docs/resources/demos-talks-posts/create_spring/) and it will default to using Knative Serve to elastically scale your microservice based on its load over HTTP.

You can check if Knative Serve is being used on your application by doing:

```sh
kubectl get ksvc -n jx-staging
```
Which should show all of the Knative Service resources in your Staging environment.



## Demo

Here is a [demo of using Knative Serve snd Gloo](https://youtu.be/eYIaz_plUOw?t=1980) from the [April 4th, 2019](/community/april-4/) [Office Hours](/community/):

<iframe width="565" height="480" src="https://www.youtube.com/embed/eYIaz_plUOw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
