-- ~/.config/nvim/lua/plugins/coding.lua
-- Surround only. Built-in `gc`/`gcc` (Neovim 0.10+) handles comments.

return {
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {},
  },
}
