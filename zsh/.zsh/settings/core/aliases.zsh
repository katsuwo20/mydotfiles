# ===========================
# よく使うalias
# ===========================

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'

alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias gp='git pull'
alias gd='git diff'

alias p='pwd'

# ===========================
# lazygit
# ===========================
alias lg='lazygit'

# ===========================
# python系
# ===========================
alias python='python3'
alias pip='pip3'

# ===========================
# neovim
# ===========================
alias v='nvim'

# ===========================
# tmux系
# ===========================
# session 関連
alias tw='tmux new -As work'    # work   セッションが無かったら作ってattatch
alias ts='tmux new -As sim'     # sim    セッションが無かったら作ってattatch
alias tg='tmux new -As git'     # git    セッションが無かったら作ってattatch
alias tc='tmux new -As vscode'  # vscode セッションが無かったら作ってattatch

alias tls='tmux ls'


# ===========================
# CF系
# ===========================
alias bja='bjobs -u all'

