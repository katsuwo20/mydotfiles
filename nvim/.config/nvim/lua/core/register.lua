-- ===============================
-- レジスタ制御（d/c/x をブラックホールに）
-- ===============================

local map = vim.keymap.set

-- --- ビジュアルモードの貼り付けでレジスタを汚さない ---
map("x", "p", '"_dP')

-- --- d: ブラックホールレジスタ ---
map("n", "d", '"_d', { silent = true })
map("x", "d", '"_d', { silent = true })
map("n", "D", '"_D', { silent = true })

-- <leader>d で通常挙動（切り取り）
map("n", "<leader>d", '"dd', { silent = true })
map("x", "<leader>d", '"dd', { silent = true })
map("n", "<leader>D", '"dD', { silent = true })

-- --- c: ブラックホールレジスタ ---
map("n", "c", '"_c', { silent = true })
map("x", "c", '"_c', { silent = true })
map("n", "C", '"_C', { silent = true })

-- <leader>c で通常挙動
map("n", "<leader>c", '"cc', { silent = true })
map("x", "<leader>c", '"cc', { silent = true })
map("n", "<leader>C", '"cC', { silent = true })

-- --- x: ブラックホールレジスタ ---
map("n", "x", '"_x', { silent = true })
map("x", "x", '"_x', { silent = true })
map("n", "X", '"_X', { silent = true })

-- <leader>x で通常挙動
map("n", "<leader>x", '""x', { silent = true })
map("x", "<leader>x", '""x', { silent = true })
map("n", "<leader>X", '""X', { silent = true })

-- --- WSL: ビジュアルモードでクリップボードから貼り付け ---
if vim.fn.executable("powershell.exe") == 1 then
  map("x", "p", function()
    local text = vim.fn.substitute(
      vim.fn.system("powershell.exe -NoProfile -Command Get-Clipboard"),
      "\r\n\\?", "\n", "g"
    )
    vim.fn.setreg('"', text)
    vim.api.nvim_feedkeys('gv"_dP', "n", false)
  end, { silent = true })
end
