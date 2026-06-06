#!/usr/bin/env bash

# ==========================================
# オプション解析用スクリプト
# ==========================================

# 解析結果を格納するグローバル連想配列の定義
declare -gA OPTS
declare -gA ARGS_POS

# すべての引数を解析する内部関数
_parse_arguments() {
    local pos_counter=1

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--download)
                OPTS["download"]=true
                shift
                ;;
            -e|--env)
                # ※暫定版
                # 値を必要とするオプションの例（例: -e production）
                if [[ -n "${2:-}" && "$2" != -* ]]; then
                    OPTS["env"]="$2"
                    shift 2
                else
                    error "args" "Option $1 requires an argument."
                    exit 1
                fi
                ;;
            -*)
                error "args" "Unknown option: $1"
                exit 1
                ;;
            *)
                # オプション以外の純粋な引数を位置ごとに記録
                ARGS_POS["$pos_counter"]="$1"
                ((pos_counter++))
                shift
                ;;
        esac
    done
}

# 外部から値を取得するためのインターフェース関数
get_opt() {
    local key="$1"
    if [[ -v OPTS["$key"] ]]; then
        echo "${OPTS["$key"]}"
    else
        echo ""
    fi
}

# 外部から位置引数を取得するためのインターフェース関数
get_arg() {
    local index="$1"
    if [[ -v ARGS_POS["$index"] ]]; then
        echo "${ARGS_POS["$index"]}"
    else
        echo ""
    fi
}

# setup.sh から source された瞬間に、渡された全引数（$@）を解析実行
_parse_arguments "$@"