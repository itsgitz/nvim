return {
  "LunarVim/bigfile.nvim",
  opts = {
    filesize = 1, -- 1 MiB threshold
    bigfile_disable_features = {
      "lsp",
      "treesitter",
      "syntax",
      "indent_blankline",
      "vimopts",
    },
  },
}
