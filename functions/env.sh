# 2重書き込み防
[[ -n ${__ENV_LOADED:-} ]] && return
readonly __ENV_LOADED=1

# ファイルの場所を特定
FUNCTIONS_DIR="$DOTFILES_DIR/functions"
BIN_DIR="$DOTFILES_DIR/bin"
PACKAGES_DIR="$BIN_DIR/packages"
LOCAL_DIR="$BIN_DIR/local/.local"
LOCAL_BIN_DIR="$LOCAL_DIR/bin"
NVIM_PLUGS_DIR="$DOTFILES_DIR/nvim/.config/nvim/pack/plugins/start"

export DOTFILES_DIR
export FUNCTIONS_DIR
export BIN_DIR
export PACKAGES_DIR
export LOCAL_DIR
export LOCAL_BIN_DIR
export NVIM_PLUGS_DIR
