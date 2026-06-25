vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false,
})

vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)")
vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)")
vim.keymap.set("i", "<C-w>", "<Plug>(copilot-accept-word)")
vim.keymap.set("i", "<C-j>", "<Plug>(copilot-accept-word)")

-- インライン補完を無効化ファイルタイプのリスト
vim.g.copilot_filetypes = {
  markdown = false,
  text = false,
  log = false,
}
