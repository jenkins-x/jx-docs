---
title: オペレータのインストール
linktitle: オペレータのインストール
description: Jenkins X をインストール/アップグレードするための Git オペレータのインストール
weight: 30
---

Jenkins X 3.x は [git オペレータ](https://github.com/jenkins-x/jx-git-operator) を使用して、Jenkins X やその他のコンポーネントのインストール+アップグレードをあらゆる環境で管理しています。興味のある方は [how it works](/docs/v3/about/how-it-works/) を読んでみてください。

## Git のユーザーとトークン

[git オペレータ](https://github.com/jenkins-x/jx-git-operator) をインストールするには、git リポジトリ用のパイプラインユーザーとトークンが必要です。


このユーザーとトークンは、インストール設定を含む git リポジトリへの読み書きのアクセス権を必要とします。理想的には、トークンはリポジトリ上に webhook を作成できる権限も持っていなければなりません (誰かが git リポジトリ上で Pull Request を作成したときに CI/CD パイプラインを起動するため)。

git リポジトリが [作成またはインポート](/docs/v3/create-project/) されたときや [lighthouse](https://github.com/jenkins-x/lighthouse) フックエンドポイントのドメイン名が変更されたときに [jx verify webhooks](https://github.com/jenkins-x/jx-verify/blob/master/docs/cmd/jx-verify_webhooks.md) コマンドを使って、いつでも自分の手で webhook を設定することができます。しかし、Jenkins X が CI/CD パイプラインの一部としてこれを自動化してくれるようにすれば、もっと簡単になります。

同じパイプラインのユーザーとトークンは、デフォルトでは [作成またはインポートされたすべてのリポジトリ](/docs/v3/creat-project/) 上のすべてのパイプラインで再利用されます。もし本当に必要ならば、後で [パイプライントークンの編集](/docs/v3/guides/secrets/#edit-secrets) で変更することができます。


## オペレータのインストール

先に作成した[git repository](/docs/v3/getting-started/) の git クローンの中で、[jx admin operator](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_operator.md) コマンドを実行します。

```bash 
jx admin operator
```

[git リポジトリ](/docs/v3/getting-started/) の git クローンの中にいない場合は、git URL に `--url` パラメータを指定する必要があります。

```bash 
jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git
```

git のユーザー名とトークンがわかっている場合は、コマンドラインでそれを渡すこともできます。

```bash 
jx admin operator --url=https://github.com/myorg/env-mycluster-dev.git --username mygituser --token mygittoken
```

このコマンドは、Jenkins X をインストールするためのジョブをトリガーする [git オペレータ](https://github.com/jenkins-x/jx-git-operator) をインストールするために helm を使用します (そして、git リポジトリにコミットするたびにジョブを再トリガーします)。

ターミナルには、ブート `Job` が実行されるとログが表示されます。

いつでも [jx admin log](https://github.com/jenkins-x/jx-admin/blob/master/docs/cmd/jx-admin_log.md) コマンドでブートジョブのログを表示することができます。

```bash 
jx admin log
```

これで Jenkins X は自分自身をインストールします。

必要であれば、`ExternalSecret` カスタムリソースが作成されたら、[secrets](/docs/v3/guides/secrets/) を埋めればよいでしょう。

<nav>
  <ul class="pagination">
    <li class="page-item"><a class="page-link" href="../config">前へ</a></li>
    <li class="page-item"><a class="page-link" href="../secrets">次へ</a></li>
  </ul>
</nav>
