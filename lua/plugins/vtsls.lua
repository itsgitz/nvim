return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          tsserver = {
            maxTsServerMemory = 8092,
          },
        },
      },
    },
  },
}
