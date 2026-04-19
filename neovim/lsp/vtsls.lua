-- ~/.config/nvim/lsp/vtsls.lua
return {
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
  },
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        parameterNames          = { enabled = "literals", suppressWhenArgumentMatchesName = true },
        parameterTypes          = { enabled = true },
        variableTypes           = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues        = { enabled = true },
      },
      preferences = { importModuleSpecifier = "non-relative" },
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      inlayHints = {
        parameterNames          = { enabled = "literals", suppressWhenArgumentMatchesName = true },
        parameterTypes          = { enabled = true },
        variableTypes           = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues        = { enabled = true },
      },
    },
  },
}
