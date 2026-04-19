-- ~/.config/nvim/lsp/basedpyright.lua
return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,   -- ruff handles imports
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",    -- change to "workspace" for big mono-repos
        typeCheckingMode = "standard",       -- basic | standard | strict | all
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = false,
        },
      },
    },
  },
}
