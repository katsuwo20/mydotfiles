-- ===============================
-- vim-surround 設定
-- ===============================

-- ビジュアルモードで s で囲む（デフォルトの S に加えて）
vim.keymap.set("x", "s", "<Plug>VSurround")

-- カスタムサラウンド: Markdown コードブロック（c キー）
vim.g["surround_" .. string.byte("c")] = "```\n\r\n```"


-- スペースありなしを逆転
-- {}
vim.g["surround_" .. string.byte("{")] = "{\r}"
vim.g["surround_" .. string.byte("}")] = "{ \r }"

-- ()
vim.g["surround_" .. string.byte("(")] = "(\r)"
vim.g["surround_" .. string.byte(")")] = "( \r )"

-- []
vim.g["surround_" .. string.byte("[")] = "[\r]"
vim.g["surround_" .. string.byte("]")] = "[ \r ]"
