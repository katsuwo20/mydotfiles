# Submodule 追加ガイド

このリポジトリでは、Neovim プラグインを `nvim/.config/nvim/pack/plugins/start/` 配下に
Git submodule として追加する運用です。

## 1. 事前確認

- いまの Neovim バージョンを確認する。
- 追加したいプラグインの README で required Neovim version を確認する。
- 互換性が怪しい場合は、`main` ではなく安定 branch/tag を選ぶ。

例:

```bash
nvim --version | head -n 2
git ls-remote --heads https://github.com/nvim-neo-tree/neo-tree.nvim.git
git ls-remote --tags https://github.com/nvim-neo-tree/neo-tree.nvim.git | tail -n 20
```

## 2. サブモジュール追加

1. リポジトリルートに移動する。
2. `pack/plugins/start` に submodule を追加する。
3. 必要なら branch/tag/commit を checkout して固定する。

```bash
cd /home/isono/ghq/github.com/katsuwo20/mydotfiles

git submodule add https://github.com/<owner>/<repo>.git \
  nvim/.config/nvim/pack/plugins/start/<plugin-dir>

cd nvim/.config/nvim/pack/plugins/start/<plugin-dir>
# 例: 安定ブランチに固定
# git checkout v2.x
# 例: タグに固定
# git checkout v1.2.3
# 例: コミットに固定
# git checkout <commit-sha>
cd -
```

## 3. 設定ファイル作成

- `nvim/.config/nvim/lua/plugins/<plugin>.lua` を作る。
- `nvim/.config/nvim/init.lua` に `require("plugins.<plugin>")` を追加する。
- 依存プラグインがある場合は同様に submodule 追加する。

## 4. setup で自動反映

このリポジトリでは `setup.sh` 実行時に次が自動実行される:

- `install/submodules.sh`
- `git submodule sync --recursive`
- `git submodule update --init --recursive`

つまり、他環境では `setup.sh` だけで submodule が導入される。

## 5. 更新手順 (既存 submodule)

```bash
cd /home/isono/ghq/github.com/katsuwo20/mydotfiles

# 任意のサブモジュールへ移動
cd nvim/.config/nvim/pack/plugins/start/<plugin-dir>

# 追従先へ更新（例: branch の先頭）
git fetch --all
git checkout <branch-or-tag>
git pull --ff-only || true
cd -

# ルートで差分確認
git status
```

## 6. よくある注意点

- `main` が新しすぎる場合は互換 branch/tag を選ぶ。
- submodule の URL 変更時は `git submodule sync --recursive` を実行する。
- 依存 plugin を忘れると起動時エラーになる（README の dependency を確認する）。
