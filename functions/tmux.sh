readonly TAG_tmux="tmux"
readonly TMUX_ARCHIVE="tmux-3.4-rhel8"

unpack_tmux() {
    local pack="tmux"

    unpack_common "$pack" "$TMUX_ARCHIVE"
}

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

    # CF環境では、tmuxを展開して配置(デフォルトはバージョンが古いため)
    unpack_tmux

    log "$TAG_tmux" "Setting up tmux configuration."
    cd "$DOTFILES_DIR"

    # .tmux.confのシンボリックリンクを作成
    linkup $tmux_dir/.tmux.conf $HOME/.tmux.conf

    # .config/tmuxに設定ファイルのシンボリックリンクを作成
    mkdir -p "$config_dir"
    linkup $tmux_dir/.config/tmux $config_dir/tmux

    # TERMINFOのリンクを作成
    local target="$LOCAL_DIR/$TMUX_ARCHIVE/share/terminfo"
    local link="$HOME/.local/share/terminfo"
    linkup "$target" "$link"
}
