---
title: TLS and DNS
linktitle: TLS and DNS
type: docs
description: Automated TLS and DNS
weight: 92
aliases:
  - /docs/v3/guides/infra/tls_dns
---

This section will describe how to enable automated TLS and DNS for your Jenkins X installation.

To achieve this we will use a couple of open source projects to help enable automated DNS for your applications.

For this guide we are going to assume you own a domain called `foo.io` which is managed by Google Cloud DNS, if it is not see [configure cloud dns to manage a domain](/docs/v3/guides/infra/google_cloud_dns).  


A common requirement for domains is to have production services accessed using a parent / [apex domain](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/about-custom-domains-and-github-pages#using-an-apex-domain-for-your-github-pages-site)
for example:

https://foo.com

Many organisations have extra requirements for development and test multi cluster environments to access services at

https://dev.foo.com
and
https://staging.foo.com

These use subdomains.

In this guide below there is a prerequisite that you must already have a domain which is managed by GCP, this is so that you can choose whichever of the scenarios above you need.  It also means the dns management of the apex domain happens outside of a single cluster installation and can be shared by multiple installations using a subdomain.

Jenkins X services will have URLs like `https://hook-jx.dev.foo.io`.  The jx-requirements.yml `namespaceSubDomain:` of `-jx` which is in the cluster git repository refers to the Kubernetes namespace the service is running in, this avoids clashes of the same application running in different namespaces in the same cluster.

To start with we are focussed on GCP but will expand to other cloud providers.

# Google Cloud Platform

## Prerequisites

- cluster created using Jenkins X [GCP Terraform getting started](/docs/v3/getting-started/gke/)
- own a domain and have GCP manage it, [configure cloud dns to manage a domain](/docs/v3/guides/infra/google_cloud_dns)
- latest Jenkins X CLI, Infrastructure and Cluster git repository updates [upgrade](/docs/v3/guides/upgrade)

### Cloud Infrastructure
First we will configure the cloud infrastructure requirements:

- a GCP Service Account with the `dns.admin` role, see [here](https://cloud.google.com/iam/docs/understanding-roles#dns-roles) for more information
- a managed cloud dns zone, see [here](https://cloud.google.com/dns/docs/zones) for more information

To satisfy these requirements go to your infrastructure repository (contains Terraform main.tf) and add to your `values.auto.tfvars` the following:

```yaml
parent_domain = "foo.io"
```

Most people prefer to use a subdomain for a specific installation rather than purchasing one domain per cluster.  For example in a multi cluster setup you will probably want all using the same parent domain but two clusters using a different subdomain like development.foo.io, staging.foo.io leaving production using just the parent domain foo.io.

To use a subdomain for this cluster add the following configuration:

```yaml
subdomain     = "dev"
```

Now apply these changes:

```bash
git add values.auto.tfvars
git commit -m 'feat: enable DNS cloud resources'
git push
```
You may want to set two environment variables here so that Terraform does not prompt for values
```
export TF_VAR_jx_bot_username=
export TF_VAR_jx_bot_token=
```
now run
```bash
terraform plan
terraform apply
```

If using a subdomain you will now see your managed zone in GCP [here](https://console.cloud.google.com/net-services/dns/zones)

### Cluster

Next we will configure the cluster requirements:

- Install [external-dns](https://github.com/kubernetes-sigs/external-dns#externaldns) - Kubernetes controller which watches for new Kubernetes Ingress resources and creates A records in Google Cloud DNS which will propagate globally across the internet
- Install [cert-manager](https://cert-manager.io/docs/) - Kubernetes controller which watches for requests to ask [Let's Encrypt](https://letsencrypt.org/) to issue a new wildcard TLS certificate for your domain and will manage this including renewals

To satisfy these requirements go to your cluster repository (contains helmfile.yaml)

Add external-dns to your clusters helmfile.yaml `releases` section:

```bash
- chart: bitnami/external-dns
```

Add cert-manager to your clusters helmfile.yaml `releases` section:
```bash
- chart: jetstack/cert-manager
```

Next we install
- a cluster wide [Issuer](https://cert-manager.io/docs/concepts/issuer/) which tells cert-manager how to validate you own your domain
- a namespaced [Certificate](https://cert-manager.io/docs/concepts/certificate/) to request a TLS certificate for applications running in your cluster

```bash
- chart: jx3/acme
  name: acme-jx
```

Cert-manager will use the cluster issuer to request a TLS certificate.  A Kubernetes secret will be automatically created and contain the TLS cert.  Ingresses for applications in any namespace will reference this secret in the `jx` namespace.

The domain from setting up your infrastructure in step one should appear in the `jx-requirements.yml` of you cluster git repo.  Next configure your TLS options, update your `jx-requirements.yml` with below.

__NOTE__ this is the top level `ingress:` section and __NOT__ in the `environments:` section:

```bash
ingress:
  domain: dev.foo.io
  externalDNS: false # this is unused and will be deprecated
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

It can take a short while for DNS to propagate so you may need to wait for 5 - 10 minutes.  https://dnschecker.org/ is a useful way to check the status of DNS propagating.

You should be able to verify the TLS certificate from Lets Encrypt in your browser (beware of browser caching if you don't see any changes)

![Working TLS](/images/v3/working_tls.png)

## How do I enable TLS on non Jenkins X quickstarts?

If you are creating your own Ingress resources and not using Jenkins X quickstarts then add this:

First take note of your TLS secret name in the `jx` namespace
```bash
kc get secret -n jx | grep tls

```

Now add the reference including the `jx/` prefix to your ingress
```bash
spec:
  rules:
  - host: [your hostname]
    http:
      paths:
      - backend:
          serviceName: [your kubernetes service name]
          servicePort: [your kubernetes service port]
  tls:
  - hosts:
    - [your hostname]
    secretName: jx/[your TLS secret name from step above]
```

## What if I have a chartmuseum with charts running using nip.io?

It is best to comment out your Jenkins X chartmuseum repository and charts from your helmfile until your new domain and ingress is working.  Then uncomment and make sure you update the chartmuseum URL to your new one.

## What if I use a subdomain with an apex domain in a different GCP project?

When using a subdomain Terraform will create a managed zone in GCP, add the recordsets to your parent / apex domain.

If the GCP managed zone for your apex domain is in a different GCP project than the project that your current installation the you will need to set in your infrastructure repository the terraform variable:

```
parent_domain_gcp_project: [your GCP project that is managing your apex domain]
```

If you do not have permission to update the recordset of the apex domain then you will need to manually update it after getting the nameservers created for your subdomain managed zone and disable the automatic way using:

```
apex_domain_integration_enabled: false
```

## How can I remove the namespace subdomain (e.g. -jx.) from my URLs?

In your cluster git repository find the `namespaceSubdomain` property in your jx-requirements.yml file and change its value to `namespaceSubdomain: "."`

Be aware that the same application deployed in multiple namespaces will end up with the same URL if you change `namespaceSubdomain` to be the same for all environments.

## How can I check if cert-manager has issued a certificate?

You can check the status of the certificate by running

```
kubectl get cert -n jx
```
```
kubectl describe cert -n jx
```
if `Ready` continues to be `false` after 10-15 mins you can check on the request using
```
kubectl get certificaterequest -n jx
```
```
kubectl describe certificaterequest -n jx
```
