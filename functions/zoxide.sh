# zoxideの設定を行うファイル

readonly TAG_zoxide="zoxide"

unpack_zoxide() {
    local pack="zoxide"

    unpack_common "$pack"
}

setup_zoxide() {
    log "$TAG_zoxide" "start setting..."

    # zoxideを展開してPathを通す
    unpack_zoxide

    success "$TAG_zoxide" "setting done!"
}
