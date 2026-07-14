############################################################
# 履歴の挙動
############################################################

# 他シェルと履歴共有
setopt share_history
# 重複履歴を保存しない
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
# 実行直後に履歴へ
setopt inc_append_history
