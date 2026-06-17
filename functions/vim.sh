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

unpack_nvim() {
    # nvimを展開してパスを通す関数
    log "$TAG_vim" "unpack the tar file"
    cd "$BIN_DIR"/common/.local
    rm -rf nvim-release-pkg
    cd "$PACKAGES_DIR"
    tar -xzf nvim-v0.12.3-release-linux-x86_64.tar.gz -C ../common/.local/

    log "$TAG_vim" "add it to the PATH"
    cd "$BIN_DIR"/common/.local/bin
    rm -f nvim
    ln -s ../nvim-release-pkg/bin/nvim

    success "$TAG_vim" "nvim installed successfully"
}

setup_nvim() {
    cd "$DOTFILES_DIR"
    log "$TAG_vim" "Applying vim settings ..."
    # nvimを展開してパスを設定
    unpack_nvim

    cd "$DOTFILES_DIR"
    local submodule_setup_script="$DOTFILES_DIR/install/submodules.sh"
    if [[ -f "$submodule_setup_script" ]]; then
        log "$TAG_vim" "Installing/updating git submodules ..."
        bash "$submodule_setup_script"
    else
        warn "$TAG_vim" "Submodule installer not found: $submodule_setup_script"
    fi

    log "$TAG_vim" "build telescope-fzf"
    cd  "$NVIM_PLUGS_DIR"/telescope-fzf-native.nvim
    make
    success "$TAG_vim" "complete to build telescope-fzf-native"


    cd "$DOTFILES_DIR"
    # nvimの設定をホームディレクトリにシンボリックリンク
    stow -v -t ~ nvim
}
