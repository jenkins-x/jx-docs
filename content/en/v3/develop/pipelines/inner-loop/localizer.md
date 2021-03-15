---
title: localizer
linktitle: localizer
type: docs
description: Using localizer with Jenkins X
weight: 400
---

[localizer](https://github.com/jaredallard/localizer) is a lightweight go lang based rewrite of [telepresencse](https://www.telepresence.io/). See [the blog for more detail](https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/) 

It basically lets you run local processes on your laptop right inside your IDE which are then connected into the kubernetes cluster via networking magic.

### Using localizer 

*  [install localizer](https://github.com/jaredallard/localizer#install-localizer)

* run localizer:

```bash 
sudo localizer
```

* run/debug your application locally.


* then to expose your service into a namespace as a service name run something like this::


```bash 
localizer expose $namespace/$svc --map 80:8080
```

when you have finished debugging, return things to normal via:

```bash 
localizer expose $namespace/$svc --stop
```


### Example

[Here is an example](https://github.com/jenkins-x/lighthouse#debugging-webhooks) of how we use [localizer](https://github.com/jaredallard/localizer) to debug webhooks coming into lighthouse. 

Basically we have webhooks setup on git repositories that when they are modified or Pull Requests are created the git provider triggers the [lighthouse](https://github.com/jenkins-x/lighthouse) webhook endpoint.

[localizer](https://github.com/jaredallard/localizer) maps the kubernetes service endpoint which is triggered by the webhook to invoke the process on your laptop.
