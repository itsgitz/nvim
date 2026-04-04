-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable loading of project-local .nvim.lua files (exrc)
vim.opt.exrc = true
vim.opt.secure = false -- ⚠️ ONLY safe in trusted projects

-- vim.env.CC = "zig cc"
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "pyright"

-- Smarty indenting
-- I use this plugin https://github.com/shadowwa/smarty.vim
vim.smarty_indent_block = 1

-- LSP server for Rust
-- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
