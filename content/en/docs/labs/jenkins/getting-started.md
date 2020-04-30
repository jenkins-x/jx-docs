---
title: Getting Started 
linktitle: Getting Started
description: Getting started with Jenkins and Jenkins X interop
weight: 20
---
{{% alert %}}
**NOTE: This current experiment is now closed. The work done and feedback we have received will be used to enhance Jenkins X in future versions**

**This code should not be used in production, or be adopted for usage.  It should only be used to provide feedback to the Labs team.**

Thank you for your participation,

-Labs


{{% /alert %}}

Make sure you have got the [jxl binary](/docs/labs/jxl/) before proceeding.


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
