
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
    stow

success packages "Packages installed successfully"
