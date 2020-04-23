---
title: TLS
linktitle: TLS
description: Configuring TLS with Jenkins X 
date: 2019-08-28
weight: 190
---

As documented in the [boot ingress documentation](/docs/getting-started/setup/boot/#ingress), you can configure a global default certificate for all Jenkins X ingresses.
This requires using [DNS01](https://cert-manager.io/docs/configuration/acme/dns01/) for a wildcard certificate, or manually adding and updating your certificate.
In case this is not practicle and you want to generate one certificate per ingress using [http01](https://cert-manager.io/docs/configuration/acme/http01/), you can specify the `secreName`s to be used for each ingress in the `values.yaml` as described below:
```
ingress:
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod

hook:
  ingress:
    tls:
     secretName: tls-hook
nexus:
  ingress:
    tls:
     secretName: tls-nexus
...
```
