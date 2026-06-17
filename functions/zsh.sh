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
    #win32yankを展開してpathを通す
    log "win32yank" "unpack the tar file"
    cd "$BIN_DIR"/common/.local
    rm -rf win32yank
    cd "$PACKAGES_DIR"
    tar -xzf win32yank.tar.gz -C "$BIN_DIR"/common/.local/

    log "win32yank" "add it to the PATH"
    cd "$BIN_DIR"/common/.local/bin
    rm -f win32yank.exe
    ln -s ../win32yank/win32yank.exe

    success "win32yank" "win32yank installed successfully"
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
