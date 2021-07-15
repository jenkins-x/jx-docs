---
title: どのように動作するか
linktitle: どのように動作するか
description: Jenkins X 3.x がカバーの下でどのように機能するか
weight: 130
---


## どのように動作するか

GitOps リポジトリのテンプレートには、ソースコード、スクリプト、ドキュメントが含まれており、クラウドリソースを作成するのに役立ちます (例: kubernetes クラスタやバケット、Secret マネージャーなど)。

[利用可能なテンプレートから GitOps リポジトリを作成し、指示に従って](/docs/v3/getting-started/)インフラストラクチャを設定したら、[jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) コマンドを使って [git operator をインストール](/docs/v3/guides/operator/)します。


```bash
    jx admin operator
```


このコマンドは、基本的には [git operator](https://github.com/jenkins-x/jx-git-operator) チャートをインストールするもので、git URL とユーザー名、そして起動処理を実行するためのトークンを渡します。


### Git Operator

[git operator](https://github.com/jenkins-x/jx-git-operator) は、git リポジトリをポーリングして変更を探し、その変更に対して kubernetes のジョブを実行することで動作します。ジョブリソースは git リポジトリ内の **.jx/git-operator/job.yaml** に定義されています。

コマンドでブートジョブのログを見ることができます。


```bash
    jx admin log
```


または、操作タブの Octant UI でログを参照することができます。


### ブートジョブ

ブートジョブは起動時に実行され、オペレータをインストールする際に使用した GitOps リポジトリへの任意の git コミットで実行されます。

ブートジョブは、git の **.jx/git-operator/job.yaml** で定義されており、基本的には以下のようになります。


* Generate ステップの実行
* apply ステップの実行


#### Generate ステップ

このステップは、以下の状況で実行されます。


* 起動時
* プルリクエストの各コミット後
* プルリクエストのマージではないメインブランチへのコミットが行われるたび


Generate ステップは以下のようなことを行います。


* **jx-values.yaml** ファイル内の欠落している値 (クラスタ情報、ドメイン名) を解決します
* 欠落しているバージョンや helm values.yaml ファイルの **helmfile.yaml** ファイルを解決します
* すべてのチャート用の kubernetes リソースを生成するために `helmfile template` を実行します
* 生成されたすべてのリソースを **config-root/namespaces/myns/somechart/*.yaml** にあるファイルのツリーにコピーします
    * **myns** は、リソースの名前空間です
    * **Somechart** はチャートの名前 (またはチャートの別名) です
* すべての **Secret** リソースは **ExternalSecret** に変換され、git にチェックインできるようになります
* デプロイを助けるために、いくつかの追加ステップが YAML 上で実行されます
    * 共通のラベルを追加し、`kubectl apply --prune --selector` が使えるようにします
    * リソースにいくつかのハッシュを追加して、設定を変更するとローリングアップグレードが発生するようにします
    * [プッシャー波](https://github.com/pusher/wave)演算子のサポートを追加し、Secret の値を変更すると (Vault や Amazon/Amazon/Azure/Google の Secret Manager の内部で) ポッドのローリングアップグレードが発生するようにしました


#### Apply ステップ

このステップは (generate ステップが完了した後) メインブランチへのコミットに対して実行されます。

これは基本的には、git の **config-root** ツリーにあるリソースの `kubectl apply` を行います。

Apply ステップは、必要に応じて他のツールで実行することができます (例: Google Anthos Config Sync や flux)。


### Promotion

クイックスタートを作成したり、新しいプロジェクトをインポートしたりすると、Jenkins X 2.x と同様に新しいリリースが作成され、プロモーションが開始されます。

Jenkins X 2.x からの変更点は、デフォルトで kubernetes のリソースを git に含めるようになったことです。

そのため、起こりがちなことは以下のようになります。

* パイプラインのプロモーションステップでは、GitOps リポジトリ上に Pull Request を作成し、クラスタの helm チャートとバージョンの追加やアップグレードを行います
* 上記の生成と適用のステップは、追加、変更、削除される実際の kubernetes リソースの Pull Request に詳細を記入するために実行されます

つまり、典型的なプロモーションのプルリクエストでは2つのコミットを見ることになるでしょう。それは Helm チャートとバージョンのハイレベルな変更、そして kubernetes に適用される実際の変更の詳細です。


## 2.x との比較

ハイレベルの Jenkins X 3.x は 2.x と似たようなものです。

* アプリケーションや設定、バージョン管理に GitOps を使っています。Secret の値以外はすべて git で管理します。

しかし、3.x ではいくつかの変更が行われました。

* GitOps リポジトリテンプレートのライブラリを使用するようになり、[Jenkins X の設定のための UX がよりシンプルになりました](/docs/v3/getting-started/)
    * これにより、使用したいインフラストラクチャ、ツール、シークレットストアの種類に最も近い例を選択することができるので、要件が一般的なクイックスタートに適合していれば、簡単に開始することができます
* セットアップ/インストール/アップグレードのプロセスは、開発者のラップトップではなく、kubernetes の内部で実行されます
    * これにより、git, kubectl, helm などのようなツールのインストールが異なる場合のあらゆる種類の問題を回避することができます
* 2.x では、私たちは常に Dev、Staging、Production 用の git リポジトリを持っていました。3.x では、これらの環境がすべて同じクラスタ内にある場合は、クラスタレベルのリソースや名前空間のリソースを設定するために同じ git リポジトリを使用します
    * そのため、デフォルトでは Jenkins X 3.x でインストールするための git リポジトリが1つあります
    * 別々のクラスタを作成した場合 (例えば マルチクラスタサポートのためにステージング環境と本番環境を別々にしたい場合など)、それぞれのクラスタにはそれぞれ独自の git リポジトリが作成されます
