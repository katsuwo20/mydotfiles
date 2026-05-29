############################################################
# ghqの設定
############################################################

export GHQ_ROOT=/home/isono/ghq
export PATH="$HOME/go/bin:$PATH"
export GIT_CLONE_OPTS="--recursive"

# ghq + fzf でリポジトリに移動（Ctrl+b）
function ghq-cd() {
  local repo
  repo=$(ghq list -p | fzf --height 40% --reverse)
  if [ -n "$repo" ]; then
    cd "$repo"
  fi
  zle reset-prompt
}

zle -N ghq-cd
bindkey '^b' ghq-cd
