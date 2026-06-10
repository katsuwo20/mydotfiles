" ===============================
" vim-easymotion 設定
" ===============================

" --- 基本キーマップ ---
nmap <Leader>w <Plug>(easymotion-w)
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>s <Plug>(easymotion-s)

" --- おすすめ設定 ---
let g:EasyMotion_smartcase = 1         " smartcase で検索
let g:EasyMotion_do_mapping = 0        " デフォルトマッピング無効化（自前で定義）
let g:EasyMotion_enter_jump_first = 1  " Enter で最初の候補にジャンプ
let g:EasyMotion_space_jump_first = 1  " Space でも最初の候補にジャンプ

" 2文字検索（s の2文字版）
nmap <Leader>S <Plug>(easymotion-s2)

" 行内移動
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>h <Plug>(easymotion-linebackward)

" 行ジャンプ
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
