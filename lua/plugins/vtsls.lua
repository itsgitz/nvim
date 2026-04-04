return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        root_dir = function(fname)
          local util = require("lspconfig.util")
          -- Prefer Nx project root (project.json) for monorepo scoping
          return util.root_pattern("project.json")(fname) or util.root_pattern("tsconfig.json")(fname)
            or util.find_git_ancestor(fname)
        end,
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
            completeFunctionCalls = false,
            updateImportsOnFileMove = "never",
            implementationsCodeLens = { enabled = false },
            referencesCodeLens = { enabled = false },
            preferences = {
              importModuleSpecifier = "non-relative",
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
            completeFunctionCalls = false,
            updateImportsOnFileMove = "never",
            implementationsCodeLens = { enabled = false },
            referencesCodeLens = { enabled = false },
            preferences = {
              importModuleSpecifier = "non-relative",
            },
          },
          tsserver = {
            maxTsServerMemory = 4096,
            logVerbosity = "off",
            useSeparateSyntaxServer = true,
            watchOptions = {
              dynamicPriorityPolling = true,
              excludeDirectories = {
                "node_modules",
                ".git",
                "dist",
                ".nx",
                "tmp",
                "coverage",
                ".next",
                "out",
              },
            },
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
