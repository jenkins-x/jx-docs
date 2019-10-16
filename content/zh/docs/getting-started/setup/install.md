---
title: 获取 jx
linktitle: 获取 jx
description: 如何在你的机器上安装jx二进制包
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
---

根据你的操作系统选择最适合的指令：

### macOS

在 Mac 上你可以使用 [brew](https://brew.sh/)：

```sh
brew tap jenkins-x/jx
brew install jx
```

或者，如果您尚未安装 [brew](https://brew.sh/) ，并且喜欢手动安装的话，请执行如下指令安装:

```sh
curl -L https://github.com/jenkins-x/jx/releases/download/v{{.Site.Params.release}}/jx-darwin-amd64.tar.gz | tar xzv
sudo mv jx /usr/local/bin
```

### Linux

```sh
mkdir -p ~/.jx/bin
curl -L https://github.com/jenkins-x/jx/releases/download/v{{.Site.Params.release}}/jx-linux-amd64.tar.gz | tar xzv -C ~/.jx/bin
export PATH=$PATH:~/.jx/bin
echo 'export PATH=$PATH:~/.jx/bin' >> ~/.bashrc
```

### Windows

- 如果你使用 [Chocolatey](https://chocolatey.org/)，那么这里有一个 [可用的包](https://chocolatey.org/packages/jenkins-x)。

  要安装 `jx` 二进制请运行：

```sh
choco install jenkins-x
```

  要升级 `jx` 二进制请运行：

```sh
choco upgrade jenkins-x
```

- 如果你使用 [scoop](https://scoop.sh)，那么这里有一个 [可用的清单](https://github.com/lukesampson/scoop/blob/master/bucket/jx.json)。

  要安装 `jx` 二进制请运行：

```sh
scoop install jx
```

  要升级 `jx` 二进制请运行：

```sh
scoop update jx
```

### 其他平台

[下载二进制包](https://github.com/jenkins-x/jx/releases) `jx` 然后加到环境变量 `$PATH` 中

或者，你可以尝试 [自行构建](https://github.com/jenkins-x/jx/blob/master/docs/contributing/hacking.md)。然而，如果你要自行构建的话，请注意移除所有旧版本的 `jx` 二进制文件，这样你的本地构建才会出现在环境变量 `$PATH` 的第一位 :)

## 获得帮助

查找可用的命令类型：

```sh
jx
```

或者，获取指定命令的帮助，例如： `create` 命令，可以输入：

```sh
jx help create
```

你也可以浏览 [jx 命令参考文档](/commands/jx)
