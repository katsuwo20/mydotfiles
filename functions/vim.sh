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
    local pack="nvim"
    local archive="nvim-v0.12.3-release-linux-x86_64"

    unpack_common "$pack" "$archive"
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

# ==========================================
# cf環境用
# ==========================================
# vimの設定を行う関数
setup_vim_cf() {
    local vim_dir="$DOTFILES_DIR/vim"

    cd "$DOTFILES_DIR"
    log "$TAG_vim" "Applying vim settings ..."
    # vimの設定をホームディレクトリにシンボリックリンク
    linkup "$vim_dir/.vimrc" "$HOME/.vimrc"
    linkup "$vim_dir/.vim" "$HOME/.vim"

    # vimのundoディレクトリを作成
    mkdir -p "$HOME/.cache/vim/undo"
}

# neovimの設定を行う関数
setup_nvim_cf() {
    local nvim_dir="$DOTFILES_DIR/nvim"
    local config_dir="$HOME/.config"
    local local_share_dir="$HOME/.local/share"

    log "$TAG_vim" "Applying vim settings ..."
    cd "$DOTFILES_DIR"

    # nvimを展開してパスを設定
    unpack_nvim

    # サブモジュール関連はcf環境では不要なのでスキップ

    # homeディレクトリにnvimの設定をシンボリックリンク
    # .config/ディレクトリ内
    mkdir -p "$config_dir"
    linkup $nvim_dir/.config/nvim $config_dir/nvim

    # .local/share/ディレクトリ内
    mkdir -p "$local_share_dir"
    linkup $nvim_dir/.local/share/nvim $local_share_dir/nvim

}
