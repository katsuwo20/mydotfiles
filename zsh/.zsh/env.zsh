############################################################
# 環境変数・外部ツール
############################################################

# バイナリファイルのパスを設定
. "$HOME/.local/bin/env"

#fxf をshellに統合
source "$HOME/.config/fzf/fzf.sh"

# zoxideをshellに統合
eval "$(zoxide init zsh)"

export EDITOR=nvim
export VISUAL=nvim

# uv: システム証明書を使用（企業プロキシ等）
# ※注意※ 会社PC以外ではコメントアウトすること
export UV_SYSTEM_CERTS=1
