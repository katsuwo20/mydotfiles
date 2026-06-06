#!/usr/bin/env bash

# =======================================================
# zshとその依存関係の圧縮ファイルをダウンロードするスクリプト
# =======================================================

set -e

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

readonly TAG=zsh_package

readonly NCURSES_VERSION="6.4"
readonly ZSH_VERSION="5.9"


# zshのパッケージをダウンロードするディレクトリに移動
cd $DOTFILES_DIR/bin/packages/zsh

# フォルダをすべてリセット
log "$TAG" "Clear in folder."
rm -rf *

# ncursesをダウンロード
log "$TAG" "Start Download Packages for zsh"
log "$TAG" "Downloading ncurses..."
log "$TAG" "ncurses version : $NCURSES_VERSION"
wget -q -N "https://ftp.gnu.org/pub/gnu/ncurses/ncurses-${NCURSES_VERSION}.tar.gz"

# zshのダウンロード（公式がダメならミラーから取得。-O使用時は-Nを外して警告を回避）
if ! wget -q -N "https://pub.zsh.org/zsh-${ZSH_VERSION}.tar.xz"; then
    warn "$TAG" "The download from the official website failed"
    log "$TAG" "Try again from a mirror site..."
    wget -q -O "zsh-${ZSH_VERSION}.tar.xz" "https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz/download"
fi

success "$TAG" "complete download packages for zsh"