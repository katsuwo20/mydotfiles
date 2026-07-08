# 2重書き込み防止
[[ -n ${__INSTALL_LOADED:-} ]] && return
readonly __INSTALL_LOADED=1

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
    cd "$DOTFILES_DIR"
    # 各種ツールをインストール
    log "$TAG_install" "Installing tools and packages..."
    INSTALL_DIR="$DOTFILES_DIR/install"
    INSTALL_SCRIPTS=(
        "packages.sh"
        "lazygit.sh"
    )

    log "$TAG_install" "check -d/--download option"
    if [[ "$(get_opt "download")" == "true" ]]; then
        log "$TAG_install" "Download option detected."
        INSTALL_SCRIPTS+=("zsh_packs.sh")
    fi

    for script in "${INSTALL_SCRIPTS[@]}"; do
        log "$TAG_install" "Running $script..."
        "$INSTALL_DIR/$script"
    done

    # ロケールの設定 (日本語が使えるように)
    set_locale

    # binファイルのpathを設定
    log "$TAG_install" "remove $HOME/.local/bin" # 既存の設定を削除
    rm -rf "$HOME/.local/bin"
    log "$TAG_install" "Setting up bin files..."
    cd "$BIN_DIR"
    stow -v -t ~ local

    # stow後のセットアップ（~/.local/bin が確定してから実行する必要があるもの）
    log "$TAG_install" "Running post-stow setup: nodejs.sh..."
    "$INSTALL_DIR/nodejs.sh"
}


# CF環境向けのインストール処理
install_for_cf() {
    local home_bin_dir="$HOME/.local/bin"
    cd "$DOTFILES_DIR"

    # binファイルのpathを設定
    mkdir -p "$home_bin_dir"
    log "$TAG_install" "Setting up bin files..."

    linkup "$LOCAL_BIN_DIR" "$home_bin_dir"
}
