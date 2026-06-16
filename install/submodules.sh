#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${DOTFILES_DIR:-}" ]]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

if [[ -z "${FUNCTIONS_DIR:-}" ]]; then
    FUNCTIONS_DIR="$DOTFILES_DIR/functions"
fi

if [[ -f "$FUNCTIONS_DIR/utils.sh" ]]; then
    # shellcheck disable=SC1091
    source "$FUNCTIONS_DIR/utils.sh"
else
    log() { printf '[%s] %s\n' "$1" "$2" >&2; }
    warn() { printf '[%s] WARN: %s\n' "$1" "$2" >&2; }
    error() { printf '[%s] ERROR: %s\n' "$1" "$2" >&2; }
    success() { printf '[%s] %s\n' "$1" "$2" >&2; }
fi

readonly TAG="submodules"

if ! command -v git >/dev/null 2>&1; then
    error "$TAG" "git command not found"
    exit 1
fi

if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
    warn "$TAG" "Not a git repository: $DOTFILES_DIR"
    exit 0
fi

if [[ ! -f "$DOTFILES_DIR/.gitmodules" ]]; then
    log "$TAG" "No .gitmodules found. Skip submodule sync."
    exit 0
fi

log "$TAG" "Syncing submodule URLs ..."
git -C "$DOTFILES_DIR" submodule sync --recursive

log "$TAG" "Initializing/updating submodules ..."
git -C "$DOTFILES_DIR" submodule update --init --recursive --jobs 4

success "$TAG" "Submodules are ready"
