---
title: はじめに 
linktitle: はじめに
description: Jenkins X 3.x を使い始める
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 10
---

Jenkins X 3.x alpha には、Kubernetes の YAML を維持するために helm 3、kpt、kustomize などのツールを使用する新しいインストールアプローチが含まれています。これは Jenkins X 2 に対する多くの[改善点](/docs/v3/about/benefits/)の一つです。

Jenkins X 3.x alpha は、Jenkins X 2 に比べてアーキテクチャが簡素化され、複雑さが軽減されています。 Jenkins X 3.x alpha の概要については、[こちら](/docs/v3/about/overview/)を参照してください。

## やってみましょう

- 新しい `jx` CLI をダウンロードして、https://github.com/jenkins-x/jx-cli/releases/latest から OS 用の適切なスニペットを実行して実行可能なパスにインストールします

新しい `jx` CLI はプラグインシステムを利用して、Jenkins X で作業する際にサブコマンドを追加します。

新しい `jx` CLI を入手したら、Jenkins X を管理して作業するためのサブコマンドプラグインの基本セットをダウンロードしてください。

```bash
jx upgrade plugins
```

## 最初の git リポジトリをピックします。

どの Git テンプレートから始めるかを決める前に、Jenkins X 3.x alpha の複雑さを解消するために、必要に応じて他のソリューションに頼ることに注意してください。ここでは、Jenkins X 3 でのクラウドインフラの設定と Secret 管理のための推奨事項を簡単に説明します。

-  __クラウドインフラストラクチャ__ - Jenkins X では、Kubernetes クラスタ、ストレージ、ネットワーク、DNS、IAM バインディング、これらすべてをクラウドリソースと呼んでいます。Jenkins X 3.x alpha 用のクラウドリソースの作成と管理には、Terraform、またはオプションで Terrafrom Cloud を使用することをお勧めします。クラウドインフラストラクチャのセットアップを支援するために、クイックスタートとガイドを作成しました。

- __Secret 管理__ - Jenkins X　では，いくつかの Secret が必要であり，その中には生成されたものもあれば，インストール時にユーザが提供するものもあります。これらは管理する必要があり、それを支援するソリューションが多数存在します。Jenkins X は、可能な限りマネージドクラウドサービスを利用することを好みます。[Google Secrets manager](https://cloud.google.com/secret-manager) が良い例で、Secret はクラスタの外に保存され、[external secrets](https://github.com/godaddy/kubernetes-external-secrets)を使ってクラスタ内で同期されます。マネージドクラウドサービスが利用できない、または利用したくない場合は、Jenkins X でも Vault を利用することができます。

Jenkins X 3.x をインストールする際に簡単に始められるGitHub リポジトリのテンプレートである[多数のクイックスタートの git リポジトリ](https://github.com/jx3-gitops-repositories)を用意しています。
