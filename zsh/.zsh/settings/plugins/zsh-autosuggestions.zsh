# zsh-autosuggestionsの設定ファイル

# 履歴のみを使用
ZSH_AUTOSUGGEST_STRATEGY=(history)

# 補完の色を変更
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242' # 灰色に設定

# Insertモードのみ、ctrl+lで補完を受け入れるようにする
bindkey -M viins '^L' autosuggest-accept
