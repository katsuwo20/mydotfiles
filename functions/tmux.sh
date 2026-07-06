setup_tmux() {
    cd "$DOTFILES_DIR"

    stow -v -t ~ tmux
}
