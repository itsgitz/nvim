return {
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    opts = {
      -- Custom configuration (see step 3)
      settings = {
        tsserver_path = "", -- Auto-detect tsserver
        complete_function_calls = false, -- Faster completion
        expose_as_code_action = "all", -- Optional
        -- Disable inlay hints (improves performance)
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "none",
          includeInlayVariableTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
        },
        tsserver_format_options = {
          insertSpaceAfterCommaDelimiter = true,
          insertSpaceAfterConstructor = false,
          -- ... other format options
        },
        -- Memory and performance settings
        tsserver_max_memory = 8192, -- MB (adjust based on your system)
        separate_diagnostic_server = true, -- Better perf for diagnostics
        publish_diagnostic_on = "insert_leave", -- Reduce diagnostic frequency
      },
      on_attach = function(client, bufnr)
        -- Custom keymaps here (optional)
        local map = vim.keymap.set
        map("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>", { buffer = bufnr, desc = "Organize Imports" })
      end,
    },
  },
}
