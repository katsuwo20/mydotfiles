" ===============================
" .vimrc - エントリポイント
" ~/.vim/rc/ 以下の設定ファイルを読み込む
" ===============================

let s:rc_dir = expand('~/.vim/rc')

" --- 基本設定 ---
execute 'source' s:rc_dir . '/basic.vim'

" --- キーマップ ---
execute 'source' s:rc_dir . '/keymaps.vim'

" --- クリップボード ---
execute 'source' s:rc_dir . '/clipboard.vim'

" --- レジスタ制御 ---
execute 'source' s:rc_dir . '/register.vim'

" --- プラグイン設定 ---
for s:plugin_conf in glob(s:rc_dir . '/plugins/*.vim', 0, 1)
  execute 'source' s:plugin_conf
endfor
