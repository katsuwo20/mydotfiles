# mydotfiles

WSL 環境を前提にした個人用 dotfiles です。
zsh / vim / neovim / git / VS Code の設定をまとめて管理し、`setup.sh` で一括セットアップできます。

## できること

- 各種設定ファイルを `stow` でホーム配下へ展開
- Neovim プラグインを Git submodule で固定管理
- setup 実行時に submodule を自動同期
- VS Code 設定の同期（WSL 環境向け）

## セットアップ

```bash
cd ~/ghq/github.com/katsuwo20/mydotfiles
./setup.sh
```

## 重要: 初回に必ず実施すること（フォント）

Neovim のファイルツリーアイコン（neo-tree など）を正しく表示するには、
**初回に fonts 配下の Nerd Font を Windows 側ターミナルへ適用する必要があります。**

WSL 内にフォントを置くだけでは不十分で、実際に表示を担当する
**Windows 側の PowerShell / コマンドプロンプト / Windows Terminal のフォント設定**を変更してください。

設定方法は次の記事を参照してください:

- [wslにNerdFontsをインストールし、設定する(nvim-treeアイコン) #PowerShell - Qiita](https://qiita.com/hwatahik/items/acdd791abeef4ed13c45)

## 補足

- アイコンが豆腐表示になる場合、ほぼフォント未適用が原因です。
- フォント変更後はターミナルを再起動してください。
