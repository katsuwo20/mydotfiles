############################################################
# キーバインド
############################################################

# vim風
bindkey -v
bindkey -M vicmd H beginning-of-line  # viコマンドモードでHを押すと行頭に移動
bindkey -M vicmd L end-of-line        # viコマンドモードでLを押すと行末に移動
bindkey '^p' up-history   # Ctrl + pで履歴を遡る
bindkey '^n' done-history # Ctrl + nで履歴を進む
KEYTIMEOUT=1

# ↑↓で履歴検索（bash風）
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
