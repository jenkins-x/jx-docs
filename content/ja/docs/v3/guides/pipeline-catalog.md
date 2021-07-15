---
title: パイプラインカタログ
linktitle: パイプラインカタログ
description: Tekton との統合性を高めるパイプラインカタログ
weight: 105
---

[Tekton Catalog enhancement proposal](https://github.com/jenkins-x/enhancements/issues/37) の一環として、Jenkins X の Tekton のサポートを改善し、以下のことができるようになりました。

  * `.ligthhouse/jenkins-x` フォルダ内の `PipelineRun` ファイルを修正するだけで、簡単に[任意の git リポジトリ内の任意のパイプラインを編集](/docs/v3/guides/pipeline-catalog/#editing-pipelines)することができます
  * [新しいパイプラインを任意の git リポジトリに追加する](/docs/v3/guides/pipeline-catalog/#add-new-pipelines) 方法を使って、[tekton catalog](https://github.com/tektoncd/catalog) のような場所で見つけた `PipelineRun` ファイルをあなたのリポジトリに再利用します

## ソースの変更

[クラスタを最新のバージョンストリームにアップグレード](/docs/v3/guides/upgrade/#cluster)すると、[新しいクイックスタートを作成](/docs/v3/create-project/#create-a-new-project-from-a-quickstart)できるのがわかります。

* `.lighthouse/jenkins-x` ディレクトリには、これらのファイルを含む Jenkins X 用のデフォルトの CI/CD パイプラインが含まれています
  * `triggers.yaml` は、[lighthouse](https://github.com/jenkins-x/lighthouse) の `presubmits` と `postsubmits` (つまり Pull Request パイプラインとリリース) を定義するためのものです
  * `pullrequest.yaml` は、Tekton の `PipelineRun` を使用したプルリクエスト・パイプラインを定義します
  * `release.yaml` は、Tekton の `PipelineRun` を使ってリリースパイプラインを定義します
  
* 新しいクイックスタートでは、`jenkins-x.yml` ファイルはデフォルトでは使用されなくなりました。`jenkins-x.yml` ファイルを使用しているプロジェクトがある場合は、[v3 にインポート](/docs/v3/create-project/#import-an-existing-project)を実行すれば、まだサポートされます


## パイプラインの編集

これで、git リポジトリ内の `PipelineRun` リソースを簡単に変更できるようになりました。`.lighthouse` フォルダを探して、各サブフォルダの YAML ファイルを編集します。

例えば、デフォルトの Jenkins X CI/CD パイプラインの場合は、どちらかを編集します。

* `.lighthouse/jenkins-x`
  * プルリクエストパイプラインを編集するために `pullrequest.yaml` を使用します
  * リリースパイプラインを編集するために `release.yaml` を使用します

プルリクエストパイプラインへの変更をプルリクエストで提出することで、プルリクエストパイプラインへの変更をテストすることができます。リリースへの変更は、変更をメインブランチにマージした後にのみ行われます。

## 新しいパイプラインの追加

いつでも新しいパイプラインを `.lighthouse` 内の新しいフォルダに追加して、[tekton catalog](https://github.com/tektoncd/catalog) のような場所で見つけた Tekton の `PipelineRun` ファイルを再利用したり、手書きの `PipelineRun` リソースを追加したりすることができます。

[lighthouse](https://github.com/jenkins-x/lighthouse) が `presubmit` (例：Pull Requests) や `postsubmits` (例：メインブランチでのリリース) でパイプラインを開始するように _trigger_ を設定するには、lighthouse の設定ファイルフォーマットを使用する `triggers.yaml` ファイルを追加する必要があります。

デフォルトの `.lighthouse/jenkins-x` ディレクトリを参照して、これらがどのように動作するかを確認することができます。`triggers.yaml` ファイルは、`presubmits:` または `postsubmits:` エントリ内の `source:` 属性を介して、Tekton の `PipelineRun` ファイルを参照します。
  
## トリガーの変更

`.lighthouse/*/triggers.yaml` ファイルを変更して、`presubmits:` や `postsubmits:` エントリを変更して、以下のようなことを行うことができます。

* `presubmits` に `rerun_command` や `trigger` ChatOps のコメントをカスタマイズします
* `postsubmit` トリガの `branches` パターンを設定します
* 新しいパイプライン用の新しいエントリを追加したり、異なる `pipeline_run_params` エントリを持つパイプラインで既存の `PipelineRun` ファイルのパラメータを異なるものにしたりします
  
## パイプラインと Helm チャートのアップグレード

どの git リポジトリでも、[クラスタの git リポジトリ](/docs/v3/guides/upgrade/#cluster)をアップグレードするのと同じように、リポジトリの git チェックアウトの中で [jx gitops upgrade](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_update.md) コマンドを実行することでアップグレードすることができます。

```bash
cd my-quickstart-thingy
jx gitops upgrade
```              

このコマンドを実行すると、git リポジトリで使用しているすべての helm チャートやパイプラインカタログが最新バージョンにアップグレードされます。

このコマンドを実行すると、通常は `git` の中にいくつかの変更点を確認することができます。変更内容に満足したら、それらの変更をコミットして Pull Request を作成し、クラスタに適用できるようにします。

```bash
git add *
git commit -a -m "fix: upgrade pipeline catalog"
git push
```               

マージの競合が発生する可能性があります。 

インラインの git ヘルパーメッセージを見てコンフリクトを解決することもできますし、IDE を使ってマージの問題をより簡単に解決することもできます。
