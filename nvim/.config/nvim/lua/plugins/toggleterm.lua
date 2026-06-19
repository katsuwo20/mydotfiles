local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =====================
-- toggleterm
-- =====================
require("toggleterm").setup({
  open_mapping = [[<C-t>]], -- fallback（使わなくてもOK）
  direction = "horizontal",

  size = function(term)
    if term.direction == "horizontal" then
      return math.floor(vim.o.lines * 0.25)
    end
  end,

  start_in_insert = true,
  persist_mode = true,
  persist_size = true,
})

-- 1番terminal固定
map("n", "<C-t>", "<cmd>1ToggleTerm<CR>", opts)
map("t", "<C-t>", [[<C-\><C-n><cmd>1ToggleTerm<CR>]], opts)

-- =====================
-- terminal操作改善
-- =====================
-- terminal → normal
map("t", "<Esc>", [[<C-\><C-n>]], opts)

-- =====================
-- lazygit（float）
-- =====================
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
})

map("n", "<leader>lg", function() lazygit:toggle() end, opts)
