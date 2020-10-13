---
title: 比較
linktitle: 比較
description: Jenkins X バージョン 3.x と 2.x の比較
weight: 90
---


このドキュメントでは、Jenkins X 2.x で helm 2 を使った `jx boot` を知っている人のために、3.x のアプローチの類似点と相違点を概説しています。

## 2.x と 3.x の類似点

[jenkins-x-boot-config](https://github.com/jenkins-x/jenkins-x-boot-config/) git リポジトリを使った古典的なブートのように、この新しい [helmfile](https://github.com/roboll/helmfile) ソリューションはサポートしています。

* GitOps 経由で Jenkins X をインストールしてアップグレードすることができます
* インターネットやローカルチャート、Jenkins X で構築されたチャートをどのような環境でも再利用することができます
* YAML ファイルはインストール/アップグレード中に適用されるすべてのチャートを保存するために使用されます

## 3.x との違い

* [helm 3](https://helm.sh/), [helmfile](https://github.com/roboll/helmfile), [kustomize](https://kustomize.io/) および/または [kpt](https://googlecontainertools.github.io/kpt/) などのツールを組み合わせて kubernetes リソースを作成することをサポートしています
* 3.x では、Jenkins X のインストール/アップグレードは開発者のラップトップではなく、`Job` を介して kubernetes クラスタ内で実行され、一貫性とセキュリティをサポートしています
* 3.x では、クラスタごとにひとつの git リポジトリを使用しています。これは、クラスタ内で好きなだけ多くのチームや名前空間を管理することができます
  * 3.x では、同じ kubernetes クラスタに存在する `Staging` のようなローカル環境はすべて同じ git リポジトリで定義されています。2.x では、同じクラスタを共有しているときは `Dev`, `Staging`, `Production` 用に別の git リポジトリを使用していました
  * もし `Dev`, `Preprod`, `Production` 環境が別々の kubernetes クラスタにある場合は、それぞれに git リポジトリを持つことになります
* Helm チャートはどの名前空間でもデプロイできます (以前は [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml) にあるすべてのチャートに単一の名前空間を使用していました)
* [env/requirements.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/requirements.yaml) を使う代わりに、シンプルでより強力な [helmfile.yaml](https://github.com/jenkins-x-labs/boot-helmfile-poc/blob/master/helmfile.yaml) ファイルを使うようになりました
  * どのようなチャートでも `namespace` を指定することができます
  * チャートで使用するための `values` ファイルを追加して、helm の `values.yaml` ファイルを上書きすることができます
* `env/$appName/values*.yaml` ファイルをたくさんコピーする代わりに、[lighthouse/values.tmpl.yaml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/lighthouse/values.tmpl.yaml) のような[フォルダ](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/env/)にあるようなブートコンフィグにコピーするのではなく、これらのファイルをすべて [apps/jenkins-x/lighthouse](https://github.com/jenkins-x/jxr-versions/tree/master/apps/jenkins-x/lighthouse) にあるバージョンストリームからデフォルトでコピーすることができます。つまり、ブート設定の git リポジトリがずっとシンプルになり、バージョンストリームでより多くの設定を共有できるようになり、git のマージ/リベースの問題をたくさん回避できるようになりました。
* GitOps リポジトリにアプリを追加したり削除したりすると、それらのリソースが適切にインストールされたりアンインストールされたりします
  * プルリクエストでどのような kubernetes リソースが変更されるかを正確に確認することもできます
* `env/Chart.yaml` のために複合チャートを使わず、代わりに各チャートを独立して配置するようになりました
  * これはそれぞれのチャートには、`helmfile.yaml` ファイルで確認可能な固有のバージョン番号があるということを意味します
* `jenkins-x-platform` (`jenkins` + `chartmuseum` + `nexus` などのような[依存関係](https://github.com/jenkins-x/jenkins-x-platform/blob/master/jenkins-x-platform/requirements.yaml)のログを含む複合チャート) の複雑さを取り除き、それぞれのチャートを独立して追加/削除したり、異なるバージョン/ディストリビューションとスワップアウトできるようにしました
