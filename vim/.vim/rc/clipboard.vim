" ===============================
" クリップボード連携 (WSL)
" ===============================

set clipboard=unnamedplus

if executable('powershell.exe')
  " yank 時に自動で Windows クリップボードへコピー
  augroup YankToClip
    autocmd!
    autocmd TextYankPost *
    \ if v:event.operator ==# 'y' |
    \ call system('clip.exe', getreg(v:event.regname ==# '' ? '"' : v:event.regname)) |
    \ endif
  augroup END

  " p / P で Windows クリップボードから貼り付け（通常モード）
  nnoremap <silent> p :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>p
  nnoremap <silent> P :let @"=substitute(system('powershell.exe -NoProfile -Command Get-Clipboard'), '\r\n\?', '\n', 'g')<CR>P
endif
