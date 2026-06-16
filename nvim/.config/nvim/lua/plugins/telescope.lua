-- Telescope本体の読み込み
local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- 基本設定
telescope.setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      ".git/",
    },
  },
  pickers = {
    find_files = {
      hidden = true,  -- dotfileも検索
    },
  },
}

-- キーマップ
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
