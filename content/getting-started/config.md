---
title: Configuration
linktitle: Configuration
description: Customising your Jenkins X installation
date: 2016-11-01
publishdate: 2016-11-01
lastmod: 2018-01-02
categories: [getting started]
keywords: [install,kubernetes]
menu:
  docs:
    parent: "getting-started"
    weight: 70
weight: 70
sections_weight: 70
draft: false
toc: true
---

Jenkins X should work out of the box with smart defaults for your cloud provider. e.g. Jenkins X automatically uses ECR if you are using AWS or EKS.

However you can configure values in the underlying helm charts used by Jenkins X.

To do this you need to create a `myvalues.yaml` file in the current directory you are in when you run either [jx create cluster](/commands/jx_create_cluster) or [jx install](/commands/jx_install)

Then this YAML file can be used to override any of the underlying `values.yaml` in any of the charts in Jenkins X.

e.g. if you wish to disable Nexus being installed and instead service link to a separate nexus at a different host name you can use this `myvalues.yaml`:

```yaml
nexus:
  enabled: false
nexusServiceLink:
  enabled: true
  externalName: "nexus.jx.svc.cluster.local"
```

To disable and service link chart museum add:

```yaml
chartmuseum:
  enabled: false
chartmuseumServiceLink:
  enabled: true
  externalName: "jenkins-x-chartmuseum.jx.svc.cluster.local"
```


## Docker Registry

We try and use the best defaults for each platform for the Docker Registry; e.g. using ECR on AWS or KES. 

However you can also specify this via the `--docker-registry` option when running  [jx create cluster](/commands/jx_create_cluster) or [jx install](/commands/jx_install)

e.g.

``` 
jx create cluster gke --docker-registry eu.gcr.io
```   

Though if you use a different Docker Registry you will probably need to [also modify the secret for connecting to docker](/architecture/docker-registry/#update-the-config-json-secret).
