---
title: 升级
linktitle: 升级
description: 升级你的应用新版本到环境
---


Jenkins X 的升级策略配置为 `Auto` 时，持续部署流水线通过配置好的[环境](/zh/about/concepts/features/#promotion)来自动化[升级](/zh/about/concepts/features/#promotion)版本。默认情况下，`Staging` 环境使用自动升级，`生产`环境使用`手动`升级。

要手动升级应用的一个版本到特定环境上，可以使用命令 [jx promote](/commands/jx_promote/)。

```sh
jx promote myapp --version 1.2.3 --env production
```

该命令会等待升级完成，并记录过程的详细信息。你可以通过参数 `--timeeout` 为升级等待设置超时时间。

例如：等待5小时

```sh
jx promote myapp --version 1.2.3 --env production --timeout 5h
```

你可以使用类似 `20m` 或 `10h30m` 这样的时间表达式。

<img src="/images/overview.png" class="img-thumbnail">

### 反馈

如果提交注释中引用了问题（例如：通过文本 `fixes #123`），那么，Jenkins X 流水线会自动生成类似 [jx 发布](https://github.com/jenkins-x/jx/releases) 的发布记录。

同样的，升级到 `Staging` 或 `生产` 环境中的提交日志中也会自动关联每个修复的问题，包括有发布日志和应用所运行环境的链接。

<img src="/images/issue-comment.png" class="img-thumbnail">
