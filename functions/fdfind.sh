unpack_fd() {
    local pack="fd"
    unpack_common $pack
}

setup_fd() {
    local tag="fd"
    log "$tag" "start setting..."
  
    # 展開してPathを通す
    unpack_fd

    success "$tag" "setting done!"
}
