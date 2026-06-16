
require("bufferline").setup {
  options = {
    numbers = "none",              -- 番号表示しない
    close_command = "bdelete! %d", -- バッファ削除
    right_mouse_command = "bdelete! %d",
    indicator = {
      style = "icon",              -- 選択中の印
    },
    buffer_close_icon = "x",
    modified_icon = "*",
    close_icon = "X",
    show_close_icon = false,
    show_buffer_close_icons = true,

    diagnostics = "nvim_lsp",      -- LSP連携（後で効く）

    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    },

    separator_style = "slant",     -- VSCodeっぽく
    always_show_bufferline = true,
  }
}


-- keymaps --
-- buffer移動
vim.keymap.set("n", "<leader>n",   ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>")
