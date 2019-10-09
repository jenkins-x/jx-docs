---
title: Pod 模板
linktitle: Pod 模板
description: 用于实现 Jenkins 流水线的 Pods
---

我们使用申明式（declarative）Jenkins 流水线实现 CI/CD ，每个应用或者环境的 git 库源码中有 `Jenkinsfile`。

我们使用 Jenkins 的 [kubernetes 插件](https://github.com/jenkinsci/kubernetes-plugin)，使得在 Kubernetes 中为每次构建启动一个新的 pod —— 感谢 Kubernetes 给了我们一个用于运行流水线的伸缩的代理池。

Kubernetes 插件使用 _pod templates_ 定义用于运行 CI/CD 流水线的 pod，包括：

* 一个或多个构建容器，用于运行命令（例如：你的构建工具，像 `mvn` 或 `npm` ，还有流水线的其它部分的工具，像 `git, jx, helm, kubectl` 等等
* 永久存储卷
* 环境变量
* 可以写到 git 仓库、docker 注册表、maven/npm/helm 仓库等等的 secret

## 参考 Pod Templates

Jenkins X 带有一套给支持的语言和运行时的默认 pod 模板，在你的 [build packs](/zh/architecture/build-packs)中，命名类似于：`jenkins-$PACKNAME`。

例如 [maven build pack](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/) 使用的 pod 模板时是 `jenkins-maven`。

然后，我们就可以 [在 Jenkinsfile 中引用 pod 模板名称](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/blob/master/packs/maven/Jenkinsfile#L1-L4)，在申明式流水线中使用这样的语法 `agent { label "jenkins-$PACKNAME }` ，例如：

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-maven"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('maven') {
            sh "mvn deploy"
          }
          ...
```

## 提交新的 Pod 模板

如果你正在使用一个新的 [build pack](/zh/architecture/build-packs)，那么，我们欢迎你 [提交](/zh/docs/contributing/) 一个新的 pod 模板，而且我们可以把它包含在 Jenkins X 的发行版中！

现在遵循如何这个的指示 —— 如果有任何不清楚的话请[加入社区并提问](/zh/community/)，我们很高兴帮助你！

为了提交一个新的 build pack：

* 派生 [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/) 库
* 增加你的 build pack 到 [jenkins-x-platform 库中的 values.yaml 文件里](https://github.com/jenkins-x/jenkins-x-platform/blob/master/values.yaml#L194-L431) 在 YAML 文件的 `jenkins.Agent.PodTemplates` 这个区域
* 你啃根想要从复制、粘贴开始大多数相似已经存在 pod 模板（例如：拷贝 `Maven`，如果你使用基于 Java 的构建pod），并且，只是配置名称、标签和 `Image` 等等。
* 现在到 [jenkins-x-platform](https://github.com/jenkins-x/jenkins-x-platform/) 库为你的 pod 模板提交一个 Pull Request

### 构建容器

当使用 pod 模板和 Jenkins 流水线时，每个工具你可以用很多不同的容器。例如： `maven` 容器和 `git` 等。

我们发现，在一个构建容器里有所有通用的工具会比较简单。这也意味着你可以使用 `kubectl exec` 或 [jx rsh](/commands/jx_rsh) 打开一个构建 pod 的 shell，当你调试、诊断有问题的流水线时里面有所有需要的工具。

因此，我们有一个 [builder-base](https://github.com/jenkins-x/builder-base) 的 docker 镜像，[包含所有不同的工具](https://github.com/jenkins-x/builder-base/blob/master/Dockerfile#L21-L70) ，我们倾向于在 CI/CD 流水线中使用像 `jx, skaffold, helm, git, updatebot` 的工具。

如果想要在你新的 pod 模板中使用单一的构建惊喜那个，那么，你可以使用 builder base 作为基础增加你自定义的工具。

例如：[builder-maven](https://github.com/jenkins-x/builder-maven) 使用一个 [Dockerfile](https://github.com/jenkins-x/builder-maven/blob/master/Dockerfile#L1) 引用基础构建。

因此，最简单的就是拷贝一个简单的 builder —— 像 [builder-maven](https://github.com/jenkins-x/builder-maven)，然后编辑 `Dockerfile` 增加你需要的构建工具。

我们欢迎 Pull Requests 和[贡献](/zh/docs/contributing/)，因此，请把你新的构建容器和 Pod 模板提交，我们很乐意[帮助](/zh/docs/contributing/)！

## 增加你自己的 Pod 模板

为了保持简单，我们倾向于在 Jenkins 配置中定义 pod 模板，然后在 `Jenkinsfile` 中通过名称来引用。

尽管一个 pod 模板倾向于有很多开发环境定义在里面，像 secrets；如果需要的话，你可以尝试在 `Jenkinsfile` 中用内联的形式定义 pod 模板，使变得简单。但我们更喜欢把大多数 pod 模板保留在你的开发环境源码中，而不是在每个应用中拷贝、粘贴。

现在，添加新的 Pod 模板最简单的方式就是通过 Jenkins 控制台。例如：

```sh
jx console
```

这样就会打开 Jenkins 控制台。然后，导航到`管理 Jenkins`（在左侧菜单），然后`系统配置`。

你将会面临大量的页面配置选项，Pod 模板通常在底部；你应该看到了当前所有的 pod 模板，像 maven、NodeJS 等等。

你可以在那个页面编辑、增加、移除 pod 模板并点击保存。

注意，长期来说，尽管我们希望[通过 GitOps 维护你的开发环境，就像是我们做的 Staging 和 Production](https://github.com/jenkins-x/jx/issues/604) —— 也就意味着当你[升级你的开发环境](/commands/jx_upgrade_platform)通过 Jenkins 界面做的修改可能会丢失。

因此，我们希望把 Pod 模板添加到你的开发环境 git 库的 `values.yaml` 文件中，就像我们在 [jenkins-x-platform chart](https://github.com/jenkins-x/jenkins-x-platform/blob/master/values.yaml#L194-L431) 做的一样。

如果你正在使用开源工具创建 pod 模板，那么[在 Pull Request 中提交你的 pod 模板](#submitting-new-pod-templates)会比较简单，我们可以把它添加到 Jenkins X 未来的发行版中？
