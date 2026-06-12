-- ===============================
-- クリップボード連携 (WSL)
-- ===============================

vim.opt.clipboard = "unnamedplus"

if vim.fn.executable("powershell.exe") == 1 then
  -- yank 時に自動で Windows クリップボードへコピー
  vim.api.nvim_create_augroup("YankToClip", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = "YankToClip",
    callback = function()
      if vim.v.event.operator == "y" then
        local regname = vim.v.event.regname == "" and '"' or vim.v.event.regname
        vim.fn.system("clip.exe", vim.fn.getreg(regname))
      end
    end,
  })

  -- p / P で Windows クリップボードから貼り付け（通常モード）
  vim.keymap.set("n", "p", function()
    local text = vim.fn.substitute(
      vim.fn.system("powershell.exe -NoProfile -Command Get-Clipboard"),
      "\r\n\\?", "\n", "g"
    )
    vim.fn.setreg('"', text)
    vim.api.nvim_feedkeys("p", "n", false)
  end, { silent = true })

  vim.keymap.set("n", "P", function()
    local text = vim.fn.substitute(
      vim.fn.system("powershell.exe -NoProfile -Command Get-Clipboard"),
      "\r\n\\?", "\n", "g"
    )
    vim.fn.setreg('"', text)
    vim.api.nvim_feedkeys("P", "n", false)
  end, { silent = true })
end
