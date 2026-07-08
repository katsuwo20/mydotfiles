readonly TAG_tmux="tmux"

setup_tmux() {
    log "$TAG_tmux" "Setting up tmux configuration."
    cd "$DOTFILES_DIR"

    # tmuxのリンクを削除
    rm -f ~/.tmux.conf
    rm -f ~/.config/tmux
    # tmuxのリンク張り直し
    stow -v -t ~ tmux
    success "$TAG_tmux" "tmux configuration setup completed."
}

setup_tmux_cf() {
    local tmux_dir="$DOTFILES_DIR/tmux"
    local config_dir="$HOME/.config"

    log "$TAG_tmux" "Setting up tmux configuration."
    cd "$DOTFILES_DIR"

    # .tmux.confのシンボリックリンクを作成
    linkup $tmux_dir/.tmux.conf $HOME/.tmux.conf

    # .config/tmuxに設定ファイルのシンボリックリンクを作成
    mkdir -p "$config_dir"
    linkup $tmux_dir/.config/tmux $config_dir/tmux
}
