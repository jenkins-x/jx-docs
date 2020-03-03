---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins and Jenkins X interop
weight: 20
---

Make sure you have got the [jxl binary](/docs/labs/jxl/) before proceeding.


## Adding Jenkins Servers

`trigger-pipeline` can automatically discover Jenkins servers created via the [Jenkins Operator](https://jenkinsci.github.io/kubernetes-operator/).

In addition you can register any Jenkins servers you wish to the Jenkins Server Registry via the `tp add` command.

To add a new Jenkins server with a guided wizard:

```
jxl jenkins add 
```

If you already know the name, URL, username and API Token then you can use:

```
jxl jenkins add 
```

### Removing Jenkins Servers

You can remove a Jenkins server via:

``` 
jxl jenkins remove
```

Note that this only removes it from the registry; it doesn't affect the actual Jenkins Server.

## Listing the available Jenkins Servers

To list the servers you can use try:

``` 
jxl jenkins list
```
