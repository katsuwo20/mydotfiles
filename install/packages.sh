
#!/usr/bin/env bash

set -e

source "$FUNCTIONS_DIR/utils.sh"

log packages "Installing packages..."

sudo apt update
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

success packages "Packages installed successfully"
