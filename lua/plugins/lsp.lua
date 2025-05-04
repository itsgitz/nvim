return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        enabled = false, -- Disable default tsserver
      },
      vtsls = {
        enabled = false,
      },
      ts_ls = {
        enabled = false,
      },
    },
  },
}
