-- ===============================
-- vim-commentary 設定
-- ===============================

local map = vim.keymap.set

-- <Leader>/ でトグルコメント（gcc の代替）
map("n", "<Leader>/", "gcc", { remap = true })
map("x", "<Leader>/", "gc", { remap = true })

-- --- ファイルタイプ別コメント文字設定 ---
vim.api.nvim_create_augroup("CommentaryFileTypes", { clear = true })
local ft_comments = {
  python     = "# %s",
  sh         = "# %s",
  vim        = '" %s',
  ruby       = "# %s",
  javascript = "// %s",
  typescript = "// %s",
}

for ft, cs in pairs(ft_comments) do
  vim.api.nvim_create_autocmd("FileType", {
    group   = "CommentaryFileTypes",
    pattern = ft,
    callback = function()
      vim.opt_local.commentstring = cs
    end,
  })
end
