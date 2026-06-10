" ===============================
" CF Linux Vim 基本設定（RTL/Python）
" ===============================

" --- 表示系 ---
"set number                 " 常に行番号を表示（恒久）
" set relativenumber       " 必要なら相対行番号も併用（行移動が速くなります）
set cursorline             " 現在行を強調
set showmatch              " 対応する括弧を表示
set laststatus=2           " ステータスライン常時表示
set list                   " 不可視文字表示（必要なら↓好みに応じて調整）
set listchars=tab:\▸\ ,trail:·,extends:»,precedes:«

" --- 検索 ---
set ignorecase             " 大文字小文字無視
set smartcase              " 大文字を含む検索語では区別
set hlsearch               " 検索ハイライト
set incsearch              " インクリメンタル検索

" --- 編集の基本 ---
set nocompatible           " 互換モード無効（Vim 標準動作）
set backspace=indent,eol,start
set autoindent
set smartindent
set hidden                 " 未保存でも他バッファに移動可
set nowrap                 " デフォルトで折り返さない（ログ/RTL向け）
" set wrap                  " 必要に応じて折り返しを有効に

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
set undofile               " 永続 undo（環境により使えない場合はコメントアウト）

" --- コマンドライン/補完 ---
set wildmenu
set wildmode=full
set showcmd


" ===============================
" 追加: init.lua 相当のキーマップ設定
" ===============================

" Leaderキーをスペースに設定
let mapleader = " "

" ===============================
" Windows クリップボード完全連携 (WSL)
" ===============================
" yank 時に自動で Windows クリップボードへコピー
" (Ctrl+V / Win+V で貼り付け可能)
" Windows 側で Ctrl+C / Ctrl+X したものを p で貼り付け可能
set clipboard=unnamedplus

" --- clipboard ---
if executable('powershell.exe')
  set clipboard=unnamedplus

  augroup YankToClip
    autocmd!
    autocmd TextYankPost *
    \ if v:event.operator ==# 'y' |
    \ call system('clip.exe', getreg(v:event.regname ==# '' ? '"' : v:event.regname)) |
    \ endif
  augroup END
endif


if executable('powershell.exe')
  " p / P で Windows クリップボードから貼り付け
  nnoremap <silent> p :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>p
  nnoremap <silent> P :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>P
endif


" --- キーマップ（VimScript版） ---
" 保険として既存マップ削除（存在しなければ無視）
silent! nunmap H
silent! nunmap L

" K / J / H / L の移動（通常モード）
nnoremap K 10k
nnoremap J 10j
nnoremap H 0
nnoremap L $

" K / J / H / L の移動（ビジュアルモード）
vnoremap K 10k
vnoremap J 10j
vnoremap H 0
vnoremap L $

" 矩形選択モードを <leader>V に割り当て
nnoremap <leader>V <C-v>

" ===============================
" 追加: jj → ノーマルモードへ戻る
" ===============================
inoremap jj <ESC>

" ===============================
" delete options
" ===============================
" d$ を dl に置き換え
nnoremap dl d$

" d0 を dh に置き換え
nnoremap dh d0

" disable delete when put
xnoremap p "_dP

" ----------------------------
" d をレジスタに保持しない（普段はブラックホール）
" ----------------------------
nnoremap <silent> d "_d
xnoremap <silent> d "_d
nnoremap <silent> D "_D

" たまに切り取りしたい時：<leader>d は通常挙動（無名レジスタに入る）
nnoremap <silent> <leader>d "dd
xnoremap <silent> <leader>d "dd
nnoremap <silent> <leader>D "dD

" ----------------------------
" c をレジスタに保持しない（普段はブラックホール）
" ----------------------------
nnoremap <silent> c "_c
xnoremap <silent> c "_c
nnoremap <silent> C "_C

" <leader>c は通常の change
nnoremap <silent> <leader>c "cc
xnoremap <silent> <leader>c "cc
nnoremap <silent> <leader>C "cC

" ----------------------------
" x をレジスタに保持しない（普段はブラックホール）
" ----------------------------
nnoremap <silent> x "_x
xnoremap <silent> x "_x
nnoremap <silent> X "_X

" <leader>x は通常の x（無名レジスタに入る）
nnoremap <silent> <leader>x ""x
xnoremap <silent> <leader>x ""x
nnoremap <silent> <leader>X ""X

" ----------------------------
" Visual の置換ペーストでレジスタを汚さない
" Windows クリップボードから取得して貼り付け
" ----------------------------
if executable ('powershell.exe')
  xnoremap <silent> p :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>gv"_dP
endif

nnoremap <Esc><Esc> :nohlsearch<CR>


" ----------------------------
" setting for vim-easymotion
" ----------------------------
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1

