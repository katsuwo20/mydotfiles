
readonly TAG_uv="uv"

unpack_uv() {
    local pack="uv"
    local pack2="uvx"
    unpack_common $pack
    unpack_common $pack2
}

setup_uv() {
    local tag="uv"
    log "$tag" "start setting..."

    # 展開してPathを通す
    unpack_uv

    success "$tag" "setting done!"
}
