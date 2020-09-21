---
title: FAQ
linktitle: FAQ
description: Questions on using helm 3 and boot
weight: 500
aliases:
  - /faq/
---



## How do I list the apps that have been deployed?

You can use helm 3.x directly to list all the apps (charts) deployed in a namespace:

``` 
helm list
```                                                                                

To look in another namespace add it as an argument:

``` 
helm list -n nginx
```                                                                                


## How do I customise an App in an Environment

With the new helm 3 based boot every environment uses boot - so there is a single way to configure anything whether its in the `dev`, `staging` or `production` environment and whether or not you are using [multiple clusters](/docs/v3/guides/multi-cluster/).

See [how to customise a chart](/docs/v3/guides/apps/#customising-charts)

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

If you wish to change any of these values for a single app only then you can use the [app customisation mechanism](/docs/v3/guides/apps/#customising-charts).

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

If you want to override the TLS secret name for a specific app in a specific environment then rather like the [above question](#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production) you can use the [app customisation mechanism](/docs/v3/guides/apps/#customising-charts).
 
e.g. for an app called `mychart` you can create a file called `apps/mychart/values.yaml` in the git repository for your environment and add the following YAML:
                                                                                                                                        
```yaml 
jxRequirements:
  ingress:
    tls:
      enabled:
      secretName: my-tls-secret-name
```


## How do I uninstall boot?

From inside a git clone of your `dev`, `staging` or `production` environment's git repository you can run: 

```
jx step create helmfile 
helmfile destroy
```

