---
title: On Premise
linktitle: On Premise
description: Using Boot On Premise
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
weight: 200
---

On premise kubernetes clusters tend to differ wildly so its hard for us to know your Jenkins X installation will totally work on any cluster given we typically rely on things like persistence, ingress, storage.

Here are some recommendations to hopefully get you started. If you hit any issues please [join our community](/community/) we can hopefully help you.

## Configuration

Please set your provider to `kubernetes` via this in your `jx-requirements.yml`:

```yaml    
clusterConfig:
    provider: kubernetes
```

### Ingress

If you don't have a real ingress solution for your on premise cluster you can start off using the `nginx-controller` and the IP address of your api server.

You can set `ingress.domain` to be `1.2.3.4.nip.io` where `1.2.3.4` is the IP address of your ingress service.

By default boot will try to recreate the `ingress.domain` by discovering the IP address on the nginx controller service - which is commonly generated dynamically on the public clouds.

If you are on premise and using a hard coded IP address for ingress you may want to set this on your `jx-requirements.yml`

```yaml    
clusterConfig:
    provider: kubernetes
ingress:
  domain: 1.2.3.4.nip.io
  ignoreLoadBalancer: true
```

## General advice

We recommend starting with the most simple possible installation and get that working, then gradually try to be more complex. e.g. start off by ignoring these features:

* vault
* DNS
* TLS / certificates
* cloud storage for artifacts

Then once you have something working, incrementally try enabling each of those in turn. 

If a helm step fails some resources may have already been created, running the step again will result in a conflict (resource already exists). To delete all created resource:
- configure jx to keep the tmp folder with compiled helm files:
```
export JX_NO_DELETE_TMP_DIR=true
```
- go to the tmp folder visible in the logs and execute:
```
helm template jenkins-x . --namespace jx | kubectl delete -f -
```
