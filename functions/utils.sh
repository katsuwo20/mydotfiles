
#!/usr/bin/env bash

# 色定義
readonly COLOR_RESET="\033[0m"
readonly COLOR_BLUE="\033[1;34m"
readonly COLOR_YELLOW="\033[1;33m"
readonly COLOR_RED="\033[1;31m"
readonly COLOR_GREEN="\033[1;32m"

log() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_BLUE}[%s]${COLOR_RESET} %s\n" "$tag" "$message"
}

warn() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_YELLOW}[%s] WARN:${COLOR_RESET} %s\n" "$tag" "$message"
}

error() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_RED}[%s] ERROR:${COLOR_RESET} %s\n" "$tag" "$message" >&2
}

success() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_GREEN}[%s]${COLOR_RESET} %s\n" "$tag" "$message"
}
