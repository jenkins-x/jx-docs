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

在 Mac 上你可以使用 brew：

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
    
### 其他平台
    
[下载二进制包](https://github.com/jenkins-x/jx/releases) `jx` 然后加到环境变量 `$PATH` 中

或者，你可以尝试 [自行构建](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md)。然而，如果你要自行构建的话，请注意移除所有旧版本的 `jx` 二进制文件，这样你的本地构建才会出现在环境变量 `$PATH` 的第一位 :)

## 获得帮助

查找可用的命令类型：

    jx

或者，获取指定命令的帮助，例如： `create` 命令，可以输入：

    jx help create

你也可以浏览 [jx 命令参考文档](/zh/commands/jx)
