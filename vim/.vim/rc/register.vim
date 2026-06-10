" ===============================
" レジスタ制御（d/c/x をブラックホールに）
" ===============================

" --- ビジュアルモードの貼り付けでレジスタを汚さない ---
xnoremap p "_dP

" --- d: ブラックホールレジスタ ---
nnoremap <silent> d "_d
xnoremap <silent> d "_d
nnoremap <silent> D "_D

" <leader>d で通常挙動（切り取り）
nnoremap <silent> <leader>d "dd
xnoremap <silent> <leader>d "dd
nnoremap <silent> <leader>D "dD

" --- c: ブラックホールレジスタ ---
nnoremap <silent> c "_c
xnoremap <silent> c "_c
nnoremap <silent> C "_C

" <leader>c で通常挙動
nnoremap <silent> <leader>c "cc
xnoremap <silent> <leader>c "cc
nnoremap <silent> <leader>C "cC

" --- x: ブラックホールレジスタ ---
nnoremap <silent> x "_x
xnoremap <silent> x "_x
nnoremap <silent> X "_X

" <leader>x で通常挙動
nnoremap <silent> <leader>x ""x
xnoremap <silent> <leader>x ""x
nnoremap <silent> <leader>X ""X

" --- WSL: ビジュアルモードでクリップボードから貼り付け ---
if executable('powershell.exe')
  xnoremap <silent> p :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>gv"_dP
endif
