
############################################################
# .zshrc - メインエントリポイント
# 各設定は ~/.zsh/ 以下に分割
############################################################

# ファイルの場所を特定
DOTFILES_DIR="$HOME/mydotfiles"
# 環境系の設定をsource
source "$DOTFILES_DIR/functions/env.sh"
source "$DOTFILES_DIR/functions/utils.sh"


# 現在の環境を判定する関数を読み込む
source "$FUNCTIONS_DIR/detect_env.sh"
ENV=$(detect_env)
if [[ "$ENV" == "unknown" ]]; then
    error "env" "Could not detect environment. Exiting."
    exit 1
else
    success "env" "Detected environment: $ENV"
fi

# zshの設定を読み込む
source ~/.zsh/basic.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/history.zsh
source ~/.zsh/keybind.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/wsl.zsh
source ~/.zsh/colors.zsh
source ~/.zsh/env.zsh
source ~/.zsh/ghq.zsh
source ~/.zsh/local.zsh

# CF用の設定を読み込む
if [[ "$ENV" == "CF" ]]; then
  log "zshrc" "source CF settings"
  source ~/.zsh/functions.zsh
  success "zshrc" "CF settings loaded"
fi
