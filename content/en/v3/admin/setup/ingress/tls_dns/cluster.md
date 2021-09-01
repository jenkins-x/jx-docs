---
title: Cluster
linktitle: Cluster 
type: docs
description: Configuring the cluster 
weight: 250
---

Next we will configure the cluster requirements:

- Install [external-dns](https://github.com/kubernetes-sigs/external-dns#externaldns) - Kubernetes controller which watches for new Kubernetes Ingress resources and creates A records in Google Cloud DNS which will propagate globally across the internet
- Install [cert-manager](https://cert-manager.io/docs/) - Kubernetes controller which watches for requests to ask [Let's Encrypt](https://letsencrypt.org/) to issue a new wildcard TLS certificate for your domain and will manage this including renewals

Cert-manager will use the cluster issuer to request a TLS certificate.  A Kubernetes secret will be automatically created and contain the TLS cert.  The nginx controllers in the `nginx` namespace will use this secret in the `jx` namespace for the default SSL certificate which will automatically enable TLS for all applications in your cluster.

The domain from setting up your infrastructure in step one should appear in the `jx-requirements.yml` of you cluster git repo.  Next configure your TLS options, update your `jx-requirements.yml` with below.

__NOTE__ this is the top level `ingress:` section and __NOT__ in the `environments:` section:

```bash
ingress:
  domain: dev.foo.io
  externalDNS: true
  namespaceSubDomain: -jx.
  tls:
    email: "joe@gmail.com"
    enabled: true
    production: false
```

When first installing set `tls.production=false` so you use the Lets Encrypt staging service which allows for more API calls before rate limiting requests.  They will issue a self-signed certificate so once happy everything is working change this to `tls.production=true`.

__NOTE__ Helmfile is not able to skip insecure TLS when adding helm repositories, therefore staging certificates will not work with chartmuseum that is running in the cluster.  Therefore once you have verified cert-manager can issue certificates from staging, switch to the production service.

Jenkins X uses a version stream to rollout tested versions of images, charts and default configuration.  The `jx-boot` job will apply these versions to your helmfile but you can also run the step yourself to see the defaults.

```bash
jx gitops helmfile resolve
```

```bash
git add helmfile.yaml
git commit -m 'feat: enable DNS and TLS'
git push
```

Now tail the admin logs and wait for the job to complete

```bash
jx admin logs
```
