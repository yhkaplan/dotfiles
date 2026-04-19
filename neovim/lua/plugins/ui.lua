-- ~/.config/nvim/lua/plugins/ui.lua
-- Statusline, bufferline, cmdline/message UI. Dashboard + notifier are
-- handled by snacks.nvim (see editor.lua).

return {
  -- Web devicons (dependency for many UI plugins)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- lualine — statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "   -- avoid flicker on startup
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
            { function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end, },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = { function() return " " .. os.date("%R") end },
        },
        extensions = { "lazy", "quickfix", "trouble", "man", "oil" },
      }
    end,
  },

  -- Bufferline — tabs for buffers
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Pin buffer" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete unpinned" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",          desc = "Delete other buffers" },
      { "<leader>br", "<cmd>BufferLineCloseRight<cr>",           desc = "Delete buffers to the right" },
      { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>",            desc = "Delete buffers to the left" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    },
    opts = {
      options = {
        close_command = function(n) require("snacks").bufdelete(n) end,
        right_mouse_command = function(n) require("snacks").bufdelete(n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          { filetype = "snacks_layout_box",  text = "Explorer", text_align = "center", separator = true },
          { filetype = "neo-tree",           text = "Explorer", text_align = "center", separator = true },
        },
      },
    },
  },

  -- noice — replaces cmdline / messages / popup menu with a nicer UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = { enabled = false },   -- blink.cmp owns signature help
        hover = { enabled = true },
      },
      routes = {
        { filter = { event = "msg_show", any = { { find = "%d+L, %d+B" }, { find = "; after #%d+" }, { find = "; before #%d+" } } }, view = "mini" },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    keys = {
      { "<leader>sn", "", desc = "+noice" },
      { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end,     desc = "Noice last message" },
      { "<leader>snh", function() require("noice").cmd("history") end,  desc = "Noice history" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,  desc = "Dismiss all" },
    },
  },
}
