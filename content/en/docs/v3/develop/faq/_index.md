---
title: FAQ
linktitle: FAQ
description: Questions on using Jenkins X 3.x and helm 3
weight: 500
aliases:
  - /faq/
  - /docs/v3/guides/faq/
---



## How do I list the apps that have been deployed?

You can see the helm charts that are installed along witht their version and namespaces by looking at the `releases` section of your `helmfile.yaml` file in your cluster git repository.

You can view all of the current [Preview Environments](/docs/build-test-preview/preview/) via

```bash 
kubectl get preview
```

There could be some additional charts installed via Terraform for the [git operator](/docs/v3/guides/operator/) and [health subsystem](/docs/v3/guides/health/) which can be viewed via:
  
```bash 
helm list --all-namespaces
```                                                                                

## How do I customise an App in an Environment

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/docs/v3/guides/multi-cluster/).

See [how to customise a chart](/docs/v3/develop/apps/#customising-charts)

## How do I configure the ingress domain in Dev, Staging or Production?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/docs/v3/guides/multi-cluster/).

You can override the domain name for use in all apps within an environment by modifying the `jx-requirements.yml` in the git repository for the `dev`, `staging` or `production` environment.

```yaml 
ingress:
  domain: mydomain.com 
```

Also by default there is a namespace specific separator added. So if your service is `cheese` the full domain name would be something like `cheese.jx-staging.mydomain.com`.

If you wish to avoid the namespace specific separator if each environment already has its own unique `domain` value then you can specify:

```yaml 
ingress:
  domain: mydomain.com  
  namespaceSubDomain: "."
```

If you wish to change any of these values for a single app only then you can use the [app customisation mechanism](/docs/v3/develop/apps/#customising-charts).

e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:

```yaml 
jxRequirements:
  ingress:
    domain: mydomain.com  
    namespaceSubDomain: "."
```

## How do I configure the ingress TLS certificate in Dev, Staging or Production?

You can specify the TLS certificate to use for the `dev`, `staging` or `production` environment by modifying the `jx-requirements.yml` file in the environments git repository:


```yaml 
ingress: 
  tls:
    enabled:
    secretName: my-tls-secret-name
```

This will then be applied to all the Jenkins X ingress resources for things like `lighthouse` or `nexus` - plus any apps you deploy to `dev`, `staging` or `production`.

If you want to override the TLS secret name for a specific app in a specific environment then rather like the [above question](#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production) you can use the [app customisation mechanism](/docs/v3/develop/apps/#customising-charts).
 
e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:
                                                                                                                                        
```yaml 
jxRequirements:
  ingress:
    tls:
      enabled:
      secretName: my-tls-secret-name
```


## How do I uninstall Jenkins X?

We don't yet have a nice uninstall command


## Why does Jenkins X fail to download plugins?

When I run a `jx` command I get an error like...

``` Get https://github.com/jenkins-x/jx-..../releases/download/v..../jx-.....tar.gz: dial tcp: i/o timeout```

This sounds like a network problem; the code in `jx` is trying to download from `github.com` and your laptop is having trouble resolving the `github.com` domain.

* do you have a firewall / VPN / HTTP proxy blocking things?
* is your `/etc/resolv.conf` causing issues? e.g. if you have multiple entries for your company VPN?


