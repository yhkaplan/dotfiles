-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- tokyonight only. If you want to switch, `:colorscheme <name>` still works for
-- anything else installed later via lazy.

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
}
