# 2重書き込み防
[[ -n ${__CONFIG_LOADED:-} ]] && return
readonly __CONFIG_LOADED=1

readonly TAG_config="config"

setup_config() {
    cd "$DOTFILES_DIR"

    # Configの設定
    log "$TAG_config" "Setting up config ..."
    stow -v -t ~ config
}

setup_config_cf() {
    local config_dir="$DOTFILES_DIR/config/.config"
    local home_config_dir="$HOME/.config"
    # .config内のディレクトリ一覧
    local links=(
        "fzf"
    )

    cd "$DOTFILES_DIR"

    # .config内のディレクトリをhomeディレクトリにシンボリックリンク
    log "$TAG_config" "Setting up config ..."
    mkdir -p "$home_config_dir"
    for link in "${links[@]}"; do
        log "$TAG_config" "Creating symlink for $link"
        linkup "$config_dir/$link" "$home_config_dir/$link"
    done
}
