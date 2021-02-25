---
title: Ingress
linktitle: Ingress
type: docs
description: Changing your ingress
weight: 120
---

Jenkins X requires ingress so that webhooks from your git provider can trigger pipelines and so that you can use tools like the [Dashboard](/v3/develop/ui/dashboard/)
                                    
The ingress domain is defined in `ingress.domain` in the [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file in your development git repository

## Default domain

If you use the default configuration your `ingress.domain` will be empty. When you first install Jenkins X it will discover the `LoadBalancer` `Service` from `nginx` in the `nginx` namespace and resolve that to an external IP address. Then it will use that IP address as a domain with `.nip.io` as the suffix.

So you will see your [jx-requirements.yml](https://github.com/jenkins-x/jx-api/blob/master/docs/config.md#requirements) file looking something like:

```yaml
ingress:
  domain: 1.2.3.4.nip.io
  externalDNS: false
  tls:
    email: ""
    enabled: false
    production: false
```

where `1.2.3.4` is your external IP address of your nginx `LoadBalancer` service.

Incidentally when you use a public cloud and create a [kubernetes service of type LoadBalancer]() it is automatically associated with a public IP.

## Setting up TLS and DNS

A common requirement is to use TLS with a custom DNS name.

see [Setting up TLS and DLS](/v3/admin/guides/tls_dns/)