---
title: アプリ
linktitle: アプリ
description: アプリでの作業
weight: 100
---


Jenkins X 3.x は、インストールしたい [Helm](https://helm.sh/) [chart](https://helm.sh/docs/topics/charts/) とその名前空間を定義するために使用できる [helmfile project](https://github.com/roboll/helmfile) の` helmfile.yaml` ファイル形式をサポートしています。


### チャートの追加

次に、`releases:` セクションの `helmfile.yaml` ファイルに、以下のように任意のチャートを追加することができます。

```yaml
releases:
- chart: jetstack/cert-manager 
- chart: flagger/flagger
``` 

チャートの `namespace` と `version` プロパティは、デプロイ時に[バージョンストリーム](https://jenkins-x.io/about/concepts/version-stream/)を介して解決されますが、明示的に指定することもできます。


チャート名の接頭辞はチャートリポジトリ名になります。すでにいくつかのチャートリポジトリ名が `helmfile.yaml` の `repositories:` セクションに定義されています。必要な数のチャートリポジトリを `helmfile.yaml` に追加することができます。

私たちは一貫性を高め、`helmfile.yaml` ファイルの中でチャートリポジトリのために標準的な名前を使用しようとしています。デフォルトの[このファイルに含まれるチャートリポジトリ名と URL](https://github.com/jenkins-x/jxr-versions/blob/master/charts/repositories.yml) を見ることができます。お好きな名前や URL を自由に使ってください。

#### CLI を使用する

シンプルな CLI コマンド [jx gitops helmfile add](https://github.com/jenkins-x/jx-gitops/blob/master/docs/cmd/jx-gitops_helmfile_add.md) もありますが、チャートを `helmfile.yaml` に追加するのも簡単です。

### リソースの追加

helm チャートとしてパッケージ化されていない kubernetes リソースを作成したい場合は、_local chart_ レイアウトを使って簡単にクラスタの git リポジトリに追加することができます。

* `charts/myname/templates` という名前のディレクトリを作成します
* 必要な kubernetes リソースを `charts/myname/templates/myresource.yaml` に追加します
  * 拡張子が `.yaml` であることを確認します
 * `charts/myname/Chart.yaml` ファイルを作成し、[この例では Chart.yaml](https://github.com/cdfoundation/tekton-helm-chart/blob/master/charts/tekton-pipeline/Chart.yaml) のようにデフォルトのヘルメットのメタデータを入力します
* これで、`helmfile.yaml` ファイルの `releases:` セクションで `charts/myname` ディレクトリを参照するようになりました...

```yaml 
releases:
- chart: ./charts/myname
```  

Pull Request を作成します。効果的な kubernetes リソースが Pull Request 上にコミットとして表示されているのがわかるはずです。
 
### チャートのカスタマイズ

カスタムの `values.yaml` ファイルを任意のチャートに追加し、`helmfile.yaml` ファイルの `values:` セクションで参照することができます。

例えば、`nginx-ingress` のようなチャートをカスタマイズするには、`charts/nginx-ingress/values.yaml` にファイルを作成します。そして、そのファイルを `helmfile.yaml` ファイルで参照することができます。

```yaml 
releases:
...
- chart: stable/nginx-ingress
  version: 1.39.1
  name: nginx-ingress
  namespace: nginx
  values:
  - versionStream/charts/stable/nginx-ingress/values.yaml.gotmpl
  - charts/nginx-ingress/values.yaml
```  

上記の例では、自動的に追加されるバージョンストリームの設定の後に `charts/nginx-ingress/values.yaml` を追加しています。

  
また、Value ファイルのテンプレートを使いたい場合は、`values.yaml.getmpl` というファイルを使うこともできます。例えば、`{{ .Values.jxRequirements.ingress.domain }}` のような式を使って、`jx-requirements.yml` ファイルからプロパティを参照することができます。

アクションの例を見るには、[バージョンストリーム](https://jenkins-x.io/about/concepts/version-stream/)の [chartes/jenkins-x/tekton/values.yaml.getmpl](https://github.com/jenkins-x/jxr-versions/blob/master/charts/jenkins-x/tekton/values.yaml.gotmpl) ファイルをチェックしてください。

多くのアプリはすでに [バージョンストリーム](https://jenkins-x.io/about/concepts/version-stream/) で `jx-requirements.yml` の設定を利用するように設定されていることに注意してください - しかし、あなた自身のカスタム設定を自由に追加することができます。


### バージョンストリームフォルダ

クラスタの git リポジトリの中に `versionStream` というフォルダがあることに気づいたかもしれません。[バージョンストリーム](/about/concepts/version-stream/) は、以下のような共有設定を提供するために使用されます。

* チャート、イメージ、git リポジトリの検証済みバージョン
* チャートのデフォルトの名前空間と設定

これは、クラスタや git リポジトリ間で正規のファイルやメタデータを共有できることを意味します。


#### バージョンストリームの同期を維持する

[クラスタのアップグレード](/docs/v3/guides/upgrade/#cluster)を行うと、ローカルの `versionStream` フォルダが最新のアップストリームのバージョンストリームの内容にアップグレードされます。

チャートをカスタマイズする方法は上記で説明しました。カスタマイズした内容が上書きされたり、上流の [バージョンストリーム](/about/concepts/version-stream/) の変更とマージコンフリクトを起こしたりするリスクを避けるために、できるだけ多くのカスタマイズを `versionStream` フォルダの外に置いておいてください。

ローカルの `helmfile.yaml` や `charts` フォルダ内の変更は [アップグレードメカニズム](/docs/v3/guides/upgrade/#cluster) によって除外されるので、全く安全です。
