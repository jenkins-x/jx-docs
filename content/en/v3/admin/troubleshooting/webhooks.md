---
title: Webhooks
linktitle: Webhooks
type: docs
description: How to diagnose and fix webhooks
weight: 200
---

Webhooks are used to trigger [lighthouse](https://github.com/jenkins-x/lighthouse) when you:

* merge commits to your main branch 
* open a Pull Request
* push code to a Pull Request branch
* comment on a Pull Request to trigger ChatOps

If webhooks are not working in your cluster then you won't get ChatOps or pipelines triggered.

### Requirements

For webhooks to work you must have a working `Ingress` for the `hook` endpoint from [lighthouse](https://github.com/jenkins-x/lighthouse)

The ingress defaults to using the domain name specified in `ingress.domain` in your `jx-requirements.yml` file.


### Diagnosing issues
        
You can check on the health of your system and webhooks via the [Health guide](/v3/admin/setup/health/)

First make sure you have a valid ingress for hook...

```bash 
# switch to the jx namespace
jx ns jx

kubectl get ing
```

you should see an ingress with a valid domain name for `hook`. Then try curl that URL on the command line...

```bash
curl -v http://hook-jx.1.2.3.4.nip.io/hook
```

and check your laptop can access the endpoint. Do you have a running `lighthouse-webhook-*` pod?

```bash
kubectl get pod -l app=lighthouse-webhooks
```

You could look at your pods in `jx ui` to see their state, events, logs etc.

If everything looks to be working inside your cluster then open the git repository of your dev cluster...

```bash
kubectl get environments
```

Then click the `GIT URL` link for your repository.

Now look at the **Webbooks** page to see if your git provider could send webhooks to your hook endpoint. On GitHub thats **Settings** ->  **Webhooks**

It could be your git provider can't see public ingress endpoint? If thats the case you may need to look at setting up a tunnel via something like [ngrok to enable on-premises webhooks](/v3/admin/platforms/on-premises/#enable-webhooks) 

### AWS specific issues

If you are using AWS you can check out the [AWS docs on using ELB](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-elb-load-balancer.html)
