-- ~/.config/nvim/lsp/ruff.lua
-- Modern Ruff uses the built-in `ruff server` command (ruff-lsp was archived).
return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", ".git" },
  init_options = {
    settings = {
      logLevel = "warn",
      -- configurationPreference = "editorFirst",
      -- lineLength = 100,
    },
  },
}
