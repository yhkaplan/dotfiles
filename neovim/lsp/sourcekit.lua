-- ~/.config/nvim/lsp/sourcekit.lua
-- SourceKit-LSP ships with Xcode / the Swift toolchain.
-- Mason cannot install it; we invoke it via xcrun so the Xcode-selected
-- toolchain's binary is used.
return {
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "swift", "objc", "objcpp" },   -- drop c/cpp to let clangd own them
  root_markers = {
    "buildServer.json",                         -- xcode-build-server output
    "Package.swift",
    "*.xcodeproj", "*.xcworkspace",
    "compile_commands.json",
    ".git",
  },
  get_language_id = function(_, ft)
    local map = { objc = "objective-c", objcpp = "objective-cpp" }
    return map[ft] or ft
  end,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
    textDocument = {
      diagnostic = { dynamicRegistration = true, relatedDocumentSupport = true },
    },
  },
}
