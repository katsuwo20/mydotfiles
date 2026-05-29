############################################################
# キーバインド
############################################################

# emacs風（デフォルト）
bindkey -e

# ↑↓で履歴検索（bash風）
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
