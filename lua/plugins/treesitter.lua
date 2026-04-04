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
      "tsx",
      "astro",
      "json",
      "yaml",
      "php",
      "go",
      "html",
      "python",
      "blade",
      "vue",
      "css",
      "c",
      "cpp",
      "bash",
      "graphql",
      "json",
      "zig",
      "rust",
      "ron",
    }

    -- Disable treesitter highlighting for large files (monorepo-friendly)
    opts.highlight = { enable = true }
    opts.highlight.disable = opts.highlight.disable or {}
    table.insert(opts.highlight.disable, "powershell")

    -- Reduce parser count for monorepo (remove slow/unused parsers)
    opts.ensure_installed = {
      "lua",
      "typescript",
      "javascript",
      "tsx",
      "json",
      "yaml",
      "html",
      "bash",
    }

    -- Disable incremental parsing in large monorepos
    opts.incremental_selection = { enable = false }
  end,
}
