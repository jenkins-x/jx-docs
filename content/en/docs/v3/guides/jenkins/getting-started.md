---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins and Jenkins X interop
weight: 20
---


Make sure you have got the [jx 3.x binary](/docs/v3/guides/jx3/) and you have installed [version 3](/docs/v3/getting-started/) before proceeding.


## Adding Jenkins Servers into Jenkins X

You can use Jenkins X to install one or more Jenkins servers by adding the following YAML to your `helmfile.yaml` in your cluster git repository you used to install Jenkins X:


```yaml 
releases:
- chart: jenkinsci/jenkins
  name: jenkins
  namespace: jx
```

You can create as many Jenkins servers you wish, give them any release `name` value you wish and put them in whatever namespaces you wish. 

You can also add [customize the charts](/docs/v3/guides/apps/#customising-charts) by adding a `values.yaml` file via the `values:` entry in the helmfile to configure whatever you need (e.g. Jenkins plugins and jobs etc).
