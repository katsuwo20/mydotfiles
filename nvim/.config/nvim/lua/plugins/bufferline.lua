
require("bufferline").setup({
  highlights = {
    -- 選択中バッファを太字 + 下線で見分けやすくする
    buffer_selected = {
      bold = true,
      italic = false,
    },
    indicator_selected = {
      bold = true,
    },
  },
  options = {
    numbers = "none", -- 番号表示しない
    close_command = "bdelete! %d", -- バッファ削除
    right_mouse_command = "bdelete! %d",
    indicator = {
      style = "underline", -- 選択中バッファに下線を表示
    },
    buffer_close_icon = "x",
    modified_icon = "*",
    close_icon = "X",
    show_close_icon = false,
    show_buffer_close_icons = true,

    diagnostics = "nvim_lsp", -- LSP連携

    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },

    separator_style = "slant", -- VSCodeっぽい見た目
    always_show_bufferline = true,
  },
})

-- キーマップは core/keymaps.lua に集約。
local function close_current_buffer_keep_nvim()
  local current = vim.api.nvim_get_current_buf()
  local force_delete = false

  -- 未保存の変更がある場合は、保存せず閉じるか確認する
  if vim.api.nvim_buf_is_valid(current) and vim.bo[current].modified then
    local choice = vim.fn.confirm("保存されていない変更があります。保存せずに削除しますか？", "&Yes\n&No", 2)
    if choice ~= 1 then
      return
    end
    force_delete = true
  end

  local listed_file_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == "" then
      table.insert(listed_file_buffers, buf)
    end
  end

  -- 最後の1枚を閉じるときは空バッファを先に作って、:q 相当の終了を防ぐ
  if #listed_file_buffers <= 1 then
    vim.cmd("enew")
  else
    pcall(vim.cmd, "BufferLineCycleNext")
  end

  local delete_cmd = force_delete and "bdelete! " or "bdelete "
  local ok, err = pcall(vim.cmd, delete_cmd .. current)
  if not ok and err then
    vim.notify(tostring(err), vim.log.levels.WARN)
  end
end

-- 現在のバッファを閉じる処理は外部から呼び出せるよう公開する。
return {
  close_current_buffer = close_current_buffer_keep_nvim,
}
