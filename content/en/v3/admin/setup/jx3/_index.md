---
title: Install the CLI
linktitle: Install the CLI
type: docs
description: How to install the jx 3.x CLI
weight: 1
aliases:
  - /v3/guides/jx3
  - /v3/admin/guides/jx3
---

To try out the 3.x Beta of Jenkins X you will need the 3.x version of the `jx` binary.

You can download 3.x of `jx` from here: https://github.com/jenkins-x/jx/releases

### Linux

```shell
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-linux-amd64.tar.gz | tar xzv
chmod +x jx 
sudo mv jx /usr/local/bin
```

### macOS

```shell
curl -L  https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-darwin-amd64.tar.gz | tar xzv
chmod +x jx 
sudo mv jx /usr/local/bin
```

### Windows

* click on the [download link](https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-windows-amd64.zip) to download a binary
* copy the `jx` binary to a directory on your `$PATH`
   
      
## Verify your install

Once you have installed the `jx` binary so it is on your `$PATH` you should be able to run 

```shell 
jx version 
```

or 

```shell 
jx --help 
```

For more detail see the [Command Line Reference Guide](/v3/develop/reference/jx/) 
