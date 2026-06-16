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

    local submodule_setup_script="$DOTFILES_DIR/install/submodules.sh"
    if [[ -f "$submodule_setup_script" ]]; then
        log "$TAG_vim" "Installing/updating git submodules ..."
        bash "$submodule_setup_script"
    else
        warn "$TAG_vim" "Submodule installer not found: $submodule_setup_script"
    fi

    # nvimの設定をホームディレクトリにシンボリックリンク
    stow -v -t ~ nvim
}
