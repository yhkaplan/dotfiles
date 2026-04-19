-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Uses the `main` branch rewrite (Neovim 0.12+ required). The repo was
-- archived April 2026; `main` is stable and feature-complete for parser
-- management. Highlight is enabled via a FileType autocmd (no more
-- `highlight = { enable = true }`).

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function() require("nvim-treesitter").update() end,
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local ensure = {
        "bash", "c", "cpp", "css", "diff", "dockerfile", "gitcommit",
        "gitignore", "html", "javascript", "json", "jsonc", "lua", "luadoc",
        "markdown", "markdown_inline", "python", "query", "regex", "swift",
        "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
      }
      require("nvim-treesitter").install(ensure)

      -- Enable highlight + indent + folds for relevant filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_ts_start", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang then return end
          local ok = pcall(vim.treesitter.start, ev.buf, lang)
          if not ok then return end
          -- Treesitter-based folds
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
          -- Treesitter-based indent (experimental; comment out if it misbehaves)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Treesitter-aware text objects: af/if (function), ac/ic (class), aa/ia (parameter)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { { "nvim-treesitter/nvim-treesitter", branch = "main" } },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"]  = "V",
            ["@class.outer"]     = "<c-v>",
          },
          include_surrounding_whitespace = false,
        },
        move = { set_jumps = true },
      })
      local sel = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      vim.keymap.set({ "x", "o" }, "af", function() sel.select_textobject("@function.outer",  "textobjects") end)
      vim.keymap.set({ "x", "o" }, "if", function() sel.select_textobject("@function.inner",  "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ac", function() sel.select_textobject("@class.outer",     "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ic", function() sel.select_textobject("@class.inner",     "textobjects") end)
      vim.keymap.set({ "x", "o" }, "aa", function() sel.select_textobject("@parameter.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ia", function() sel.select_textobject("@parameter.inner", "textobjects") end)

      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class" })
    end,
  },

  -- Sticky scope at top of window (function/class header stays visible)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = { max_lines = 3, multiline_threshold = 1 },
    keys = {
      { "<leader>ut", "<cmd>TSContextToggle<cr>", desc = "Toggle TS context" },
    },
  },

  -- Auto-close/rename JSX/HTML tags
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
}
