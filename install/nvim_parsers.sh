#!/usr/bin/env bash

set -euo pipefail

source "$FUNCTIONS_DIR/utils.sh"

readonly TAG=nvim-parsers
readonly PARSERS=(
    c cpp bash css go html javascript json lua markdown markdown_inline
    python query rust toml tsx typescript vim vimdoc yaml
)

log "$TAG" "Installing Neovim Tree-sitter parsers..."

if ! command -v tree-sitter >/dev/null 2>&1; then
    error "$TAG" "tree-sitter CLI is not installed"
    exit 1
fi

if ! command -v nvim >/dev/null 2>&1; then
    error "$TAG" "nvim command is not available"
    exit 1
fi

parser_list=$(printf '"%s",' "${PARSERS[@]}")
nvim --headless -u NONE \
    -c "lua require('nvim-treesitter').install({${parser_list%,}}):wait(600000)" \
    -c 'qa!'

success "$TAG" "Tree-sitter parsers are ready"