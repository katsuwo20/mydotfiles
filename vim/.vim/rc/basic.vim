" ===============================
" 基本設定
" ===============================

" --- 互換性 ---
set nocompatible

" --- 表示系 ---
set cursorline             " 現在行を強調
set showmatch              " 対応する括弧を表示
set laststatus=2           " ステータスライン常時表示
set list                   " 不可視文字表示
set listchars=tab:\▸\ ,trail:·,extends:»,precedes:«

" --- 検索 ---
set ignorecase             " 大文字小文字無視
set smartcase              " 大文字を含む検索語では区別
set hlsearch               " 検索ハイライト
set incsearch              " インクリメンタル検索

" --- 編集の基本 ---
set backspace=indent,eol,start
set autoindent
set smartindent
set hidden                 " 未保存でも他バッファに移動可
set nowrap                 " デフォルトで折り返さない

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" --- 文字コード/改行 ---
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set fileformats=unix,dos,mac

" --- ファイル関連 ---
set nobackup
set noswapfile
set autoread               " 外部変更を自動再読込
set undofile               " 永続 undo
set undodir=~/.cache/vim/undo

" --- コマンドライン/補完 ---
set wildmenu
set wildmode=full
set showcmd
