---
title: IDE
linktitle: IDE
description: 在你的 IDE 中使用 Jenkins X
---


作为开发人员，我们经常在 IDE 上花大量的时间来编码。Jenkins X 完全是为了帮助开发人员快速交付商业价值的，因此，我们希望使得 Jenkins X 在你的 IDE 中更加容易使用。

因此，我们有 IDE 插件来方便使用 Jenkins X。

## VS Code

[VS Code](https://code.visualstudio.com/) 是一个流行的来自微软的开源 IDE。

我们已经为 VS Code 研发了插件 [vscode-jx-tools](https://github.com/jenkins-x/vscode-jx-tools)。

你可以在 `扩展` 窗口把插件安装到 VS Code，搜索 `jx` 应该能查到这个扩展。

安装完后点击 `重新加载`，你应该就能使用了。

如果你展开 `JENKINS X` 导航窗口，应该能看到你创建工程的实时更新界面，还有 Pull Request 被创建或者代码被合并到了 master。

<img src="/images/vscode.png">

### 特色

* 浏览你所在团队的所有流水线的实时更新，包括发布或者 Pull Request 流水线的开始和结束
* 在 VS Code 终端内打开流水线构建日志
* 轻松地浏览 Jenkins 流水线页面、git 仓库、构建日志或者应用
  * Jenkins X 浏览器的右键点击
  * 还有启动（停止）流水线！
* 通过一个命令打开 [DevPods](/zh/docs/reference/devpods/) ，保持源码与云上的相同容器镜像和 pod 模板同步
