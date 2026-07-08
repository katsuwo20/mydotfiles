unpack_ripgrep() {
    local pack="ripgrep"
    unpack_common $pack
}

setup_ripgrep() {
    local tag="ripgrep"
    log "$tag" "start setting..."
  
    # 展開してPathを通す
    unpack_ripgrep

    success "$tag" "setting done!"
}
