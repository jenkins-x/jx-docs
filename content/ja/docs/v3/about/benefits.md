---
title: メリット
linktitle: メリット
description: Jenkins X 3.x を使用するメリット
weight: 80
---


* [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/), [kpt](https://googlecontainertools.github.io/kpt/) のようなバニラツールを使用して、helm 2.x や tiller やカスタムコードを使用せずに、任意の名前空間にチャートをインストール、更新、削除することができます
  * Jenkins X 2.x で使用していた `jx step helm apply` ロジックの複雑さをすべて回避することができます
  * 代わりに、これをバニラの [helmfile](https://github.com/roboll/helmfile) に置き換えて、helm を使用する際にオプションで `values.yaml` ファイルをテンプレート化できるようにしています
* 新しい [Getting Started](/docs/v3/getting-started/) アプローチは、はるかにシンプルで設定やカスタマイズが簡単で、Terraform のようなツールときれいに統合されており、異なるクラウドインフラストラクチャープラットフォームでもうまく動作します
  * デフォルトのインストール/アップグレードパイプラインは、生成されたすべての kubernetes リソースとカスタムリソースを YAML でチェックするので、理解しやすいです
  * [git のレイアウトについてはこちら](https://github.com/jenkins-x/jx-gitops/blob/master/docs/git_layout.md)をご覧ください
    * `config-root/cluster` フォルダには、`ClusterRole`、`Namespace`、Custom Resources などのグローバルなクラスタレベルのリソースがすべて含まれています
    * `config-root/namespaces/jx` フォルダには、`jx` 名前空間のすべての名前空間リソースが含まれています
  * これにより、異なる RBAC を持つ異なるブート `Jobs` で柔軟に適用ロジックを使用することが容易になります (あるいは、システム管理者がクラスタレベルのリソースを手作業で適用することも可能です)
* [Kubernetes External Secrets](https://github.com/godaddy/kubernetes-external-secrets) を使用して、以下のバックエンドシステムをサポートする Secret を管理するための単一の方法を提供します
  * Alibaba Cloud KMS Secret Manager
  * AWS Secrets Manager
  * Azure Key Vault
  * GCP Secret Manager
  * Hashicorp Vault
* これは柔軟な[マルチクラスタサポート](/docs/v3/guides/multi-cluster/)への扉を開き、すべてのクラスタを単一の git リポジトリから同じ標準的な GitOps アプローチで管理できるようにします
* 新しい[スタートアップアプローチ](/docs/v3/getting-started/)では、ブートパイプラインを Kubernetes クラスタ内の `Job` として実行します。これにより、使用されるツールの一貫性が確保され、開発者のラップトップに Secret を持たないようにすることでセキュリティも向上します
  * Jenkins X をインストールする際にローカルマシン上で実行するのは、シンプルな舵取り図である [git operator のインストール](/docs/v3/guides/operator/)だけです
* これですべてがアプリになりました。ですから、`nginx-ingress` チャートを削除して別の ingress ソリューション (knative / istio / gloo / ambassador / linkerd など) に置き換えたいのであれば、[apps コマンド](/docs/v3/guides/apps/) を使ってアプリを追加/削除し、一貫した方法ですべてをブート管理するようにしてください
    * 例えば、`chartmusem` と `nexus` を削除して `bucketrepo` に置き換える[例](https://github.com/jx3-gitops-repositories/jx3-kind-vault/blob/master/helmfile.yaml#L17)です
* 望むならば、特定の名前空間にアプリをインストールすることができます
    * これにより、複数のチームが異なるネームスペースを使用しているが、同じクラスタ内でサービスを共有している複数チームのインストールをブートで設定することも可能になります
* クラスタの GitOps リポジトリは、上流の Git リポジトリとの同期/リベース/マージがシンプルで簡単です
  * 私たちはそのために [kpt](https://googlecontainertools.github.io/kpt/) を使っています
  * インストール後に[バージョンストリーム](https://jenkins-x.io/about/concepts/version-stream/)を GitOps リポジトリ内の `versionStream` ディレクトリにも含めるようにしたので、インストールに関するすべての情報がひとつの git リポジトリ内にあるので、変更のテストや整合性の確保がより簡単になりました
* 設定やアップグレードを簡単にするために、複合チャートを避けることができます
* `exposecontroller` を使用せず、通常の Helm 設定を使用して `Ingress` リソースを作成し、[ドメイン名をオーバーライドする](/docs/v3/guides/faq/#how-do-i-configure-the-ingress-domain-in-dev-staging-or-production)ようにしました
* Secret の取り扱いは現在のところ、自分のアプリや Jenkins X で使用されているアプリの名前空間やクラスタ内のあらゆる Secret に対して Kubernetes External Secrets を使用することではるかにシンプルになります
