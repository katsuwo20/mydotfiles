# vim関連の設定を行うスクリプト

readonly TAG_vim="vim"

setup_vim() {
    cd "$DOTFILES_DIR"
    log "$TAG_vim" "Applying vim settings ..."
    # vimの設定をホームディレクトリにシンボリックリンク
    stow -v -t ~ vim

    # vimのundoディレクトリを作成
    mkdir -p "$HOME/.cache/vim/undo"
}

setup_nvim() {
    cd "$DOTFILES_DIR"
    log "$TAG_vim" "Applying vim settings ..."
    # nvimの設定をホームディレクトリにシンボリックリンク
    stow -v -t ~ nvim
}
