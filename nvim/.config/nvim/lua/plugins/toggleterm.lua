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

-- =====================
-- lazygit（float）
-- =====================
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
})

-- キーマップは core/keymaps.lua に集約。
-- lazygit のトグルは外部から呼び出せるよう公開する。
return {
  lazygit_toggle = function()
    lazygit:toggle()
  end,
}
