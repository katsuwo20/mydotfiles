############################################################
# 補完設定
############################################################

autoload -Uz compinit
# キャッシュを使って起動を高速化
compinit -C

# 補完を大文字小文字無視
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# 補完メニューを有効化
zstyle ':completion:*' menu select
# 補完時の説明表示
zstyle ':completion:*' verbose yes
