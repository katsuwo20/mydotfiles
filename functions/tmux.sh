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
