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
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- SSH box: no local X/Wayland display for xclip/xsel to reach, so use OSC 52
-- instead — it tunnels yanks through the terminal's escape codes back to
-- your *local* machine's clipboard. Requires an OSC-52-capable terminal
-- (kitty, WezTerm, iTerm2, Windows Terminal, tmux with allow-passthrough...).
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Disable didChangeWatchedFiles dynamic registration for all LSP servers
vim.lsp.config("*", {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
      },
    },
  },
})
