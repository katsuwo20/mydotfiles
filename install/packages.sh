
#!/usr/bin/env bash

set -e

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

log packages "Installing packages..."

sudo apt update
sudo apt upgrade -y || true
sudo apt install -y \
    locales \
    zsh \
    git \
    curl \
    fzf \
    stow \
    python3 \
    python3-venv \
    python3-pip \
    unzip \
    ripgrep \
    fd-find \
    npm \

success packages "Packages installed successfully"

log packages "Cleaning up..."
sudo apt autoremove -y
