---
title: 问题
linktitle: 问题
description: 问题处理
---


Jenkins X 默认使用你的 git 提供商中的问题跟踪系统来创建和浏览问题。

例如：如果你在 GitHub 项目中的源码中，那么你可以输入 [jx create issue](/commands/jx_create_issue/)：

```sh
jx create issue -t "lets make things more awesome"
```

一个新的问题就会在 GitHub 上被创建。

你可以在你的项目上通过 [jx get issues](/commands/jx_get_issues/) 列出打开的问题：

```sh
jx get issues
```

### 使用不同的问题跟踪

如果你希望在项目中使用 JIRA，你首先需要添加一个 JIRA 服务。

你可以通过 [jx create tracker server](/commands/jx_create_tracker_server/) 注册你的 JIRA服务：

```sh
jx create tracker server jira https://mycompany.atlassian.net/
```

然后，你就可以通过 [jx get tracker](/commands/jx_get_tracker/) 来查看你的问题追踪了：

```sh
jx get tracker
```

然后，通过下面添加一个用户和 token：

```sh
jx create tracker token -n jira  myEmailAddress
```

### 配置项目的问题跟踪

在你项目的源码中使用 [jx edit config](/commands/jx_edit_config/):

```sh
jx edit config -k issues
```

然后

* 如果你有多个问题跟踪系统，选择一个用于当前项目
* 在问题跟踪系统中输入项目名称（例如：大写的 JIRA 项目名称）

在你的项目中一个叫做 `jenkins-x.xml` 的文件会被修改，这个文件应该被加到你的 git 库中。
