-- toggletermの設定
require("toggleterm").setup{
  size = 15,               -- 高さ（horizontal時）
  open_mapping = [[<C-t>]], -- トグルキー
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,

  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,

  persist_size = true,
  persist_mode = true,

  direction = "float",     -- ← 最初はfloat推奨
  close_on_exit = true,
}

