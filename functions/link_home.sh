# 2重書き込み防
[[ -n ${__LINK_HOME:-} ]] && return
readonly __LINK_HOME=1

# =======================================
# HOMEディレクトリにmydotfilesのシンボリックリンクを作成する関数
# =======================================
linkup_home() {
    # homeにmydotfiles直置きじゃない場合、mydotfilesのシンボリックリンクをhomeディレクトリに作成
    local target_dir="$DOTFILES_DIR"
    local link_name="$HOME/mydotfiles"

    linkup "$target_dir" "$link_name"
}
