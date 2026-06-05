#!/usr/bin/env bash

set -euo pipefail

readonly ENV_CF="CF"
readonly ENV_WSL="WSL"
readonly ENV_WINDOWS="Windows"
readonly ENV_LINUX="Linux"
readonly ENV_UNKNOWN="unknown"

# ファイルの場所を特定
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

# 共通関数の読み込み
source "$DOTFILES_DIR/functions/utils.sh"

# functionsディレクトリ内の関数の読み込み
FUNCTIONS_DIR="$DOTFILES_DIR/functions"
export FUNCTIONS_DIR
for func in "$FUNCTIONS_DIR"/*.sh; do
    [[ "$func" == *utils.sh ]] && continue # utils.shはすでに読み込んでいるのでスキップ
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

case "$ENV" in
    "$ENV_CF")
        warn "env" "CF environment does not support this setup script."
        exit 0
        ;;
    "$ENV_WSL")
        log "env" "Running in WSL environment. Proceeding with setup."
        ;;
    "$ENV_WINDOWS")
        warn "env" "Windows environment does not support this setup script."
        exit 0
        ;;
    "$ENV_LINUX")
        log "env" "Running in Linux environment. Proceeding with setup."
        ;;
esac

# 各種ツールをインストール
log "setup" "Installing tools and packages..."
INSTALL_DIR="$DOTFILES_DIR/install"
INSTALL_SCRIPTS=(
    "packages.sh"
    "lazygit.sh"
)
for script in "${INSTALL_SCRIPTS[@]}"; do
    "$INSTALL_DIR/$script"
done

log "locale" "Setting locale to ja_JP.UTF-8"
sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8


cd "$DOTFILES_DIR"

log "zsh" "Applying zsh settings ..."
stow -v -t ~ zsh

log "zsh" "Changing default shell to zsh"
chsh -s $(which zsh)


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


success "setup" "Setup completed successfully"
log "setup" "Please restart WSL"
