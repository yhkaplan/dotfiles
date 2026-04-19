-- ~/.config/nvim/lua/plugins/telescope.lua
-- Telescope is optional — snacks.picker (see editor.lua) is the primary
-- picker. Telescope is included because xcodebuild.nvim integrates with it
-- and because its ecosystem of extensions (live-grep-args, frecency) is
-- still the richest. If you don't need those, you can delete this file.

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      -- Telescope-specific entry points (most users will use <leader><space>
      -- etc. from snacks.picker instead). Kept here so xcodebuild.nvim pickers
      -- have a familiar home.
      { "<leader>fT", "<cmd>Telescope<cr>", desc = "Telescope" },
    },
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top", horizontal = { preview_width = 0.55 } },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
  },
}
