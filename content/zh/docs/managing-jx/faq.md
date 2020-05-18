---
title: 开发问题
linktitle: 开发问题
description: 有关如何使用 Kubernetes， Helm 和 Jenkins X 构建云原生应用
---

## 如何注入特定的环境配置

Jenkins X 中的每个环境都在 git 存储库中定义; 我们使用 GitOps 来管理每个环境中的所有更改，例如：

* 添加/删除应用
* 更改应用程序的版本（更新或回滚）
* 使用环境特定值配置任何应用程序

前两个项在您环境的 git 存储库的 `env/requirements.yaml` 文件中定义。 后者在 `env/values.yaml` 文件中定义。

Helm charts 使用 [values.yaml文件](https://github.com/helm/helm/blob/master/docs/chart_template_guide/values_files.md)，以便您可以覆盖 charts 中的任何配置以修改设置，例如任何资源或资源配置上的标签或注释（例如 `replicaCount` ）或将环境变量等内容传递给 `Deployment` 。

所以，如果你想改变 `staging` 环境中应用 `foo` 的 `replicaCount` ，那么通过 [jx get env](/commands/jx_get_environments/) 查找 `staging` 环境的 git 存储库，找到 git URL 。

导航到 `env/values.yaml` 文件并添加/编辑一些 YAML ，如下所示：

```yaml
foo:
  replicaCount: 5
```

将该更改作为 Pull Request 提交，以便它可以通过 CI 测试并且进行任何同行评审/批准; 然后当它合并到它的 master 分支它将修改 `foo` 应用程序的 `replicaCount`（假设在 `env/requirements.yaml` 文件中有一个名为 `foo` 的 chart ）

如果需要，可以使用 vanilla helm 来执行注入当前命名空间之类的操作。

要查看如何使用 `values.yaml` 文件注入 chart 的更复杂示例，请参阅我们如何使用这些文件[配置 Jenkins X 本身](/zh/docs/resources/guides/managing-jx/common-tasks/config/)


## 如何管理每个环境中的 Secret ？

我们自己使用封闭 Secrets 来管理我们所有 CI/CD 的 Jenkins X 安装 - 所以 Secret 被加密并检出到每个环境的 git 仓库。 我们使用 [helm-secrets](https://github.com/futuresimple/helm-secrets) 插件来执行此操作。

虽然更好的方法是使用我们正在调研的 Vault Operator - 它可以通过 Vault 获取和填充密码（并回收它们等）。
