#!/usr/bin/env bash

set -euo pipefail

readonly ENV_CF="CF"
readonly ENV_WSL="WSL"
readonly ENV_WINDOWS="Windows"
readonly ENV_LINUX="Linux"
readonly ENV_UNKNOWN="unknown"

# ファイルの場所を特定
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"
log "setup" "Loading function from $FUNCTIONS_DIR/parse_args.sh"
source "$FUNCTIONS_DIR/parse_args.sh" "$@"

# functionsディレクトリ内の関数の読み込み
for func in "$FUNCTIONS_DIR"/*.sh; do
    [[ "$func" == *utils.sh ]] && continue # utils.shは既に読み込んでいるのでスキップ
    [[ "$func" == *parse_args.sh ]] && continue # parse_args.shは既に読み込んでいるのでスキップ

    log "setup" "Loading function from $func"
    source "$func"
done

# 環境を判定
ENV=$(detect_env)
if [[ "$ENV" == "$ENV_UNKNOWN" ]]; then
    error "env" "Could not detect environment. Exiting."
    exit 1
else
    success "env" "Detected environment: $ENV"
fi

# 環境に応じて処理を変更
case "$ENV" in
    "$ENV_CF")
        warn "env" "CF environment does not support this setup script."
        exit 0
        ;;
    "$ENV_WSL")
        log "env" "Running in WSL environment. Proceeding with setup."
        # Linux環境向けのインストール処理を実行
        install_for_linux

        # zshの設定を行う
        setup_zsh
        unpack_win32yank

        # vimの設定を行う
        setup_vim
        setup_nvim

        # zoxideの設定を行う
        unpack_zoxide

        # uvの設定を行う
        unpack_uv
        ;;
    "$ENV_WINDOWS")
        warn "env" "Windows environment does not support this setup script."
        exit 0
        ;;
    "$ENV_LINUX")
        warn "env" "Linux environment does not support this setup script."
        exit 0
        ;;
esac


cd "$DOTFILES_DIR"

log "git" "Applying git settings ..."
stow -v -t ~ git

log "git" "Setting up Git local configuration ..."
LOCAL_GITCONFIG="$HOME/.gitconfig.local"
if [ ! -f "$LOCAL_GITCONFIG" ]; then
    read -p "Git user.name: " GIT_NAME
    read -p "Git user.email: " GIT_EMAIL
    cat <<EOF > "$LOCAL_GITCONFIG"
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL
EOF
    log "git" "Created $LOCAL_GITCONFIG"
else
    log "git" "Git local configuration already exists at $LOCAL_GITCONFIG"
fi

log "git" "Setting up ghq ..."
mkdir -p "$HOME/ghq"
git config --file "$HOME/.gitconfig.local" --unset-all ghq.root 2>/dev/null || true
git config --file "$HOME/.gitconfig.local" --add ghq.root "$HOME/ghq"
log "git" "ghq root set to $HOME/ghq"

log "git" "Setting up git safe.directory ..."
git config --file "$HOME/.gitconfig.local" --unset-all safe.directory 2>/dev/null || true
git config --file "$HOME/.gitconfig.local" --add safe.directory "$HOME/ghq/*"
log "git" "safe.directory set to $HOME/ghq"


# Configの設定
cd "$DOTFILES_DIR"
log "config" "Setting up config ..."
stow -v -t ~ config

# WSL上では、dotfiles側のVS Code設定をWindows側User設定へ同期
if [[ "$ENV" == "$ENV_WSL" ]]; then
    setup_vscode_user_files
fi


# 最後に元のディレクトリに戻る
cd "$DOTFILES_DIR"

success "setup" "Setup completed successfully"
log "setup" "Please restart WSL"
