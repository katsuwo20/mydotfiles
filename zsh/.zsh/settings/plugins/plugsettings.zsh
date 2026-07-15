# pluginsを読み込む
_load_plugs() {
    local dir="$HOME/.zsh/plugins"
    source "$dir/fzf-tab/fzf-tab.plugin.zsh"
    source "$dir/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"

    source "$dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" # 最後に読み込むこと
}

# pluginsの設定を読み込む
_load_plug_settings() {
    local dir="$HOME/.zsh/settings/plugins"

    source "$dir/fzf-tab.zsh"
    source "$dir/zsh-autosuggestions.zsh"
}

# source時に実行
_load_plugs
_load_plug_settings

# 後片付け
unset -f _load_plugs _load_plug_settings
