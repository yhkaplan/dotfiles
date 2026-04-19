-- ~/.config/nvim/lua/plugins/ui.lua
-- Statusline + devicons. Dashboard + notifier are handled by snacks.nvim.

return {
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus
      return {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
            { "filetype",    icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename",    path = 1, symbols = { modified = "●", readonly = "", unnamed = "" } },
          },
          lualine_x = {
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = { function() return " " .. os.date("%R") end },
        },
        extensions = { "lazy", "quickfix", "man", "oil" },
      }
    end,
  },
}
