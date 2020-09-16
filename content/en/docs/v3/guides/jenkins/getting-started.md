---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins and Jenkins X interop
weight: 20
---


Make sure you have got the [jx 3.x binary](/docs/v3/guides/jx3/) before proceeding.


## Adding Jenkins Servers into Jenkins X

You can use Jenkins X to install one or more Jenkins servers by adding the following YAML to your `helmfile.yaml`

```yaml 
releases:
- chart: jenkinsci/jenkins
  name: jenkins
  namespace: jx
```

You can create as many Jenkins servers you wish, give them any release `name` value you wish and put them in whatever namespaces you wish. 

You can also add [customize the charts](/docs/v3/guides/apps/#customising-charts) by adding a `values.yaml` file via the `values:` entry in the helmfile to configure whatever you need (e.g. Jenkins plugins and jobs etc).

## Registering external Jenkins Servers

You can register any Jenkins servers you wish to the Jenkins Server Registry via the `jx jenkins add` command:

```
jx jenkins add 
```

If you already know the name, URL, username and API Token then you can use:

```
jx jenkins add -u https://myjenkins.com/ --username myuser
```

### Removing Jenkins Servers

You can remove a Jenkins server via:

``` 
jx jenkins remove
```

Note that this only removes it from the registry; it doesn't affect the actual Jenkins Server.

## Listing the available Jenkins Servers

To list the servers you can use try:

``` 
jx jenkins list
```
