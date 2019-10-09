---
title: 贡献代码
linktitle: 开发
description: 如何为 Jenkins X 的发展做贡献
authors: [digitalcraftsman]
---

## 介绍

Jenkins X 是由众多[开发者][contributors]开发的开源项目。还有很多 [open issues][issues]，我们需要你的帮助来使 Jenkins X 变得更棒。即使你不是一个 Go 语言的专家，也可以对项目的开发贡献力量。


## 假设

本篇指导文档将帮助新接触 Jenkins X 的读者逐步熟悉它，因此我们假定：

* 你是刚刚接触 Git 或者开源项目
* 你是 Jenkins X 的爱好者并乐于对项目的发展贡献力量

{{% alert "有其它的问题？" %}}
如果在阅读此指导文档过程中有任何问题，请向 Jenkins X 社区的[讨论组](/community/)寻求帮助。
{{% /alert %}}

## 安装 Go

Go 语言环境的安装仅需要几分钟。并且多种方式可供选择。

如果在安装过程当中遇到问题，请查阅 [Go Bootcamp,which contains setups for every platform][gobootcamp] 或者向 Jenkins X [论坛][forums]中寻求帮助。


### 从源码安装 Go

[下载最新版 Go 源码][godl]并通过官方[安装文档][goinstall]进行安装。

安装完成后，确认是否一切工作正常。打开一个新的终端或者在 Windows 上的命令行并输入:

```sh
go version
```

在终端的窗口上可以看到类似如下的信息。注意 `version` 表示的是在在更新此文档时最新的 Go 的版本信息:

```sh
go version go1.8 darwin/amd64
```

下一步，确保[根据安装文档][setupgopath] 设置了 `GOPATH` 环境变量。
通过 `echo $GOPATH` 输出 `GOPATH`。应该是指向了你的合法的 Go 的工作目录的非空字符串，如:

```sh
/Users/<yourusername>/Code/go
```

### 使用 Homebrew 安装 Go

如果你是 MacOS 用户并且安装了 [Homebrew](https://brew.sh/)，安装过程将会很简单，在终端中执行以下命令:

```sh
brew install go
```

### 通过 GVM 安装 GO

更有经验的用户可以使用 [Go Version Manager][gvm] (GVM)。GVM 允许你在 *同一台机器上* 安装并切换使用多种版本的 Go 语言环境。如果你是初学者，可能不太需要这个功能。然而， GVM 通过几条命令可以很简单的更新到新发布版本的 Go 语言。

在开发 Jenkins X很长一段时间后，GVM 使用起来将会特别的方便。Jenkins X 之后的版本将会用最新版版的 Go 语言进行编译，因此如果想与社区开发同步的话，将会需要更新 Go 环境。

## 创建一个 GitHub 账号

如果你想要贡献代码的话，需要创建一个 Github 账号。登录 [www.github.com/join](https://github.com/join) 注册个人账号。

## 在你的系统上安装 Git
Jenkins X 开发过程当中需要在本机安装 Git 客户端。Git 的使用学习不包含在 Jenkins X 的文档中，如果你不确定从哪里开始的话，我们推荐通过 [Git book][gitbook] 学习使用 Git 的基本知识。使用的词汇将会通过注解进行解释。

Git 是一个[版本控制系统](https://en.wikipedia.org/wiki/Version_control)，用于跟踪源代码的变化。为了不重复造轮子，Jenkins X 使用了第三方的软件包来扩展功能。

Go 提供了 `get` 的子命令来帮助下载软件包以配置工作环境。这些软件包的源码信息在 Git 中记录。`get` 会与承载这些软件包的 Git 服务器端进行交互来下载所有的依赖。

回到终端中，输入 `git version` 并按回车，检验是否安装 Git。如果返回的是一个版本号信息，那么可以跳过下面的配置。否则的话[下载](https://git-scm.com/downloads)最新版的 Git 并根据[安装文档](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)进行安装。

最后，再一次输入 `git version` 检验 Git 是否已经安装。

### Git 图形化前端

有一些[图形界面客户端](https://git-scm.com/downloads/guis)可以帮助操作 Git。并不是所有的客户端在所有的操作系统上都有相应的版本，而且不同的客户端的使用方法也可能不同。因此，在以下的操作中，我们会以使用命令行的方式为基准。

### 在你的系统上安装 Hub（可选）

在与 GitHub 协同开发时，Hub 是个很好的工具。请访问 [hub.github.com](https://hub.github.com/)，来安装体验这个封装了 Git 的小工具。

在 Mac 系统上，可以通过 [Homebrew](https://brew.sh) 来安装 [Hub](https://github.com/github/hub)：

```sh
brew install hub
```

安装之后，在 Bash 中创建[快捷键](http://tldp.org/LDP/abs/html/aliases.html)，以方便我们在执行 `git` 的时候，实际上执行的是 `hub`:

```sh
echo "alias git='hub'" >> ~/.bash_profile
```

确认安装配置是否正确：

```sh
git version 2.6.3
hub version 2.2.2
```

## 设置你的工作副本

工作副本是在你的电脑中进行本地设置的。你将会对它进行编辑，编译以及最终推送回到 GitHub。主要的步骤是在远端对源 Git 代码库创建你的分支仓库并之后在本地进行克隆。

### 克隆仓库

我们假定你已经设置了 `GOPATH`（如果不确定的话查阅上面的相应部分）环境变量，现在以可以下载 Jenkins X 的代码库到本地电脑中。这一过程就是被称作“克隆仓库”。GitHub 的[帮助文档](https://help.github.com/articles/cloning-a-repository/)对其进行了简短的解释：

> When you create a repository on GitHub， it exists as a remote repository. You can create a local clone of your repository on your computer and sync between the two locations.

我们会克隆 Jenkins X 代码库的[主版本](https://github.com/jenkins-x/jx)。由于你还没有对代码库的提交代码的权限，这看上去有些违反常理。但是这一步骤在 Go 的工作流当中是必须的一项。你将会在主版本的副本中进行工作，将修改的部分提交到你在 GitHub 上的仓库当中。

首先，我们克隆主版本库：

```sh
go get -v -u github.com/jenkins-x/jx
```

Jenkins X 使用 [Testify](https://github.com/stretchr/testify) 进行 Go 代码的测试。如果还没有安装的话，使用下面的方式获得 Testify 测试工具：

```sh
go get github.com/stretchr/testify
```

### 派生仓库

如果对这个术语感到陌生的话，GitHub 的[帮助文档](https://help.github.com/articles/fork-a-repo/) 提供了简单的说明：

> A fork is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

#### 手工派生

打开 [Jenkins X 仓库](https://github.com/jenkins-x/jx)，点击右上角的 "Fork" 按钮。

![Fork button](/images/contribute/development/forking-a-repository.png)
现在打开你在 GitHub 中创建出的派生仓库， 拷贝远端连接。你可以在 HTTPS 和 SSH 协议间进行选择。 HTTPS 适用于任何情况。如果你不确定的话， 请[查阅](https://help.github.com/articles/which-remote-url-should-i-use/)。

![Copy remote url](/images/contribute/development/copy-remote-url.png)

切换到命令窗口中，进入到刚才所克隆的主版本库的工作目录当中。

```sh
cd $GOPATH/src/github.com/jenkins-x/jx
```

现在 Git 需要知道我们刚刚创建出来的分之仓库的地址信息

```sh
git remote add <YOUR-GITHUB-USERNAME> <COPIED REMOTE-URL>
```

#### 使用 Hub 派生

相类似的，可以使用 Git 的封装工具 Hub 进行操作。Hub 使得创建分之仓库变得容易：
```sh
git fork
```

这一命令会使用你的账号登录到 GitHub 中，并对当前所在的工作目录的主仓库创建派生仓库，在之后会将新创建的连接信息添加到你的工作副本当中。

#### 验证

让我们通过列出所有已有的 remote 来检查是否一切就绪：

```sh
git remote -v
```

输出应该类似如下内容：

```sh
digitalcraftsman    git@github.com:digitalcraftsman/hugo.git (fetch)
digitalcraftsman    git@github.com:digitalcraftsman/hugo.git (push)
origin  https://github.com/jenkins-x/jx (fetch)
origin  https://github.com/jenkins-x/jx (push)
```

## Jenkins X Git 贡献流程

### 创建新的分支

永远不要在 "master" 分支上进行代码的开发。开发团队也不会接受在此之上的 pull request。相反， 应该创建一个有描述信息的分之并在其之上进行开发。

首先， 你需要获取在主版本上进行的最新的内容：

```sh
git checkout master
git pull
```
现在，为你的附加功能创建一个新的版本：

```sh
git checkout -b <BRANCH-NAME>
```

可以通过 `git branch` 来检查你当前所在的分支。你可以看到一个包含所有本地分支的列表。在当前所操作的版本之前会有 “*” 标识。

### 贡献文档

也许你想先从 Jenkins X 的文档开始贡献。如果这样的话，你可以省略下面大部分的步骤，仅关注在刚克隆的代码库的 `/docs` 目录中的文件即可。 通过执行 `cd docs` 进入文档目录中。

可以通过 `hugo server` 启动 Jenxins X 内置的服务。 通过浏览器访问 [http://localhost:1313](http://localhost:1313) 进行浏览。Hugo 会监测所有文件内容的修改，并将其在浏览器中进行显示。

想了解更多的信息，包括 Jenkins X 文档是如何构建、组织以及由众多像你一样无私的人如何对其进行改进的，请[参阅](docscontrib)。

### 构建 Jenkins X

在代码库上进行更改的同时，创建相应的二进制文件来进行测试是很好的方法：

```sh
go build -o hugo main.go
```

### 测试
有时对代码的修改可能会带来没有注意到的负面影响。或者是并不像预期的那样工作。大部分的功能都有其相对应的测试用例。这些测试文件都以 `_test.go` 结尾。

请确保 `go test ./...` 命令通过没有异常以及 `go build` 执行完毕。

### 格式

Go 语言的代码格式也许根据人的意识会有所不同，但是不论是由谁编写的代码，Go 本身会确保代码看上去一致。Go 提供了格式化工具，使我们的修改风格统一：

```sh
go fmt ./...
```

如果进行了修改，请确保遵循我们的[代码贡献指导说明](https://github.com/jenkins-x/jx/blob/master/CONTRIBUTING.MD)。

```sh
# Add all changed files
git add --all
git commit --message "YOUR COMMIT MESSAGE"
```

代码的提交记录信息应该描述提交做了那些工作（如，添加功能 XYZ）而不是描述如何完成的。

### 修改提交

你也许注意到了一些提交记录信息并不遵守贡献指导说明或者你是在某些文件中忘记了什么。没关系，Git 提供了相应的工具来解决类似这样的问题。下面的两种方法将会覆盖所有的常见问题。

如果你不确定如何使用这些命令的话也可以保留不行改正，在之后提交 Pull Request 的时候，我们会对提交信息进行修改。

#### 修改最后一次提交

让我们以你想要修改最后的一次提交信息为例。执行下面的命令以替换之前的提交信息：

```sh
git commit --amend -m"新的提交信息"
```

检查历史提交记录，查询修改信息：

```sh
git log
# 输入 q 退出
```

在做了最后的修改后，你也许忘记了什么。没有必要创建新的提交。只需要将最新的修改添加到 Git 记录当中并在之后将其合并到之前的修改中：

```sh
git add --all
git commit --amend
```

#### 修改多次提交

{{% alert color="warning" title="Be Careful Modifying Multiple Commits"%}}
对此章节中介绍的修改，可能会造成不可意料的后果。如果不确定的如何使用的话，跳过下面的部分！
{{% /alert %}}

这一部分的操作需要更高的技能。Git 允许你对多次提交进行[修改](https://git-scm.com/docs/git-rebase)。换句话说：它允许你对历史的提交进行修改。


```sh
git rebase --interactive @~6
```

在命令结尾处的 `6` 表示的是想要进行修改的提交的编号。它会打开一个编辑器，其内容是之前6次的历史提交信息列表：

```sh
pick 80d02a1 tpl: Add hasPrefix to the template funcs' "smoke test"
pick aaee038 tpl: Sort the smoke tests
pick f0dbf2c tpl: Add the other test case for hasPrefix
pick 911c35b Add "How to contribute to Jenkins X" tutorial
pick 33c8973 Begin workflow
pick 3502f2e Refactoring and typo fixes
```

在上面的例子中，我们应该将最后的提交到本文档之间的提交(`Add "How to contribute to Jenkins X" tutorial`)历史提交进行合并。你可以“压缩”提交， 如，将两个及以上的提交合并为一个。
在提交信息之前，所有的操作都将会执行。替换 `pick` 为想要进行的操作。在这个例子当中我们使用 `squash` 或者其省略版 `s`。

```sh
pick 80d02a1 tpl: Add hasPrefix to the template funcs' "smoke test"
pick aaee038 tpl: Sort the smoke tests
pick f0dbf2c tpl: Add the other test case for hasPrefix
pick 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

根据代码贡献指导文档，在历史提交中的第三个提交忘记了添加前缀 "docs:"，因此想要对其进行修改。修改一个提交的操作是 `reword` 或者其省略版 `r`。

修改后，应该是类似如下的内容：

```sh
pick 80d02a1 tpl: Add hasPrefix to the template funcs' "smoke test"
pick aaee038 tpl: Sort the smoke tests
pick f0dbf2c tpl: Add the other test case for hasPrefix
reword 911c35b Add "How to contribute to Jenkins X" tutorial
squash 33c8973 Begin workflow
squash 3502f2e Refactoring and typo fixes
```

此时关闭编辑器。它会打开新的窗口，将会有文本指导你对之前的两次提交进行的合并（即，“压缩”）设置新的提交信息。输入 <kbd>CTRL</kbd>+<kbd>S</kbd> 保存文件关闭编辑器。

再一次，将会打开新的窗口。输入新的提交信息并且保存。你的终端将会显示如下类似的状态信息：

```sh
Successfully rebased and updated refs/heads/<BRANCHNAME>.
```

检查提交记录以确保修改成功。如果发生了错误的话，可以通过执行 `git rebase --abort` 来撤销操作。

### 推送提交

我们需要指定目标地址以使得将我们的提交推送回到在Github中的分支版本库。目标地址由 `remote` 和 `branch`名称所构成。在之前的操作中，`remote` 地址与我们的GitHub账号所对应，以我为例是 `digitalcraftsman`。分支（branch）应该和我们本地的一样。 这就使得识别相应的分支变得简单。

```sh
git push --set-upstream <YOUR-GITHUB-USERNAME> <BRANCHNAME>
```

现在Git知道了目标地址。在此之后，想要进行提交的时候，只需要输入 `git push`。

如果你在上一步骤对历史提交记录进行了修改，GitHub 会拒绝你的推送。这是一个保护功能，因为历史提交记录不一致以及新的提交不能像往常一样进行追加。你可以通过 `git push --force` 强制的进行提交。

## 打开一个 Pull Request

做的很好，我们有了很大的进展。在这一步，我们将会提出合并请求来提交我们的附加功能。在浏览器中打开 [Jenkins X 主代码库](https://github.com/jenkins-x/jx/)。

你会发现一个绿色按钮，上面标识 “New pull request”。GitHub 很智能，很有可能像如下图所示的那样，在一个米黄色窗口中建议你开 pull request：

![Open a pull request](/images/contribute/development/open-pull-request.png)

在新的页面当中，将会包含你的 pull request 中的重要信息。滚动鼠标你会发现所有的提交信息。确保所有的一切与构想的一致并点击按钮 “Create pull request”。


### 同意贡献者授权协议

最后也同样重要的是，你应该同意贡献者授权协议（CLA）。一个新的评论信息应该会自动的添加到你的 pull request 当中。点击黄色的徽章，同意协议并用你自己的 GitHub 账号进行认证。它仅需要几步点击之后即可完成。

![Accept the CLA](/images/contribute/development/accept-cla.png)

### 自动化构建

我们使用 [Travis CI loop](https://travis-ci.org/jenkins-x/jx) (Linux 和 OS&nbsp;X) 以及 [AppVeyor](https://ci.appveyor.com/project/jenkins-x/jx/branch/master) (Windows) 来对包含有你的提交的 Jenkins X 进行编译。 这可以确保在合并你的 pull request 之前，所有的都与所设想的工作一致。大部分情况下，如果你对 Jenkins X 的代码库进行了修改的话，这将很有意义。

![Automic builds and their status](/images/contribute/development/ci-errors.png)

在上图中，你可以看到 Travis 不能够对这个 pull request 进行编译。点击 “Details” 来查看失败的原因。但是这个错误并不一定是由你的提交所导致的。大部分情况下，我们使用 `master` 分支来作为基础来验证你的 pull request 是没有问题的。

如果你遇到问题的话，在 pull request 当中进行评论。我们愿意对你进行帮助。

## 从哪里开始？

感谢你阅读了本篇贡献指导文档。希望我们可以在 GitHub 中再次看到你。有很多 [open issues][issues] 需要你的帮助。

如果你认为发现了 bug 或者有新的想法可以改进 Jenkins X，请随时的 [open an issue][newissue]，我们很乐于听取你的声音。

## 学习 Git 和 Golang 的参考

* [Codecademy's Free "Learn Git" Course][codecademy] (免费)
* [Code School and GitHub's "Try Git" Tutorial][trygit] (免费)
* [The Git Book][gitbook] (免费)
* [Go Bootcamp][gobootcamp]
* [GitHub Pull Request Tutorial, Thinkful][thinkful]


[codecademy]: https://www.codecademy.com/learn/learn-git
[contributors]: https://github.com/jenkins-x/jx/graphs/contributors
[docscontrib]: /docs/contributing/documentation/
[forums]: https://discourse.jenkins-x.io
[gitbook]: https://git-scm.com/
[gobootcamp]: http://www.golangbootcamp.com/book/get_setup
[godl]: https://golang.org/dl/
[goinstall]: https://golang.org/doc/install
[gvm]: https://github.com/moovweb/gvm
[issues]: https://github.com/jenkins-x/jx/issues
[newissue]: https://github.com/jenkins-x/jx/issues/new
[releases]: /docs/getting-started/
[setupgopath]: https://golang.org/doc/code.html#Workspaces
[thinkful]: https://www.thinkful.com/learn/github-pull-request-tutorial/
[trygit]: https://try.github.io/levels/1/challenges/1
