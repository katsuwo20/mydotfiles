unpack_fzf() {
    local pack="fzf"
    unpack_common $pack
}

setup_fzf() {
    local tag="fzf"
    log "$tag" "start setting..."
  
    # 展開してPathを通す
    unpack_fzf 

    success "$tag" "setting done!"
}
