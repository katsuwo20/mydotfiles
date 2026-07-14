# zshの設定を行うファイル

readonly TAG_zsh="zsh"

# zshをデフォルトshellに設定する関数
set_zsh_default() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        log "$TAG_zsh" "Current shell is $SHELL, changing to zsh..."
        chsh -s "$(which zsh)"
        success "$TAG_zsh" "Default shell changed to zsh."
    else
        success "$TAG_zsh" "Default shell is already zsh"
    fi
}

unpack_win32yank() {
    local pack="win32yank"

    unpack_common "$pack"
}

# zshの設定を適用する関数
setup_zsh() {
    cd "$DOTFILES_DIR"
    log "$TAG_zsh" "Applying zsh settings ..."
    # zshの設定をホームディレクトリにシンボリックリンク
    stow -v -t ~ zsh

    # zshをデフォルトshellに設定
    set_zsh_default
}


# cf環境用
setup_zsh_cf() {
    local zsh_dir="$DOTFILES_DIR/zsh"

    cd "$DOTFILES_DIR"
    log "$TAG_zsh" "Applying zsh settings ..."
    # ==============================================
    # zshの設定をホームディレクトリにシンボリックリンク
    # ==============================================
    # .zshrc
    linkup $zsh_dir/.zshrc $HOME/.zshrc
    # .zshディレクトリ
    linkup $zsh_dir/.zsh $HOME/.zsh
}
