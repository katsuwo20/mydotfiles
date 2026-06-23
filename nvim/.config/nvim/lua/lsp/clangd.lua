-- C/C++のLSP設定ファイル

vim.lsp.config["clangd"] = {
  cmd ={ "clangd"},
  filetypes ={
    "c",
    "cpp",
  },
}

vim.lsp.enable("clangd")
