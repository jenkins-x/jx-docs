---
title: Jenkinsfile のサポート
linktitle: Jenkinsfile のサポート
description: 3.x が Jenkinsfiles のインポートをどのように処理するか
weight: 30
---


プロジェクトをインポートするとき、`jx project import` はソースコードの中にある `Jenkinfile` を探します。

`Jenkinsfile` がない場合、ウィザードは Tekton をベースにした [Jenkins X Pipeline](https://jenkins-x.io/about/concepts/jenkins-x-pipelines/) を使用したいと仮定し、通常の Jenkins X の方法でそれをインポートします。また、自動化された CI/CD に使用したいビルドパックと言語の種類を確認することができます。ライブラリ、バイナリ、コンテナイメージ、Helm チャート、完全なマイクロサービスなど、どんなワークロードも簡単にインポートできます。

`Jenkinsfile` が存在する場合、ウィザードはパイプラインの実行に[リモートの Jenkins サーバ](/docs/v3/guides/jenkins/) または [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) を使用することを想定しているので、利用可能な Jenkins オプションのリストを表示して選択します。

Jenkins サーバを使用する場合、2つのオプションがあります。

* `Multi Branch Project` を経由してバニラの Jenkins パイプラインを使用して Webhook の処理を行い、パイプラインを実行します
* プルリクエストの webhook 処理と ChatOps には [lighthouse](https://github.com/jenkins-x/lighthouse) を使用します。そして、パイプラインがトリガーされたときには、特定の Jenkins サーバ内でリモートでパイプラインを実行するためのステップとして、[trigger-pipeline](https://github.com/jenkins-x-labs/trigger-pipeline)を使用します(`Multi Branch Project` を使用せずに)

### サポートされているインテグレーション

プロジェクトをインポートする際には、これらのアプローチがサポートされています。

* Tekton を使用した [Jenkins X パイプライン](https://jenkins-x.io/about/concepts/jenkins-x-pipelines/)
* `Multi Branch Project` を経由した Jenkins パイプライン
* [lighthouse](https://github.com/jenkins-x/lighthouse) for ChatOps は、(`Multi Branch Project` を使用せずに) リモートの Jenkins パイプラインをトリガーパイプライン経由でトリガーします
* Tekton の [Jenkinsfile Runner](https://github.com/jenkinsci/jenkinsfile-runner) ベースのパイプライン。インポート時にパイプラインに使用するコンテナイメージを上書きするには、`--jenkinsfilerunner myimage:1.2.3` コマンドライン引数を使用します
