---
title: 設定
linktitle: 設定
description: 設定を変更する
weight: 80
---


先ほどのステップで作成した `dev` 環境用の git リポジトリにある `jx-requirements.yml` ファイルを編集して、さまざまな機能を設定することができます。

以下のヘルプを使って設定を変更するか、Next を実行して boot を実行してください。

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../secrets">Previous</a></li>
  </ul>
</nav>

## Secret

Boot は現在、Secret を管理するための以下のオプションをサポートしています。

### ローカルストレージ

これがデフォルトであるか、`secretStorage: local` で明示的に設定することができます。

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: local
webhook: lighthouse
```

これを有効にすると、Secret は `~/.jx/localSecrets/$clusterName` というフォルダに読み込まれ、保存されます。`JX_HOME` で `~/.jx` の場所を変更することができます。

### Vault

これは、GKE や EKS プロバイダを使用する場合に推奨されるアプローチです。これは `secretStorage: vault` で明示的に設定することができます。

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: vault
webhook: lighthouse
```

この設定は、`jx boot` のパイプラインが KMS を使って Vault をインストールし、Secret を読み込み/保存するためのクラウドストレージバケットをインストールします。

Vault の大きな利点は、チームで同じクラスタ上で `jx boot` を簡単に実行できることです。誤って Kubernetes クラスタを削除してしまった場合でも、KMS + クラウドバケットから簡単に復元できます。


### Google Secret Manager 

これは `secretStorage: gsm` で明示的に設定することができます。

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
secretStorage: gsm
webhook: lighthouse
```

## Git

Jenkins X は多くの異なる Git プロバイダをサポートしています。`jx-requirements.yml` の中で、環境ごとに使用したい Git プロバイダーと Git プロバイダーに使用する組織を指定することができます。

### GitHub

これは、指定しなかった場合のデフォルトの Git プロバイダです。

```yaml
cluster:
  environmentGitOwner: myorg
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: lighthouse
```

### GitHub Enterprise

設定は上記と似ていますが、`gitServer` の URL (https://github.com と異なる場合) と `gitKind: github` の URL を指定する必要があります。

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: github
  gitName: ghe
  gitServer: https://github.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Server

これには、`gitServer` と `gitKind: bitbucketserver` の URL を指定します。[Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) を [Tekton](https://tekton.dev/) と一緒に使いたい場合

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketserver
  gitName: bs
  gitServer: https://bitbucket.myserver.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### Bitbucket Cloud

これには `gitKind: bitbucketcloud `を指定します。[Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) を [Tekton](https://tekton.dev/) と一緒に使いたい場合には

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: bitbucketcloud
  gitName: bc
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

### GitLab

これには、`gitServer` と `gitKind: gitlab` の URL を指定します。[Serverless Jenkins X Pipelines](/about/concepts/jenkins-x-pipelines/) を [Tekton](https://tekton.dev/) と一緒に使いたい場合には

```yaml
cluster:
  provider: gke
  environmentGitOwner: myorg
  gitKind: gitlab
  gitName: gl
  gitServer: https://gitlab.com
environments:
  - key: dev
  - key: staging
  - key: production
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: true
    url: "gs://jx-logs"
  reports:
    enabled: true
    url: "gs://jx-logs"
  repository:
    enabled: true
    url: "gs://jx-logs"
webhook: lighthouse
```

## リポジトリ

Jenkins X では、さまざまなアーティファクトリポジトリを設定することができます。私たちは以下のようにアーティファクトリポジトリを使用します。

* ある種のビルドからの成果物を保存します (例: Java のビルドでは、jar、`pom.xml` ファイル、tarball をデプロイする傾向があります)
* java/maven ビルドを使用する際に maven の依存関係をキャッシュするための Maven プロキシとして動作します
* Helm チャートを公開するためのチャートリポジトリを実装します

### Nexus

デフォルトでは、明示的な設定を行わない場合は Jenkins X が使用されます。

* アーティファクト (例: Java jar、`pom.xml` ファイル、tarball、npm モジュールなど) を保存するためのアーティファクトリポジトリとして [Nexus](https://www.sonatype.com/nexus-repository-oss) を使用します
* チャートのリポジトリとして [ChartMuseum](https://chartmuseum.com/)

以下の `jx-requirements.yml` ファイルを使って明示的に nexus を設定することができます。

```yaml
repository: nexus
```

### Bucketrepo

[bucketrepo](https://github.com/jenkins-x/bucketrepo) のチャートは、可能な [Nexus](https://www.sonatype.com/nexus-repository-oss) と [Chartmusem](https://chartmuseum.com/) の両方の代替となるフットプリントの小さいマイクロサービスです。

* java/maven ビルドを使用する際に、maven の依存関係をキャッシュするための Maven プロキシとして動作します
* アーティファクトリポジトリとして機能します (例: mavenのアーティファクトをデプロイする)
* Helm チャートを公開するためのチャートリポジトリの実装

`bucketrepo` を有効にするには、以下の `jx-requirements.yml` ファイルを用いる。

```yaml
repository: bucketrepo
```

デフォルトでは、bucketrepo のローカルファイルシステムが成果物の保存に使われます。

`bucketrepo` のアーティファクトのクラウドストレージを有効にするには、`storage.rippory` の設定を有効にする必要がありますが、その場合はクラウドバケットが代わりに使われます。[ストレージのセクションの詳細](#storage) を参照してください。

### None

アーティファクトリポジトリ (nexus) を無効にしても、チャートに ChartMuseum を使用したい場合は、以下のようにします。

```yaml
repository: none
```

[ChartMuseum](https://chartmuseum.com/) はチャートのリポジトリとして使用されますが、アーティファクトリポジトリを使用しないと、Maven のアーティファクトをデプロイできないことに注意してください。

## ストレージ

[jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) ファイルは、ログ + レポートのために長期ストレージを使用するかどうかと、データを保存するために使用するクラウドストレージバケットを設定できます。

例えば、以下の `jx-requirements.yml` ファイルは長期保存を可能にします。

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: true
  reports:
    enabled: false
  repository:
    enabled: false
```

また、`storage` セクションでストレージバケットの URL を指定することもできます。以下の URL 構文がサポートされています。

* `gs://anotherBucket/mydir/something.txt` : GCP 上で GCS バケットを使用
* `s3://nameOfBucket/mydir/something.txt` : AWS 上で S3 バケットを使用
* `azblob://thatBucket/mydir/something.txt` : Azure バケットを使って
* `http://foo/bar` : HTTPS を使用していない Git リポジトリに保存されたファイル
* `https://foo/bar` : HTTPS を使用して Git リポジトリに保存されたファイル

例

```yaml
cluster:
  provider: gke
environments:
- key: dev
- key: staging
- key: production
kaniko: true
storage:
  logs:
    enabled: false
    url: gs://my-logs
  reports:
    enabled: false
    url: gs://my-logs
  repository:
    enabled: false
    url: gs://my-repo
```

{{< pageinfo >}}
**注E** GKE では、ノードプールは GCS バケットへの書き込みに追加の権限を必要とします。
詳細については、[GKE Storage Permissions](https://jenkins-x.io/docs/resources/guides/managing-jx/common-tasks/storage/#gke-storage-permissions)を参照してください。
{{< /pageinfo >}}
詳細は[ストレージガイド](https://jenkins-x.io/architecture/storage/)を参照してください。

## Ingress

Jenkins X をインストールする際には、Kubernetes で動作しているサービスやアプリケーションにアクセスするためにカスタムドメインを使用したいと思うのが一般的です。

[jx-requirements.yml](https://github.com/jenkins-x/jenkins-x-boot-config/blob/master/jx-requirements.yml) ファイルに何も指定しない場合、Boot はデフォルトで (HTTPS ではなく) HTTP を使用し、DNS メカニズムとして [nip.io](https://nip.io/) を使用します。

Boot を実行すると、`jx-requirements.yml` は次のようになります。

```yaml
cluster:
  provider: gke
  clusterName: my-cluster-name
  environmentGitOwner: my-git-org
  project: my-gke-project
  zone: europe-west1-d
environments:
- key: dev
- key: staging
- key: production
ingress:
  domain: 1.2.3.4.nip.io
  externalDNS: false
  tls:
    email: ""
    enabled: false
    production: false
kaniko: true
secretStorage: local
storage:
  logs:
    enabled: false
  reports:
    enabled: false
  repository:
    enabled: false
webhook: prow
```

### 外部 DNS を使用したカスタムドメイン

[external-dns](https://github.com/kubernetes-sigs/external-dns) という非常に便利なオープンソースプロジェクトがあります。これはクラウドプロバイダーが管理する独自の DNS サービスと統合して、自動的に DNS を有効にします。

ラボでは今のところ GKE で検証されていますが、近いうちにもっと多くの機能を実装したいと考えています。

#### Google Cloud 用の設定

新しいドメインを購入したい場合は、[Google Domains](https://domains.google.com/m/registrar/search)を使用すると簡単です。

<img src="/images/getting-started/googlednscreate.png" width="80%" float="left">

まず、Kubernetes クラスタが動作する GCP プロジェクトで [Google Cloud DNS](https://cloud.google.com/dns) を設定して、カスタムドメインを管理すると、4つのサーバのリストが返されます。

```bash
➜ jx create domain gke -d acame-trading.com

Please update your existing DNS managed servers to use the nameservers below
ns-cloud-e1.googledomains.com.
ns-cloud-e2.googledomains.com.
ns-cloud-e3.googledomains.com.
ns-cloud-e4.googledomains.com.
```

ここで、[Google Cloud DNS](https://cloud.google.com/dns) がドメインを管理できるように、DNS　プロバイダを更新します。ここでは [Google Domains](https://domains.google.com/m/registrar/search) を使った例を紹介します。

<img src="/images/getting-started/googlednsconfigure.png" width="80%" float="left">

次に `jx-requirements.yml` を編集してドメインを追加します。

__注__ GKE で jx を使用している場合、`externalDNS:` の値は無視され、非推奨となります。このフラグはクラウドリソースを作成するために使われていましたが、現在はブートプロセスの外に移動されています。

```yaml
ingress:
  domain: my.domain.com
```

環境リポジトリの `helmfile.yaml` を編集し、外部の DNS チャートを追加します。

```yaml
apps:
- name: bitnami/external-dns
```

これを各環境の git リポジトリで繰り返すことを忘れないようにしましょう。ここですべての外部 DNS の手順を繰り返すことで、環境ごとに異なるドメインを使用することもできます。

__注__ 初めて外部 DNS を有効にしたり、新しいアプリケーションを環境にデプロイしたりするときは、各 URL の DNS が伝搬するまでに数分かかることがありますので、気長にお待ちください。


### 自動化された TLS

また、`ingress.tls.enabled = true` で TLS を有効にするように設定を更新することもできます。以下に例を示します。

```yaml
cluster:
  clusterName: mycluster
  environmentGitOwner: myorg
  gitKind: github
  gitName: github
  gitServer: https://github.com
  namespace: jx
  provider: gke
  vaultName: jx-vault-myname
environments:
- key: dev
- key: staging
- key: production
gitops: true
ingress:
  domain: my.domain.com
  externalDNS: false
  namespaceSubDomain: -jx.
  tls:
    email: someone@acme.com
    enabled: true
    production: true
kaniko: true
secretStorage: vault
storage:
  logs:
    enabled: true
    url: gs://jx-prod-logs
  reports:
    enabled: false
    url: ""
  repository:
    enabled: false
    url: ""
webhook: prow
```

### リカバリー

何か問題 (クラスタ、名前空間、Tekton が削除されたなど)  が発生してインストールがうまくいかず、Tekton パイプラインを実行できなくなった場合は、ラップトップで [jx boot](/docs/getting-started/setup/boot/) を再実行してクラスタを復元することができます。

## バックアップ

Jenkins X は [Velero](https://velero.io) と統合されており、Jenkins X の状態 (Kubernetes やカスタムリソースとともに永続ボリューム) のバックアップをサポートしています。

Velero を有効にするには、`jx-requirements.yml` に以下を追加します。

```yaml
storage:
  backup:
    enabled: true
    url: gs://my-backup-bucket
velero:
  namespace: velero
```

クラウドプロバイダのバケット URL を使用します。詳細については、[ストレージガイド](/docs/resources/guides/managing-jx/common-tasks/storage/)を参照してください。

## ユーザーインターフェース

UI をお探しなら、[Jenkins X 用のオープンソース Web UI である Octant](/docs/reference/components/ui/)をチェックしてください。
