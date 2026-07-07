#!/usr/bin/env bash

set -euo pipefail

# ファイルの場所を特定
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
# 環境系の設定をsource
source "$DOTFILES_DIR/functions/env.sh"

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

# vscode用の関数ファイルを読み込み
source "$FUNCTIONS_DIR/vscode.sh"

# vscodeの設定をdotfilesに取り込む
apply_vscode_backup
