---
title: jx 3.x alpha の取得
linktitle: jx 3.x alpha の取得
type: docs
description: jx 3.x alpha のダウンロード方法
weight: 1
---

Jenkins X の 3.x Alpha を試すには、`jx` バイナリの 3.x バージョンが必要です。

`jx` の 3.x はここからダウンロードできます: https://github.com/jenkins-x/jx-cli/releases

これは基本的には、通常の 2.x バージョンの `jx` の代替としてドロップインするものです。

メモ:
* 主な開発は GitHub と Google Container Engine (GKE) を使用していますが、OSS の貢献は他のプラットフォームを使用した検証や問題の修正に役立っています。

## jx 3.x のビルド方法

3.x で Jenkins X の改善点を作るために、マイクロサービスのアプローチを試みています。

私たちは Jenkins X の 2.x を安定的に維持しようとしていますが、3.x を迅速に革新できる場を提供しています。

3.x 用のメインの `jx` CLI ツールは [jenkins-x/jx-cli](https://github.com/jenkins-x/jx-cli) で定義されています。これは多くの個別の [プラグインバイナリ](https://github.com/jenkins-x/jx-cli#plugins), [コンポーネント](https://github.com/jenkins-x/jx-cli#components), [ライブラリ](https://github.com/jenkins-x/jx-cli#libraries) を使用した小さなコアで、2.x に触れることなく、技術的な負債を取り除きながら、3.x の改善、コードのリファクタリング、品質の向上、コードカバレッジの向上をより速く行うことができます。
