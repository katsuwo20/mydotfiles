# mydotfiles

WSL 環境を前提にした個人用 dotfiles です。
zsh / vim / neovim / git / VS Code の設定をまとめて管理し、`setup.sh` で一括セットアップできます。

## 1. このリポジトリでできること

- 各種設定ファイルを `stow` でホーム配下へ展開
- Neovim プラグインを Git submodule で固定管理
- `setup.sh` 実行時に submodule を自動同期
- VS Code 設定の同期（WSL 環境向け）

## 2. 重要: 初回に必ず実施すること（フォント）

Neovim のファイルツリーアイコン（neo-tree など）を正しく表示するには、
**初回に `fonts` 配下の Nerd Font を Windows 側ターミナルへ適用する必要があります。**

WSL 内にフォントを置くだけでは不十分です。実際に表示を担当する
**Windows 側の PowerShell / コマンドプロンプト / Windows Terminal のフォント設定**を変更してください。

設定方法は次の記事を参照してください:

- [wslにNerdFontsをインストールし、設定する(nvim-treeアイコン) #PowerShell - Qiita](https://qiita.com/hwatahik/items/acdd791abeef4ed13c45)

補足:

- アイコンが豆腐表示になる場合、ほぼフォント未適用が原因です。
- フォント変更後はターミナルを再起動してください。

## 3. セットアップ手順

```bash
cd ~/ghq/github.com/katsuwo20/mydotfiles
./setup.sh
```

`setup.sh` は環境判定後、必要な設定展開とセットアップを実施します。

## 4. Neovim プラグイン運用方針

このリポジトリでは、Neovim プラグインを次のディレクトリに submodule として配置します。

- `nvim/.config/nvim/pack/plugins/start/`

設定ファイルは次へ置きます。

- `nvim/.config/nvim/lua/plugins/<plugin>.lua`

読み込みは `nvim/.config/nvim/init.lua` に `require("plugins.<plugin>")` を追加して行います。

## 5. submodule を新規追加する手順

### 5-1. 事前確認

- 現在の Neovim バージョンを確認
- 対象プラグインの README で required Neovim version を確認
- 互換性が怪しい場合は `main` ではなく安定 branch/tag を選択

例:

```bash
nvim --version | head -n 2
git ls-remote --heads https://github.com/nvim-neo-tree/neo-tree.nvim.git
git ls-remote --tags https://github.com/nvim-neo-tree/neo-tree.nvim.git | tail -n 20
```

### 5-2. 追加

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

### 5-3. 設定追加

- `nvim/.config/nvim/lua/plugins/<plugin>.lua` を作る
- `nvim/.config/nvim/init.lua` に `require("plugins.<plugin>")` を追加
- 依存プラグインがある場合は同様に submodule 追加

## 6. submodule 自動同期の仕組み

このリポジトリでは `setup.sh` 実行時に `install/submodules.sh` が呼ばれ、次を実行します。

- `git submodule sync --recursive`
- `git submodule update --init --recursive`

そのため、別環境でも `setup.sh` だけで submodule 導入まで完了します。

## 7. 既存 submodule の更新手順

```bash
cd /home/isono/ghq/github.com/katsuwo20/mydotfiles

cd nvim/.config/nvim/pack/plugins/start/<plugin-dir>
git fetch --all
git checkout <branch-or-tag>
git pull --ff-only || true
cd -

git status
```

## 8. 現在の Neo-tree 運用メモ

- Neovim 0.9.5 では Neo-tree は `v2.x` 系を利用
- 依存: `plenary.nvim`, `nui.nvim`, `nvim-web-devicons`
- アイコンが出ない場合はフォント設定を最優先で確認

## 9. トラブルシュート

- `main` が新しすぎる場合: 互換 branch/tag を使う
- URL 変更後に追従できない場合: `git submodule sync --recursive`
- 依存 plugin 漏れで起動エラー: README の dependency を確認して追加
