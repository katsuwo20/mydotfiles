-- ===============================
-- vim-surround 設定
-- ===============================

-- ビジュアルモードで s で囲むキーマップは core/keymaps.lua に集約。

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
