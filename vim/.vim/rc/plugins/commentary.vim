" ===============================
" vim-commentary 設定
" ===============================

" デフォルトで gcc（行コメント）と gc{motion}（範囲コメント）が使える
" 以下はおすすめの追加設定

" --- おすすめキーマップ ---
" <Leader>/ でトグルコメント（gcc の代替）
nmap <Leader>/ gcc
xmap <Leader>/ gc

" --- ファイルタイプ別コメント文字設定 ---
augroup CommentaryFileTypes
  autocmd!
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd FileType sh setlocal commentstring=#\ %s
  autocmd FileType vim setlocal commentstring=\"\ %s
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType javascript setlocal commentstring=//\ %s
  autocmd FileType typescript setlocal commentstring=//\ %s
augroup END
