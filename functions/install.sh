# install.sh

readonly TAG_install="install"

# ロケールの設定 (日本語が使えるように)
set_locale() {
    log "$TAG_install" "Setting locale to ja_JP.UTF-8"
    sudo locale-gen ja_JP.UTF-8
    sudo update-locale LANG=ja_JP.UTF-8
}

# linux環境向けのインストール処理
install_for_linux() {
    # 各種ツールをインストール
    log "$TAG_install" "Installing tools and packages..."
    INSTALL_DIR="$DOTFILES_DIR/install"
    INSTALL_SCRIPTS=(
        "packages.sh"
        "lazygit.sh"
    )
    for script in "${INSTALL_SCRIPTS[@]}"; do
        log "$TAG_install" "Running $script..."
        "$INSTALL_DIR/$script"
    done

    # ロケールの設定 (日本語が使えるように)
    set_locale

    # binファイルのpathを設定
    cd "$BIN_DIR"
    log "$TAG_install" "Setting up bin files..."
    stow -v -t ~ common
    stow -v -t ~ WSL
}
