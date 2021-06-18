---
title: Ingress
linktitle: Ingress 
type: docs
description: Questions on ingress and load balancing
weight: 390
---

## How do I configure the ingress domain in Dev, Staging or Production?

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/v3/guides/multi-cluster/).

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

If you wish to change any of these values for a single app only then you can use the [app customisation mechanism](/v3/develop/apps/#customising-charts).

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

If you want to override the TLS secret name for a specific app in a specific environment then rather like the [above question](#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production) you can use the [app customisation mechanism](/v3/develop/apps/#customising-charts).
 
e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:
                                                                                                                                        
```yaml 
jxRequirements:
  ingress:
    tls:
      enabled:
      secretName: my-tls-secret-name
```


## How To Add Custom Annotations to Ingress Controller?

There may be times when you need to add your custom annotations to ingress resources.

The simplest way to do this is to modify the `jx-requirements.yml` in your development git repository to add any ingress annotations you wish:


```yaml
apiVersion: core.jenkins-x.io/v4beta1
kind: Requirements
spec:
  ...
  ingress:
    annotations:
      myannotation: somevalue
    domain: my.domain.com
```

Once you have commit and push this change it will [trigger another boot job](/v3/about/how-it-works/#boot-job)

You can watch the boot job run via:

```bash 
jx admin log -w
```

Once its complete you should see the new annotations on any Ingress created by Jenkins X.

If you wish to add custom annotations to only a specific ingress then you can [customise the chart](/v3/develop/apps/#customising-charts) in the usual [helmfile](https://github.com/roboll/helmfile) way via a `values.yaml` file you reference in your `helmfile.yaml` file


## How do I diagnose webhooks?

See [How to diagnose webhooks](/v3/admin/troubleshooting/webhooks/)

## How do I use webhooks without a public IP?

If you are running on your laptop or in a private cluster you won't be able to use webhooks on your git provider to trigger pipelines.

A workaround is to use [use something like ngrok to enable webhooks](/v3/admin/platforms/on-premises/webhooks/)
