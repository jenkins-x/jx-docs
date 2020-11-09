---
title: TLS and DNS
linktitle: TLS and DNS
description: Automated TLS and DNS
weight: 35
---

This section will describe how to enable automated TLS and DNS for your Jenkins X installation.

To achive this we will use a couple of open source projects to help enable automated DNS for applications you 

For this guide we are going to assume you own a domain called `foo.io` which is managed by Google Cloud DNS, if it is not see [configure cloud dns to manage a domain](/docs/v3/guides/infra/google_cloud_dns).  

Jenkins X services will have URLs like `https://hook-jx.bar.foo.io`.  The jx-requirement.yaml `namespaceSubDomain:` of `-jx` refers to the Kubernetes namespace the service is running in, this helps avoid clashes of the same application running in different namespaces in the same cluster.

To start with we are focussed on GCP but will expand to other cloud providers.

# Google Cloud Platform

## Prerequisits

- cluster created using Jenkins X [GCP Terraform getting started](/docs/v3/getting-started/gke/)
- own a domain, we will use [Google Domains](https://domains.google.com/registrar/) in this guide but any provider will work
- latest Jenkins X [upgrade](/docs/v3/guides/upgrade)

### Cloud Infrastructure
First we will configure the cloud infrastructure requirements:

- a GCP Service Account with the `dns.admin` role, see [here](https://cloud.google.com/iam/docs/understanding-roles#dns-roles) for more information
- a managed cloud dns zone, see [here](https://cloud.google.com/dns/docs/zones) for more information

To satisfy these requirements go to your infrastructure repository (contains Terraform main.tf) and add to your `values.auto.tfvars` the following:

```values.tf
parent_domain = "foo.io"
```

Most people prefer to use a subdomain for a specific installation rather than purchasing one domain per cluster.  For example in a multi cluster setup you will probably want the same parent domain but each cluster using a differnt subdomain like development.foo.io, staging.foo.io and foo.io.

To use a subdomain for this cluster add the following configuration:

```values.tf
subdomain     = "bar"
```

Now apply these changes:

```
git add values.auto.tfvars
git commit -m 'feat: enable DNS cloud resources'
git push
```

```
terraform plan
terraform apply
```

You can now see your managed zone in GCP [here](https://console.cloud.google.com/net-services/dns/zones)


### Cluster

Next we will configure the cluster requirements:

- Install [external-dns](https://github.com/kubernetes-sigs/external-dns#externaldns) - Kubernetes controller which watches for new Kubernetes Ingress resources and creates A records in Google Cloud DNS which will propogate globally across the internet
- Install [cert-manager](https://cert-manager.io/docs/) - Kuberbetes controller which watches for requests to ask [Let's Encrypt](https://letsencrypt.org/) to issue a new wildcard TLS certificate for your domain and will manage this including renewals

To satisfy these requirements go to your cluster repository (contains helmfile.yaml)

Add external-dns to your clusters helmfile.yaml `releases` section:

```
- chart: bitnami/external-dns
```

Add cert-manager to your clusters helmfile.yaml `releases` section:
```
- chart: jetstack/cert-manager
```

Next we install
- a cluster wide [Issuer](https://cert-manager.io/docs/concepts/issuer/) which tells cert-manager how to validate you own your domain
- a namespaced [Certificate](https://cert-manager.io/docs/concepts/certificate/) to request a TLS certificate for services running in the `jx` namespace

```
- chart: jx3/acme
  name: tls-jx
  values:
  - issuer:
      enabled: true
      cluster: true
```

Cert-manager will use the cluster issuer to request a TLS certificate for each namespaces [Certificate](https://cert-manager.io/docs/concepts/certificate/) found.  The advantage here is that the same wildcard certificate is cached and reused for multiple namespaces reducing the risk of being [rate limited](https://letsencrypt.org/docs/rate-limits/) by Lets Encrypt.

Now install the `acme` chart into any namespace you require TLS, e.g.
```
- chart: jx3/acme
  name: tls-jx-staging
  namespace: jx-staging
- chart: jx3/acme
  name: tls-jx-production
  namespace: jx-production
```

The domain from setting up your infrastructure in step one should appear in the `jx-requirements.yaml` of you cluster git repo.  Next configure your TLS options, update your `jx-requirements.yaml` with
```
ingress:
  domain: bar.foo.io
  externalDNS: false # this is unused and will be deprecated
  namespaceSubDomain: -jx.
  tls:
    email: "joe@gmail.com"
    enabled: true
    production: false
```

When first installing set `tls.production=false` so you use the Lets Encrtpt staging serivce which allows for more API calls before rate limniting requests.  They will issue a self-signed certificate so once happy everything is working change this to `tls.production=true`

Jenkins X uses a version stream to rollout tested versions of images, charts and default configuration.  The `jx-boot` job will apply these versions to your helmfile but you can also run the step yourself to see the defaults.

```
jx gitops helmfile resolve
```

```
git add values.auto.tfvars
git commit -m 'feat: enable DNS cloud resources'
git push
```

Now tail the admin logs and wait for the job to complete
```
jx admin logs
```

## How to get TLS in my preview environment?

In your applications preview helm chart you can add a Kubernetes [Certificate](https://cert-manager.io/docs/concepts/certificate/) the same as in your `jx` namespace and cert-manager will create the secret needed by an Ingress rule for TLS.