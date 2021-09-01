---
title: Default domain
linktitle: Default domain
type: docs
description: Default generated domain
weight: 100
---

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

Incidentally when you use a public cloud and create a [kubernetes service of type LoadBalancer](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/) it is automatically associated with a public IP.

Note that if you are [on-premises](/v3/admin/platforms/on-premises/) then the `LoadBalancer` service probably won't automatically get resolved to an external IP. So you will probably need to setup a load balancer like [MetalLB](https://metallb.universe.tf/)
