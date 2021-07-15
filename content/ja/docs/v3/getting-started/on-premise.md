---
title: オンプレミス
linktitle:  オンプレミス
description: バニラ Kubernetes に Jenkins X を設定する
date: 2017-02-01
publishdate: 2017-02-01
lastmod: 2020-02-21
weight: 120
---

## オンプレミス Kubernetes

kubernetes を使用している場合は、[Amazon](/docs/v3/getting-started/eks/) や [Google](/docs/v3/getting-started/gke/) のようなマネージドクラウドプロバイダーを使用することを強くお勧めします。

* コンテナレジストリとバケットストレージ
* IAM とワークロードのアイデンティティ (例: kubernetes サービスアカウントにロールを割り当てて、特定のバケットやコンテナレジストリへの読み書きができるようにする) 

しかし、時には kubernetes を自分のオンプレミスで運用しなければならないこともあるでしょう。長期的には、クラウドプロバイダーのマネージド kubernetes と関連インフラを自分のオンプレミスでも実行できるようにして、同じストレージと IAM をどこでも再利用できるようにしたいと考えています。しかし、それまでの間は、このガイドはバニラの kubernetes クラスタに Jenkins X をインストールすることを目的としています。

### 前提条件

以下は、オンプレミスの kubernetes クラスタの前提条件です。

#### kubectl アクセス

[kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 経由で kubernetes クラスタに接続できるようにする必要があります。
次のようなコマンドを実行できるようにします。

```bash 
kubectl get ns
kubectl get node
```

名前空間とノードをそれぞれ表示します。
 
#### Ingress

Jenkins X を使用するためには、Ingress が動作する必要があります。これは、kubernetes のサービスにネットワーク接続するために kubernetes の外部で解決できるドメイン名を持つkubernetes `Ingress` リソースを作成できることを意味します。

Jenkins X は、Ingress を実装するために `LoadBalancer` kubernetes `Service` を持つ `nginx` をインストールします。しかし、基礎となる kubernetes プラットフォームは、負荷分散ネットワークとインフラストラクチャを実装する必要があります。これは一般的に、すべてのパブリッククラウドで必要となっています。
 
オンプレミスの kubernetes クラスタでは、[MetalLB](https://metallb.universe.tf/) のようなものをインストールする必要があります。

#### ストレージ

Helm チャートの `PersistentVolumeClaim` リソースが `PersistentVolume` リソースに解決されるように、kubernetes クラスタがデフォルトの[ストレージクラス](https://kubernetes.io/docs/concepts/storage/storage-classes/)を持っている必要があるので、永続ディスクを使用できるようにします。


### はじめに

これは、オンプレミスの kubernetes のために現在推奨されているクイックスタートです。

*  <a href="https://github.com/jx3-gitops-repositories/jx3-kubernetes/generate" target="github" class="btn bg-primary text-light">Git リポジトリの作成</a> 

* 以下の [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) コマンドを実行できるように、クラスタに接続されていることを確認してください

```bash 
kubectl get ns
kubectl get node      
```        

*  git clone した git リポジトリの中から、次のようにして <a href="/docs/v3/guides/operator/" 
    target="github" class="btn bg-primary text-light" 
    title="クラスタにJenkins Xをセットアップするための git オペレータをインストールします。">
    git オペレータをインストールします。
  </a>

```bash 
git clone https://github.com/myuser/mygitops-repo.git myrepo
cd myrepo
jx admin operator    
```  

*  <a href="/docs/v3/create-project/" class="btn bg-primary text-light">プロジェクトの作成またはインポート</a> 
