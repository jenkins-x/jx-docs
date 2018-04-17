---
title: 获取 jx
linktitle: 获取 jx
description: 如何在你的机器上安装jx二进制包
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
menu:
  docs:
    parent: "getting-started"
    weight: 10
weight: 10
sections_weight: 10
draft: false
aliases: [/overview/usage/,/extras/livereload/,/doc/usage/,/usage/]
toc: true
---

根据你的操作系统选择最适合的指令：

### macOs

On a Mac you can use brew:

```shell
brew tap jenkins-x/jx
brew install jx 
```

Or if you have not installed [brew](https://brew.sh/) and prefer to install by hand:

```shell
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-darwin-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
```

### Linux

```shell
curl -L https://github.com/jenkins-x/jx/releases/download/v{{< version >}}/jx-linux-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
```
    
### Other platforms
    
[download the binary](https://github.com/jenkins-x/jx/releases) for `jx` and add it to your `$PATH`

Or you can try [build it yourself](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md). Though if build it yourself please be careful to remove any older `jx` binary so your local build is found first on the `$PATH` :)

## Getting Help

To find out the available commands type:

    jx

Or to get help on a specific command, say, `create` then type:

    jx help create

You can also browse the [jx command reference documentation](/commands/jx)
