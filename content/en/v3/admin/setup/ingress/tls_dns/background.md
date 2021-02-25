---
title: Background
linktitle: Background 
type: docs
description: Background onTLS and DNS
weight: 30
---
          

To achieve this we will use a couple of open source projects to help enable automated DNS for your applications.

For this guide we are going to assume you own a domain called `foo.io` which is managed by Google Cloud DNS, if it is not see [configure cloud dns to manage a domain](/v3/guides/infra/google_cloud_dns). A similar procedure is described for an external registrar, see the Azure section.


A common requirement for domains is to have production services accessed using a parent / [apex domain](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/about-custom-domains-and-github-pages#using-an-apex-domain-for-your-github-pages-site)
for example:

https://foo.com

Many organisations have extra requirements for development and test multi cluster environments to access services at

https://dev.foo.com
and
https://staging.foo.com

These use subdomains.

In this guide below there is a prerequisite that you must already have a domain which is managed by your cloud provider, this is so that you can choose whichever of the scenarios above you need.  It also means the dns management of the apex domain happens outside of a single cluster installation and can be shared by multiple installations using a subdomain.

Jenkins X services will have URLs like `https://hook-jx.dev.foo.io`.  The jx-requirements.yml `namespaceSubDomain:` of `-jx` which is in the cluster git repository refers to the Kubernetes namespace the service is running in, this avoids clashes of the same application running in different namespaces in the same cluster.

To start with we are focussed on GCP and Azure but will expand to other cloud providers.

