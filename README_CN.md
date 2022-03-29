[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/jenkins-x/jx-docs)

# Jenkins X 文档

<a id="markdown-jenkins-x-docs" name="jenkins-x-docs"></a>

这个仓库保存  [jenkins-x.io](http://jenkins-x.io/) 的源文件

**NOTE：**请浏览这些文档在 [jenkins-x.io](http://jenkins-x.io/) ，浏览此库中的 Markdown 文件时，并非所有链接都有效。

---

<!-- TOC -->

- [建立文档](#建立文档)
  - [准备资源](#准备资源)
    - [Git 子模块](#Git 子模块)
  - [下载 npm 模块](#下载 npm 模块)
  - [运行 Hugo](#运行 Hugo)
    - [本地](#本地)
    - [Dockerized](#dockerized)
- [通用工作流程](#通用工作流程)
  - [运行拼写检查](#运行拼写检查)
  - [检查链接、图像等](#检查链接、图像等)
  - [添加重定向](#添加重定向)
  - [升级增强内容](#升级增强内容)
  - [升级 docsy](#升级 docsy)
- [本土化](#本土化)
- [贡献](#贡献)

<!-- /TOC -->

---

## 建立文档

<a id="markdown-building-the-docs" name="building-the-docs"></a>

### 准备资源

<a id="markdown-preparing-the-sources" name="preparing-the-sources"></a>

为了能够本地编辑这个文档，你需要去 clone 这个仓库：

```bash
git clone  --recurse-submodules --depth 1 https://github.com/jenkins-x/jx-docs.git
```

#### Git 子模块

<a id="markdown-git-submodules" name="git-submodules"></a>

注意使用`--recurse-submodules` 在上面的clone命令中。

这个选项会 pull 两个 git [子模块](https://git-scm.com/book/en/v2/Git-Tools-Submodules)，叫做 [docsy](https://github.com/google/docsy) 和 [labs-enhancements](https://github.com/jenkins-x/enhancements)。

如果你已经有一个没有子模块的 git clone，你可以运行：

```bash
git submodule update --init --recursive
```

在随后通过 ``git pull``更新源代码时还要记住去 pull 子模块的更改：

```bash
git pull --recurse-submodules
```

你可以通过以下方式查看子模块的 commit：

```bash
git submodule status --recursive
```

### 下载 npm 模块

<a id="markdown-downloading-npm-modules" name="downloading-npm-modules"></a>

在得到所有资源之后，你需要去 [安装 npm](https://www.npmjs.com/get-npm) 和确保需要的npm模块已经被安装

```bash
npm install
```

### 运行 Hugo

<a id="markdown-running-hugo" name="running-hugo"></a>

该站点本身使用[Hugo](https://gohugo.io/) 构建的，并在[`config.toml`](./config.toml) 中进行配置。

你有两个方式运行 Hugo，直接运行在你的机器上面或通过[Docker Compose](https://github.com/docker/compose)。

以下两节更详细地描述了这两种备选方案。

**NOTE:** Hugo 在开发模式下将站点呈现在内存中，默认情况下，不会将任何内容写入磁盘。

#### 本地

<a id="markdown-locally" name="locally"></a>

如果你想要在你机器上面构建本地站点，你需要去[安装](https://gohugo.io/getting-started/installing) Hugo，检查[Makefile](./Makfile) 以了解最新的推荐版本使用，并且检查Golang的环境变量有无设置好。 

一旦你安装了，你可以运行：

```bash
make server
```

你可以现在访问[localhost:1313](http://localhost:1313)下的站点。

#### Dockerized

<a id="markdown-dockerized" name="dockerized"></a>

代替本地安装 Hugo，你可以使用提供的`docker-compose.yml` 去启动 Hugo服务

在容器化环境中。

确保你已经安装了[Docker](https://docs.docker.com/install/) 。

```bash
make compose-up
```

你现在可以访问在[localhost:1313](http://localhost:1313)下的站点。

这个 Hugo服务在后台运行，你可以通过以下方式停止它：

```bash
make compose-down
```

## 通用工作流程

<a id="markdown-common-workflows" name="common-workflows"></a>

### 运行拼写检查

<a id="markdown-running-spell-check" name="running-spell-check"></a>

我们并非都是拼写大师，所以幸运的是，有一些工具可以帮助我们解决这个问题，我们正在使用[node-markdown-spellcheck](https://github.com/lukeapage/node-markdown-spellcheck)  去遍历我们所有的markdown 文件并列出任何拼写问题或者位置单词。

为了使这个尽可能简单，只需要运行一下命令：

```bash
make spellcheck
```

该报告可能包括拼写正确的单词，但这仅意味着拼写检查器不知道正确的拼写（技术术语、命令等经常发生）。
请编辑 [`.spelling`](./.spelling) 并添加未知单词。
另外，请尽量保持列表按字母顺序排序，这样更易于浏览。

### 检查链接、图像等

<a id="markdown-checking-links-images-etc" name="checking-links-images-etc"></a>

为了获得检查所有链接的帮助，我们使用[htmlproofer](https://github.com/chabad360/htmlproofer)。

```bash
make linkcheck
```

**NOTE:** 初始运行非常慢（由于外部链接检查），并且缓存仅在完成时才建立。

**NOTE:**  现在忽略`... x509: certificate ...` 错误是安全的

### 添加重定向

<a id="markdown-adding-redirects" name="adding-redirects"></a>

如果您将页面移动到不同的位置，你可以通过在页面标题中使用 _aliases_ 条目来添加重定向：

```yaml
aliases:
  - /some/old/path
  - /another/path
```

### 升级增强内容

<a id="markdown-upgrading-the-enhancements-content" name="upgrading-the-enhancements-content"></a>

要升级到新的增强提交 - 我们希望很快会自动执行此操作！

```bash
cd content/en/docs/labs/enhancements
git checkout master
git pull
cd ..
git add enhancements
git commit -m "move to latest enhancements"
```

### 升级 docsy

Docsy 作为主题目录下

文档被加入到 jx-docs仓库作为子模块在主题文件夹下面，

为了升级文档，运行下面的命令：

```bash
cd themes/docsy
git pull origin master
git submodule update --init --recursive
```

## 本土化

<a id="markdown-localization" name="localization"></a>

为了让更多人更好的知道 Jenkins X，本土化是很必要的和有意义的。

然后关于这个我们需要遵守一些规则，请阅读下面的相关语言：

- [中文](Localization_Chinese.md)

## 贡献

<a id="markdown-contributing" name="contributing"></a>

请参阅可用的文档贡献指南 [Jenkins X website](https://jenkins-x.io/community/documentation/).
