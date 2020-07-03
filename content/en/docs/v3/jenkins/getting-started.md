---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins and Jenkins X interop
weight: 20
---


Make sure you have got the [jx 3.x binary](/docs/v3/jx3/) before proceeding.


## Adding Jenkins Servers

You can register any Jenkins servers you wish to the Jenkins Server Registry via the `jxl jenkins add` command:

```
jxl jenkins add 
```

If you already know the name, URL, username and API Token then you can use:

```
jxl jenkins add -u https://myjenkins.com/ --username myuser
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
