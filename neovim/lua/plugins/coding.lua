-- ~/.config/nvim/lua/plugins/coding.lua
-- Auto-pairs, surround, treesitter-aware comments.

return {
  -- Auto-pairs: treesitter-aware
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },

  -- Surround: ys{motion}{char}, ds{char}, cs{old}{new}
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {},
  },

  -- Treesitter-aware commentstrings for JSX/TSX/Vue/Svelte.
  -- Uses Neovim 0.10+'s built-in `gc`/`gcc` — Comment.nvim is NOT needed.
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  -- Smarter `f`/`t` — multi-line, repeats with `;`/`,`
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "TS search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle flash in cmdline search" },
    },
  },
}
