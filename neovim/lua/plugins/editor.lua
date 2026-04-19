-- ~/.config/nvim/lua/plugins/editor.lua
-- Snacks is the kitchen-sink plugin: picker, explorer, dashboard, notifier,
-- terminal, indent, lazygit, words, scroll, statuscolumn, bigfile, etc.
-- Plus: oil.nvim (buffer-style file editing), which-key v3, todo-comments.

return {
  ---------------------------------------------------------------------------
  -- folke/snacks.nvim — kitchen-sink QoL
  ---------------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile     = { enabled = true },
      quickfile   = { enabled = true },
      input       = { enabled = true },
      notifier    = { enabled = true, timeout = 3000, style = "compact" },
      picker      = { enabled = true, layout = { preset = "default" }, sources = { explorer = { hidden = true } } },
      explorer    = { enabled = true },
      indent      = { enabled = true },
      scope       = { enabled = true },
      scroll      = { enabled = true },
      statuscolumn= { enabled = true },
      words       = { enabled = true },
      terminal    = {},
      lazygit     = { enabled = true },
      zen         = { enabled = true },
      rename      = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File",      action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File",       action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text",      action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files",   action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config",         action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy",           action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",           action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    keys = {
      -- Pickers (primary fuzzy finder)
      { "<leader><space>", function() Snacks.picker.smart() end,               desc = "Smart find files" },
      { "<leader>ff",      function() Snacks.picker.files() end,                desc = "Find files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,            desc = "Find git files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,               desc = "Recent files" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find config file" },
      { "<leader>/",       function() Snacks.picker.grep() end,                 desc = "Grep" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                 desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,            desc = "Grep word", mode = { "n", "x" } },
      { "<leader>sh",      function() Snacks.picker.help() end,                 desc = "Help" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,              desc = "Keymaps" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,   desc = "Buffer diagnostics" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,          desc = "LSP symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP workspace symbols" },
      { "<leader>sr",      function() Snacks.picker.resume() end,               desc = "Resume" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,      desc = "Command history" },
      { "<leader>sC",      function() Snacks.picker.commands() end,             desc = "Commands" },
      { "<leader>:",       function() Snacks.picker.commands() end,             desc = "Commands" },
      { "<leader>,",       function() Snacks.picker.buffers() end,              desc = "Buffers" },

      -- LSP navigation via picker (nicer than builtin tagstack UX)
      { "gd",              function() Snacks.picker.lsp_definitions() end,      desc = "Definition" },
      { "gr",              function() Snacks.picker.lsp_references() end,       desc = "References", nowait = true },
      { "gI",              function() Snacks.picker.lsp_implementations() end,  desc = "Implementations" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end, desc = "Type definition" },

      -- Explorer
      { "<leader>e",       function() Snacks.explorer() end,                    desc = "File explorer" },

      -- Git
      { "<leader>gg",      function() Snacks.lazygit() end,                     desc = "Lazygit" },
      { "<leader>gB",      function() Snacks.gitbrowse() end,                   desc = "Git browse (open in browser)" },
      { "<leader>gl",      function() Snacks.lazygit.log() end,                 desc = "Lazygit log" },
      { "<leader>gf",      function() Snacks.picker.git_log_file() end,         desc = "File history" },

      -- UI toggles / misc
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,         desc = "Colorschemes" },
      { "<leader>n",       function() Snacks.notifier.show_history() end,       desc = "Notification history" },
      { "<leader>un",      function() Snacks.notifier.hide() end,               desc = "Dismiss notifications" },
      { "<leader>z",       function() Snacks.zen() end,                         desc = "Zen mode" },
      { "<leader>.",       function() Snacks.scratch() end,                     desc = "Toggle scratch buffer" },

      -- Terminal
      { "<c-/>",           function() Snacks.terminal() end,                    desc = "Terminal", mode = { "n", "t" } },
      { "<c-_>",           function() Snacks.terminal() end,                    desc = "which_key_ignore", mode = { "n", "t" } },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Toggle helpers registered with which-key
          Snacks.toggle.option("spell",          { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap",           { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- oil.nvim — edit directories like buffers
  ---------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = false,   -- keep snacks.explorer as default
      view_options = { show_hidden = true },
      keymaps = {
        ["g?"]     = "actions.show_help",
        ["<CR>"]   = "actions.select",
        ["<C-s>"]  = { "actions.select", opts = { vertical = true } },
        ["<C-h>"]  = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"]  = { "actions.select", opts = { tab = true } },
        ["<C-p>"]  = "actions.preview",
        ["<C-c>"]  = "actions.close",
        ["<C-l>"]  = "actions.refresh",
        ["-"]      = "actions.parent",
        ["_"]      = "actions.open_cwd",
        ["`"]      = "actions.cd",
        ["~"]      = { "actions.cd", opts = { scope = "tab" } },
        ["gs"]     = "actions.change_sort",
        ["gx"]     = "actions.open_external",
        ["g."]     = "actions.toggle_hidden",
      },
    },
    keys = {
      { "-",          "<cmd>Oil<cr>",       desc = "Open parent directory (oil)" },
      { "<leader>fe", "<cmd>Oil<cr>",       desc = "Oil (buffer-style explorer)" },
      { "<leader>fE", "<cmd>Oil --float<cr>", desc = "Oil (floating)" },
    },
  },

  ---------------------------------------------------------------------------
  -- which-key v3
  ---------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 200,
      icons = { mappings = vim.g.have_nerd_font ~= false },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui/toggle" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)" },
    },
  },

  ---------------------------------------------------------------------------
  -- todo-comments — find TODO/FIXME/NOTE across project
  ---------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todos" },
    },
  },
}
