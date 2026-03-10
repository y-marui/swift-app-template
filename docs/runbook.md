# Runbook

## ローカルビルド・テスト

```bash
# セットアップ（初回のみ）
make bootstrap

# テスト実行
make test

# Lint
make lint

# フォーマット
make format
```

## Xcode プロジェクトのセットアップ（新規）

1. Xcode > File > New > Project で iOS App を作成
2. プロジェクト名・Bundle ID を設定し、このリポジトリのルートに保存
3. Xcode > File > Add Package Dependencies を開く
4. 「Add Local...」で `Packages/Core` を選択
5. App ターゲットに `Core` ライブラリを追加
6. `App/` フォルダ内のファイルをプロジェクトに追加
7. `make test` が通ることを確認

## 新しいフィーチャーの追加手順

```bash
FEATURE=MyFeature

mkdir -p Packages/Core/Sources/Core/Features/$FEATURE

cp templates/feature/View.swift.template \
   Packages/Core/Sources/Core/Features/$FEATURE/${FEATURE}View.swift

cp templates/feature/ViewModel.swift.template \
   Packages/Core/Sources/Core/Features/$FEATURE/${FEATURE}ViewModel.swift

cp templates/feature/UseCase.swift.template \
   Packages/Core/Sources/Core/Features/$FEATURE/${FEATURE}UseCase.swift
```

その後 `{{FeatureName}}` を実際のフィーチャー名に置換してください。

## リリースフロー

```
feature/xxx → develop → main → タグ付け
```

1. `feature/xxx` ブランチで開発
2. `develop` へ PR を出す（CI が通ることを確認）
3. リリース前に `develop` → `main` へ PR
4. `main` マージ後にタグを打つ

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## ホットフィックス手順

```bash
# main から hotfix ブランチを作成
git checkout main
git checkout -b hotfix/issue-description

# 修正・テスト
make test

# main と develop 両方にマージ
git checkout main && git merge hotfix/issue-description
git checkout develop && git merge hotfix/issue-description

# タグを打つ
git tag -a v1.0.1 -m "Hotfix v1.0.1"
git push origin main develop v1.0.1
```

## CI が失敗したとき

**Lint エラーの場合:**
```bash
make lint        # エラー内容を確認
make format      # 自動修正できるものを修正
make lint        # 再確認
```

**テスト失敗の場合:**
```bash
make test        # ローカルで再現確認
# 失敗しているテストファイルを特定して修正
swift test --filter TestClassName
```

**パッケージ解決エラーの場合:**
```bash
make clean
swift package resolve --package-path Packages/Core
make test
```
