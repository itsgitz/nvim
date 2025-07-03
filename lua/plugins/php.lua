return {
  -- {
  --   "stevearc/conform.nvim",
  --   lazy = true,
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local conform = require("conform")
  --
  --     conform.setup({
  --       formatters_by_ft = {
  --         php = { "phpcbf" }, -- ✅ Use phpcbf
  --       },
  --       format_on_save = {
  --         lsp_fallback = true,
  --         async = false,
  --         timeout_ms = 1000,
  --       },
  --       notify_on_error = true,
  --       formatters = {
  --         phpcbf = {
  --           command = "phpcbf",
  --           args = { "$FILENAME" },
  --           stdin = false,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    -- Remove phpcs linter.
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "php_only",
      })
    end,
    config = function(_, opts)
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
  },
  {
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    ft = { "blade", "php" },
  },
}
