-- Wire up LazyVim's built-in language extras for languages that were only
-- half-configured before (LSP flags/treesitter parsers with no server actually
-- registered). See lua/config/options.lua for the vim.g.lazyvim_* overrides
-- these extras read (php -> intelephense, rust -> rust-analyzer diagnostics).
return {
  { import = "lazyvim.plugins.extras.lang.php" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.svelte" },
}
