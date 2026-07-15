# pluguinsの設定を読み込む
_load_plug_settings() {
    local dir="$HOME/.zsh/settings/plugins"

    source "$dir/fzf-tab.zsh"
    source "$dir/zsh-autosuggestions.zsh"
}

_load_plugs() {
    local dir="$HOME/.zsh/plugins"
    source "$dir/fzf-tab/fzf-tab.plugin.zsh"
    source "$dir/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
}


# source時に実行
_load_plugs
_load_plug_settings

# 後片付け
unset -f _load_plugs _load_plug_settings
