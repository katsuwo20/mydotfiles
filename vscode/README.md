# VS Code 設定の同期

このディレクトリでは、Windows 版 VS Code の `settings.json` と
`keybindings.json` を WSL 上の dotfiles リポジトリで管理します。

## 管理対象

| 場所 | 用途 |
| --- | --- |
| `Machine/settings.json` | リポジトリで管理する設定の正本 |
| `Machine/keybindings.json` | リポジトリで管理するキーバインドの正本 |
| `latest/windows/` | リポジトリから Windows へ反映する直前の Windows 側設定 |
| `latest/wsl/` | Windows から取り込む直前の `Machine/` 側設定 |

Windows 側では、現在ログインしている Windows ユーザーの次のファイルを
読み書きします。

```text
C:\Users\<Windowsユーザー名>\AppData\Roaming\Code\User\settings.json
C:\Users\<Windowsユーザー名>\AppData\Roaming\Code\User\keybindings.json
```

スクリプトは WSL から `cmd.exe` を呼び出して Windows ユーザー名を取得するため、
WSL の Windows 連携が有効な環境で実行してください。

## Windows の設定をリポジトリへ取り込む

VS Code の設定画面などで Windows 側の設定を変更した後に実行します。

```bash
cd ~/ghq/github.com/katsuwo20/mydotfiles
./vscode/import_settings_form_windows.sh
```

実行すると、次の順で処理されます。

1. 現在の `vscode/Machine/settings.json` と `keybindings.json` を、それぞれ
   `vscode/latest/wsl/` にコピーします。
2. Windows 側の `settings.json` と `keybindings.json` で
   `vscode/Machine/` のファイルを上書きします。

取り込み後は差分を確認し、必要に応じて Git にコミットしてください。

```bash
git diff -- vscode/Machine vscode/latest/wsl
```

Windows 側に対象ファイルがない場合、そのファイルは取り込まず警告を表示します。

## リポジトリの設定を Windows へ反映する

通常はリポジトリのルートでセットアップを実行します。

```bash
cd ~/ghq/github.com/katsuwo20/mydotfiles
./setup.sh
```

WSL 環境で `setup.sh` を実行すると、VS Code 設定について次の処理が行われます。

1. Windows 側の現在の設定を `vscode/latest/windows/` にバックアップします。
2. `vscode/Machine/settings.json` と `keybindings.json` を Windows 側へコピーし、
   Windows 側のファイルを上書きします。
3. `vscode/Machine/` を WSL Remote の VS Code Server 用設定ディレクトリへ
   symlink として展開します。

初回実行時に `vscode/Machine/` の対象ファイルが存在しない場合は、Windows 側の
既存ファイルを正本として取り込みます。どちらにも存在しない場合は、
`settings.json` に `{}`、`keybindings.json` に `[]` を作成します。

> `setup.sh` は VS Code 以外の dotfiles セットアップも実行します。

## Windows 側を反映前の状態へ戻す

直近に `setup.sh` でリポジトリから Windows へ反映する前の状態へ戻す場合に
実行します。

```bash
cd ~/ghq/github.com/katsuwo20/mydotfiles
./vscode/apply_vscode_backup.sh
```

`vscode/latest/windows/settings.json` と `keybindings.json` を Windows 側へコピーし、
現在の Windows 側設定を上書きします。これは `vscode/Machine/` の内容を反映する
コマンドではなく、Windows 側設定の復元用です。バックアップがないファイルは
復元せず警告を表示します。

## 拡張機能一覧のバックアップと復元

設定ファイルとは別に、WSL 側と Windows 側の拡張機能一覧も管理できます。

現在インストールされている拡張機能を一覧へ保存します。

```bash
./vscode/backup_extensions.sh
```

- WSL 側: `vscode/extensions/extensions_wsl.txt`
- Windows 側: `vscode/extensions/extensions_windows.txt`

保存済みの一覧から拡張機能をインストールします。

```bash
./vscode/install_extensions.sh
```

`code` コマンドが WSL から実行できる必要があります。Windows 側の処理には、
加えて `cmd.exe` から `code` コマンドを実行できる環境が必要です。

## 推奨ワークフロー

### VS Code で変更した設定を保存する

```bash
./vscode/import_settings_form_windows.sh
git diff -- vscode/Machine vscode/latest/wsl
git add vscode/Machine vscode/latest/wsl
git commit
```

### Git から取得した設定を Windows に適用する

```bash
git pull
./setup.sh
```

反映後に問題があれば、次のコマンドで反映直前の Windows 設定へ戻せます。

```bash
./vscode/apply_vscode_backup.sh
```