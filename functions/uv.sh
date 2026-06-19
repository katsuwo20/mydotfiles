
readonly TAG_uv="uv"

unpack_uv() {
    # uvを展開してパスを通す関数
    log "$TAG_uv" "unpack the tar file"
    # 既存フォルダを削除
    cd "$LOCAL_DIR"
    rm -rf uv uvx

    # パッケージを展開
    cd "$PACKAGES_DIR"
    log "$TAG_uv" "unpacking..."
    tar -xf uv.tar.gz -C "$LOCAL_DIR"
    tar -xf uvx.tar.gz -C "$LOCAL_DIR"

    # PATHを設定
    log "$TAG_uv" "add it to the PATH"
    cd "$LOCAL_BIN_DIR"
    rm -f uv
    rm -f uvx
    ln -s ../uv/bin/uv
    ln -s ../uvx/bin/uvx

    success "$TAG_uv" "uv installed successfully"
}

unpack_uv() {
    local pack="uv"
    local pack2="uvx"
    unpack_common $pack
    unpack_common $pack2
}

setup_fd() {
    local tag="uv"
    log "$tag" "start setting..."
  
    # 展開してPathを通す
    unpack_uv

    success "$tag" "setting done!"
}
