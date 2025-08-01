return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Use precompiled parser binaries
    require("nvim-treesitter.install").prefer_git = false

    -- Optional: reduce number of parsers
    opts.ensure_installed = {
      "lua",
      "typescript",
      "javascript",
      "json",
      "yaml",
      "php",
      "go",
      "html",
      "python",
    }

    opts.highlight = { enable = true }
  end,
}
