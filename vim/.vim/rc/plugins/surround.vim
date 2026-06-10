" ===============================
" vim-surround 設定
" ===============================

" デフォルトで以下が使える:
"   cs"'   → " を ' に変更
"   ds"    → " を削除
"   ysiw"  → カーソル下の単語を " で囲む
"   S"     → ビジュアル選択を " で囲む

" --- おすすめ設定 ---
" ビジュアルモードで s で囲む（デフォルトの S に加えて）
xmap s <Plug>VSurround

" カスタムサラウンド: e で erb タグ (<%= %>)
" autocmd FileType eruby let b:surround_{char2nr('e')} = "<%= \r %>"

" カスタムサラウンド: Markdown コードブロック
let g:surround_{char2nr('c')} = "```\n\r\n```"
