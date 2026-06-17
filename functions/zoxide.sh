# zshの設定を行うファイル

readonly TAG_zoxide="zoxide"

unpack_zoxide() {
    #zoxideを展開してpathを通す
    log "$TAG_zoxide" "unpack the tar file"
    cd "$BIN_DIR"/common/.local
    rm -rf zoxide
    cd "$PACKAGES_DIR"
    tar -xzf zoxide.tar.gz -C "$BIN_DIR"/common/.local/

    log "win32yank" "add it to the PATH"
    cd "$BIN_DIR"/common/.local/bin
    rm -f TAG_zoxide
    ln -s ../zoxide/bin/zoxide

    success "$TAG_zoxide" "zoxide installed successfully"
}

setup_zoxide() {
    log "$Tag_zoxide" "start setting..."
  
    # zoxideを展開してPathを通す
    unpack_zoxide

    success "$TAG_zoxide" "setting done!"
}
