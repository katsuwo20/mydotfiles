# fzfをshell統合するファイル
if command -v fzf >/dev/null 2>&1; then
    if [ -n "$ZSH_VERSION" ]; then
        if fzf --zsh >/dev/null 2>&1; then
            eval "$(fzf --zsh)"
        else
            for file in \
                /usr/share/fzf/key-bindings.zsh \
                /usr/share/doc/fzf/examples/key-bindings.zsh; do
                [ -r "$file" ] && source "$file" && break
            done
            for file in \
                /usr/share/fzf/completion.zsh \
                /usr/share/doc/fzf/examples/completion.zsh; do
                [ -r "$file" ] && source "$file" && break
            done
        fi
    elif [ -n "$BASH_VERSION" ]; then
        if fzf --bash >/dev/null 2>&1; then
            eval "$(fzf --bash)"
        else
            for file in \
                /usr/share/fzf/key-bindings.bash \
                /usr/share/doc/fzf/examples/key-bindings.bash; do
                [ -r "$file" ] && source "$file" && break
            done
            for file in \
                /usr/share/fzf/completion.bash \
                /usr/share/doc/fzf/examples/completion.bash; do
                [ -r "$file" ] && source "$file" && break
            done
        fi
    fi
fi
