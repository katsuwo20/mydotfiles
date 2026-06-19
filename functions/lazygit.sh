unpack_lazygit() {
    local pack="lazygit"
    unpack_common $pack
}

setup_lazygit() {
    local tag="lazygit"
    log "$tag" "start setting..."
  
    # 展開してPathを通す
    unpack_lazygit 

    success "$tag" "setting done!"
}
