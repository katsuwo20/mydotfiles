" ===============================
" キーマップ設定
" ===============================

" Leaderキーをスペースに設定
let mapleader = " "

" --- 移動系（通常モード） ---
silent! nunmap H
silent! nunmap L
nnoremap K 10k
nnoremap J 10j
nnoremap H 0
nnoremap L $

" --- 移動系（ビジュアルモード） ---
vnoremap K 10k
vnoremap J 10j
vnoremap H 0
vnoremap L $

" --- 矩形選択 ---
nnoremap <leader>V <C-v>

" --- インサートモード脱出 ---
inoremap jj <ESC>

" --- d$ / d0 のショートカット ---
nnoremap dl d$
nnoremap dh d0

" --- 検索ハイライト解除 ---
nnoremap <Esc><Esc> :nohlsearch<CR>
