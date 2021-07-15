---
title: UI
linktitle: UI
description: Jenkins X のユーザーインターフェイス
weight: 85
---

## Octant

Kubernetes、Jenkins X、Tekton などのリソースを扱うための汎用的な UI として、[Octant](https://octant.dev/)を 強くお勧めします。

まずは [Octant と Jenkins X の使い方のドキュメント](/docs/reference/components/ui/)をチェックしてみてください。

## Pipeline Visualizer

git プロバイダ上の Pull Request をクリックして、その Pull Request 上でそのコミットのパイプラインログを表示したいというのは、一般的な要件です。

これを実装するために、Jenkins X の中に [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) というアプリケーションを入れています。

これは、パイプラインやパイプラインのログを見るためのシンプルな Web UI を提供し、Jenkins X で管理されているリポジトリ上で作成した Pull Request と自動的にリンクします。

### Pipelines Visualizer へのアクセス

Jenkins X で [作成またはインポート]() した git リポジトリ上に Pull Request を作成すると、Pull Request にリンクが表示されるはずです。ここに例を示します - Pull Request パイプラインの右側にある **Details** リンクを参照してください。

<img src="/images/quickstart/pr-link.png" class="img-thumbnail">

**詳細**リンクをクリックすると、このパイプラインビルドの [jx-pipelines-visualizer](https://github.com/jenkins-x/jx-pipelines-visualizer) UI が開きます。

### Pipelines Visualizer へのログイン

[チャートをカスタマイズする](/docs/v3/guides/apps/#customising-charts)で `Ingress` を変更しない限り、デフォルトでは _basic 認証_ を使用して Web UI にアクセスし、パイプラインのログがインターネット上に公開されないようにします。

デフォルトのユーザ名は `admin` です。

UI にアクセスするために生成されたランダムなパスワードを探すには、以下のように入力します。

```bash 
jx ns jx
kubectl get secret jx-basic-auth-user-password -o jsonpath="{.data.password}" | base64 --decode
```

ランダムに生成されたパスワードが表示されるはずです。

ブラウザにユーザ名とパスワードを入力すると、ダッシュボードが開きます。


