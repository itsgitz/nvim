return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Use precompiled parser binaries
    require("nvim-treesitter.install").prefer_git = false

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
      "zig",
      "rust",
      "ron",
      "prisma",
      "svelte",
    }

    -- Disable treesitter highlighting for large files (monorepo-friendly)
    opts.highlight = { enable = true }
    opts.highlight.disable = opts.highlight.disable or {}
    table.insert(opts.highlight.disable, "powershell")

    -- Disable incremental parsing in large monorepos
    opts.incremental_selection = { enable = false }
  end,
}
