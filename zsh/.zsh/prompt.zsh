############################################################
# プロンプト（軽量・git対応）
############################################################

autoload -Uz vcs_info
precmd() { vcs_info }

# gitブランチ表示
zstyle ':vcs_info:git:*' formats '(%b)'

setopt prompt_subst
PROMPT='%F{cyan}%n@%m%f:%F{yellow}%~%f %F{green}${vcs_info_msg_0_}%f
$ '
