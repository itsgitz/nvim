return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      intelephense = {
        settings = {
          intelephense = {
            environment = {
              phpVersion = "8.1",
            },
            files = {
              maxSize = 5000000, -- optional: increase max file size if needed
            },
          },
        },
      },
    },
  },
}
