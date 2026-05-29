############################################################
# 基本設定
############################################################

# 文字コード
export LANG=ja_JP.UTF-8

# 履歴ファイル
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# cd だけで移動
setopt auto_cd
# ディレクトリ履歴
setopt auto_pushd
setopt pushd_ignore_dups
