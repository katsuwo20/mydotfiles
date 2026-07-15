############################################################
# キーバインド
############################################################

KEYTIMEOUT=20

# vim風
bindkey -v

# ==========================================
# mode切替
# ==========================================
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line  # viコマンドモードでvを押すとコマンドラインを編集
bindkey -M viins jj vi-cmd-mode  # vi挿入モードでjjを押すとコマンドモードに切り替え

# ==========================================
# 移動系
# ==========================================
bindkey -M vicmd H beginning-of-line  # viコマンドモードでHを押すと行頭に移動
bindkey -M vicmd L end-of-line        # viコマンドモードでLを押すと行末に移動

# ==========================================
# 履歴系
# ==========================================
# ↑↓で履歴検索（bash風）
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# j/kを無効化
bindkey -r -M vicmd j
bindkey -r -M vicmd k

# ==========================================
# mode表示
# ==========================================
function zle-keymap-select {
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
    zle -K viins
}
zle -N zle-line-init

RPROMPT='${${KEYMAP/vicmd/[NORMAL]}/(main|viins)/[INSERT]}'
