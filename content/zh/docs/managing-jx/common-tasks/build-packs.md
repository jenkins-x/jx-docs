---
title: 构建打包
linktitle: 构建打包
description: 打包源码为 kubernetes 应用
---

我们使用 [draft](https://draft.sh/) 风格为不同的语言_构建打包_ ，我们通过[导入](/zh/docs/resources/guides/using-jx/common-tasks/import/)或者[创建](/zh/docs/resources/guides/using-jx/common-tasks/create-spring/)[他们](/zh/docs/getting-started/first-project/create-quickstart/)，运行时和构建工具添加必要的配置文件，因此我们可以在 Kubernetes 中构建和部署他们。

如果由于工程没有被创建或导入而不存在的话，构建包会默认使用下面的文件：

* `Dockerfile` 把代码构建为不可变的 docker 镜像，准备在 Kubernetes 中运行
* `Jenkinsfile` 为应用使用申明式 Jenkins 流水线定义 CI/CD 步骤
* helm chart 在文件夹 `charts` 中生成可以在 Kubernetes 中运行的 Kubernetes 资源
* 在 `charts/preview` 文件夹中的 _preview chart_ 定义了基于 Pull Request 部署一个[预览环境](/zh/about/concepts/features/#preview-environments)的所有依赖

默认的构建包在 [https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes)，每个语言或者构建工具在一个文件夹中。

 `jx` 命令行克隆构建包到你的文件夹 `.~/.jx/draft/packs/` ，并在你每次尝试创建或者到一个工程时通过 `git pull` 来更新他们。

## 创建新的构建

我们欢迎[贡献](/zh/community/)，因此，请考虑增加新的构建包和 [pod 模板](/zh/docs/resources/guides/managing-jx/common-tasks/pod-templates/)。

这里有如何创建一个新的构建包的指导 —— 如果有任何不清楚的请[加入社区并提问](/zh/community/)，我们很乐意帮助！

最好的开始就是 _快速开始_ 应用。你可以当作一个测试的样例工程。因此，创建或查找一个合适的例子工程，然后[导入](/zh/developing/import)。

然后，如果不存在的话，手动添加 `Dockerfile` 和 `Jenkinsfile` 。你可以从[当前构建包文件夹](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes/tree/master/packs)开始 —— 使用相似的语言或框架。

如果你的构建包使用了 [pod 模板](/zh/architecture/pod-templates) 中不存在的构建工具，你需要[提交一个新的 pod 模板](/zh/docs/resources/guides/managing-jx/common-tasks/pod-templates/#submitting-new-pod-templates)，还可能需要一个新的构建容器景象。

一旦你有了 pod 模板可以使用，例如你的 `Jenkinsfile` 中引用到的 `jenkins-foo` ：

```groovy
// my declarative Jenkinsfile

pipeline {
    agent {
      label "jenkins-foo"
    }
    environment {
      ...
    }
    stages {
      stage('CI Build and push snapshot') {
        steps {
          container('foo') {
            sh "foo deploy"
          }
```

一旦你的 `Jenkinsfile` 可以在你的示例工程为你的语言实现 CI/CD 的话，我们因该把 `Dockerfile`, `Jenkinsfile` 和 charts 文件夹拷贝到你的派生 [jenkins-x/draft-packs 仓库](https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes) 中。

你可以通过把他们添加到构建包的本地库 ` ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs` 中来尝试。

例如：

```sh
export PACK="foo"
mkdir ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK
cp Dockerfile Jenkinsfile  ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK

# the charts will be in some folder charts/somefoo
cp -r charts/somefoo ~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/$PACK/charts
```

当你的构建包在 `~/.jx/draft/packs/github.com/jenkins-x/draft-packs/packs/` 文件夹中，就可以通过命令 [jx import](/commands/jx_import/) 来导入工程，使用编程语言来检测并查找最合适的构建包。如果你的构建包自定义检测逻辑的话，请让我们指导，我们可以帮助改进 [jx import](/commands/jx_import/) 使得在你的构建包上做的更好。例如：我们有一些自定义逻辑更好地处理 [maven 和 Gradle](https://github.com/jenkins-x/jx/blob/master/pkg/jx/cmd/import.go#L383-L397)。

如果你需要任何帮助 [请加入社区](/zh/community/) 。