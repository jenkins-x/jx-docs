---
title: "プロジェクトの作成"
date: 2017-01-05
weight: 30
description: >
  プラットフォームのセットアップが完了したので、最初のプロジェクトを作成してみましょう。
---

プロジェクトを作成したりインポートしたりするには、[jx 3.x バイナリ](/docs/v3/guides/jx3/)を取得して `$PATH` に置く必要があります。


## クイックスタートから新規プロジェクトを作成する

クイックスタートテンプレートから新しいプロジェクトを作成するには、[jx project quickstart](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_quickstart.md) コマンドを使用します。

```bash 
jx project quickstart
``` 

古い Jenkins X 2.x のエイリアス `jx quickstart` はまだサポートされていますが、最終的には非推奨になることに注意してください。

詳細については、[クイックスタートのドキュメント](/docs/create-project/creating/) を参照してください。

## 既存のプロジェクトをインポートする

クイックスタートテンプレートから新しいプロジェクトを作成するには、[jx project import](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project_import.md) コマンドを使用します。

```bash 
jx project import
```        

詳細は [インポートのドキュメント](/docs/create-project/creating/import/) を参照してください。

古い Jenkins X 2.x のエイリアス `jx import` はまだサポートされていますが、最終的には非推奨になることに注意してください。

### Jenkinfiles でプロジェクトをインポートする

Jenkins X 3.x には、Jenkins と Tekton を Jenkins X で組み合わせようとしている場合に、[Jenkins ファイルのインポートを扱うための新しいサポート](jenkinsfile) が含まれていることに注意してください。


## トップレベルのウィザード

これにより、上記のすべてのオプションが [jx project](https://github.com/jenkins-x/jx-project/blob/master/docs/cmd/project.md) を通じてインタラクティブなウィザードで利用できるようになります。


## 改善点

2.x 版の [jx import](https://jenkins-x.io/commands/jx_import/) コマンドよりも多くの改善を行いました。

* Jenkins X にインポートする際には、kubernetes ネイティブアプリケーションに加えて、Java ライブラリや Node モジュールを簡単にインポートできるように、どちらのビルドパックを使用するか (例: classic か kubernetes か) を尋ねています
* 検出されると、ウィザードはパック名 (言語) の入力を求めてきます。通常は、パック名の検出で十分です。例: `maven` を検出していますが、パックのバージョンを変更したい場合があります (例: `maven-java11`)
* プロジェクトをインポートする際に、Jenkins XとJenkinsを同じクラスタで使用している場合、プロジェクトを [Jenkins X](https://jenkins-x.io/) にインポートするか、どちらの Jenkins サーバを使用するかを聞かれます
* [リモートの Jenkins サーバ](/docs/v3/guides/jenkins/)へのプロジェクトのインポートには 2 つのモードをサポートしています
  * マルチブランチプロジェクトを使用し、Jenkins がウェブフックを処理する通常の Jenkins インポート
  * ChatOps モード: [lighthouse](https://github.com/jenkins-x/lighthouse) を使用して webhook と ChatOps を処理し、トリガーが発生すると Jenkins サーバ内の通常のパイプラインをトリガーします
* リポジトリに `Jenkinsfile` が含まれており、Jenkins サーバにインポートすることを選択した場合、ビルドパックを実行して `Dockerfile`, helm チャート, `jenkins-x.yml` を生成することはありません


## 2.x からの変更点

[Jenkins X](https://jenkins-x.io/) を知っていて、以前に [jx import](https://jenkins-x.io/commands/jx_import/) を使ったことがある人にとっては、新しいプロジェクトのウィザードが少し変わっています。

* コマンドが少し違います

  * `jx create import`  は `jx project import` になりました
  * `jx create quickstart` は `jx project quickstart` になりました
  * `jx create project` は `jx project` になりました
  * `jx create spring` は `jx project spring` になりました
