return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = false },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = false },
              variableTypes = { enabled = false },
              propertyDeclarationTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = false },
              enumMemberValues = { enabled = false },
            },
          },
          tsserver = {
            maxTsServerMemory = 4096,
            logVerbosity = "off",
            useSeparateSyntaxServer = false,
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              enableProjectDiagnostics = false,
              completion = {
                enableServerSideFuzzyMatch = false,
              },
            },
          },
        },
      },
    },
  },
}
