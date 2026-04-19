-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Six themes installed in parallel. Switch live with `<leader>uC` (snacks
-- picker) or via `:colorscheme <name>`. Default is tokyonight-moon — change
-- the `vim.cmd.colorscheme(...)` call below to your preferred default.

return {
  -- Tokyo Night (default) — night / storm / moon / day
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
      vim.cmd.colorscheme("tokyonight-moon")   -- <— change default here
    end,
  },

  -- Catppuccin — latte / frappe / macchiato / mocha
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        native_lsp = { enabled = true, inlay_hints = { background = true } },
        snacks = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  -- Rosé Pine — main / moon / dawn
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    opts = {
      variant = "auto",
      dark_variant = "main",
      styles = { italic = false },
    },
  },

  -- Kanagawa — wave / dragon / lotus
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = { theme = "wave", background = { dark = "wave", light = "lotus" } },
  },

  -- Gruvbox Material — medium/hard/soft × dark/light
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },

  -- Nightfox — nightfox / carbonfox / dayfox / duskfox / nordfox / terafox
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
    opts = { options = { styles = { comments = "italic" } } },
  },
}
