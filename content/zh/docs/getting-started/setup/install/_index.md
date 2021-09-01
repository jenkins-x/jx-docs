---
title: 安装 jx
linktitle: 安装 jx
description: 如何在你的机器上安装jx二进制包
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2017-02-01
categories: [getting started]
keywords: [install]
weight: 2
---

根据你的操作系统选择最适合的指令：

### macOS

在 Mac 上你可以使用 [brew](https://brew.sh/)：

```sh
brew install jenkins-x/jx/jx
```

或者，如果您尚未安装 [brew](https://brew.sh/) ，并且喜欢手动安装的话，请执行如下指令安装:

1. Download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
```

    or, if you don't have `jq` installed:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-darwin-amd64.tar.gz" | tar xzv "jx"
```

2. Install the `jx` binary by moving it to a location which should be on your environments PATH, using
    the `mv` command:

```sh
sudo mv jx /usr/local/bin
```

3. Run `jx version` to make sure you're on the latest stable version

```sh
jx version
```

### Linux

To install Jenkins X on Linux, download the `.tar` file, and unarchive it in a directory where you can run the `jx` command.

1. Download the `jx` binary archive using `curl` and pipe (`|`) the compressed archive to
    the `tar` command:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

    or, if you don't have `jq` installed:

```sh
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx"
```

2. Install the `jx` binary by moving it to a location which should be on your environments PATH, using
    the `mv` command:

```sh
sudo mv jx /usr/local/bin
```

3. Run `jx version` to make sure you're on the latest stable version

```sh
jx version
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

你也可以浏览 [jx 命令参考文档](/commands/jx/)
