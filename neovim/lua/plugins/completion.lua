-- ~/.config/nvim/lua/plugins/completion.lua
-- blink.cmp — Rust-based completion engine, replaces nvim-cmp.
-- Auto-registers LSP capabilities on Neovim 0.11+, so we don't need to
-- plumb capabilities into every server config.

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",                 -- downloads prebuilt Rust matcher binary
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
      "rafamadriz/friendly-snippets",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' | 'super-tab' | 'enter' | 'none'
      -- 'default' uses C-y to accept (cleanest; doesn't conflict with tab-cycling).
      keymap = { preset = "default" },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = false },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon", "label", "label_description", gap = 1 },
              { "kind" },
            },
          },
        },
      },

      signature = { enabled = true, window = { border = "rounded" } },

      snippets = { preset = "luasnip" },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = { download = true },
      },

      cmdline = { enabled = true, keymap = { preset = "cmdline" } },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      -- Load VSCode-style snippets (friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
