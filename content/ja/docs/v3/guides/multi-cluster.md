---
title: マルチクラスタ
linktitle: マルチクラスタ
description: helm 3と helmfile で複数のクラスターを使う方法
weight: 100
---


`Preprod` と `Production` 環境には別々のクラスタを使用することをお勧めします。これにより、環境を完全に分離してセキュリティを向上させることができます。


## マルチクラスタのセットアップ

新しいクラスタをセットアップするために、新しい[スタートアップのアプローチ](/docs/v3/getting-started/)に従ってください。`Preprod` や `Production` では、Lighthouse や tekton のような開発ツールは必要ありません。実際のアプリケーションと、それらを実行するために必要な追加サービス(例えば nginx-ingress や cert-manager など)が必要になるだけです。

そして、`Preprod` や `Production` クラスタ用の git リポジトリの URL ができたら、他の git リポジトリと同じように [git リポジトリのインポート](/docs/v3/creat-project/#import-an-existing-project) を [jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) コマンドを使って開発クラスタにインポートします。

```bash 
jx project import --url https://github.com/myowner/my-prod-repo.git
```        

これは、開発クラスタの git リポジトリに Pull Request を作成し、アプリのプロモーション時に `Preprod` や `Production` の git リポジトリにリンクします。


