" ===============================
" vim-current-word 設定
" ===============================

" --- おすすめ設定 ---
" ハイライトの有効/無効
let g:vim_current_word#enabled = 1

" カーソル下の単語のハイライト色
hi CurrentWord      ctermbg=236 guibg=#3a3a3a
hi CurrentWordTwins ctermbg=237 guibg=#2a2a2a

" 遅延時間（ms）- カーソル移動後にハイライトするまでの待機
let g:vim_current_word#delay_ms = 50

" 特定のファイルタイプでは無効化
let g:vim_current_word#excluded_filetypes = ['NvimTree', 'help', 'qf']

" キーマップ: トグル
nnoremap <Leader>tw :VimCurrentWordToggle<CR>
