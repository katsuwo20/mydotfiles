# fzf-tab

# 色対応
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ディレクトリプレビュー
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
    'ls --color=always -lah $realpath'

# 高さ
zstyle ':fzf-tab:*' fzf-flags \
    --height=70%
