-- ~/.config/nvim/lua/plugins/lsp.lua
-- Modern pipeline: Mason installs binaries → mason-lspconfig auto-enables
-- servers via vim.lsp.enable() → per-server configs live in ~/.config/nvim/lsp/
-- (picked up automatically by Neovim 0.11+).

return {
  -- Mason v2 — package manager for LSPs, DAPs, linters, formatters
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded", icons = {
        package_installed = "✓", package_pending = "➜", package_uninstalled = "✗",
      } },
    },
  },

  -- mason-tool-installer: install non-LSP tooling (formatters, linters, DAPs)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- formatters
        "stylua", "prettierd", "shfmt",
        -- linters
        "eslint_d", "markdownlint-cli2", "shellcheck",
        -- python (ruff LSP covers lint+format; basedpyright separately)
        -- swift: `swift-format` and `swiftlint` come from brew; Mason can't reliably install them
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    },
  },

  -- mason-lspconfig v2: bridges Mason ↔ nvim-lspconfig using vim.lsp.enable()
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",   -- ships lsp/<server>.lua defaults
      "saghen/blink.cmp",        -- registers capabilities globally
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "basedpyright",
        "ruff",
        "vtsls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "marksman",       -- markdown
        "bashls",
        -- Note: sourcekit-lsp is NOT installable by Mason — it ships with
        -- Xcode / the Swift toolchain. See lsp/sourcekit.lua.
      },
      automatic_enable = true,  -- runs vim.lsp.enable() for every installed server
    },
  },

  -- nvim-lspconfig: used purely for the lsp/<server>.lua defaults it ships.
  -- Our per-server overrides live in ~/.config/nvim/lsp/ and in the config()
  -- below via vim.lsp.config().
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Diagnostics UI
      vim.diagnostic.config({
        severity_sort = true,
        underline = { severity = vim.diagnostic.severity.ERROR },
        update_in_insert = false,
        virtual_text = {
          spacing = 4, source = "if_many", prefix = "●",
          severity = { min = vim.diagnostic.severity.HINT },
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
          },
        },
        float = { border = "rounded", source = "if_many" },
      })

      -- Global defaults applied to every server
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      -- Always-enabled servers that aren't from Mason (e.g., sourcekit-lsp
      -- from the Swift toolchain). automatic_enable from mason-lspconfig
      -- only enables what Mason installed.
      vim.lsp.enable("sourcekit")

      -- Buffer-local keymaps + per-client tweaks on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
          end

          -- Navigation (Neovim 0.11+ provides grr/gra/grn/gri/gO by default)
          map("n", "gd",       vim.lsp.buf.definition,       "Go to definition")
          map("n", "gD",       vim.lsp.buf.declaration,      "Go to declaration")
          map("n", "gy",       vim.lsp.buf.type_definition,  "Go to type definition")
          map("n", "K",        vim.lsp.buf.hover,            "Hover")
          map("n", "<leader>cr", vim.lsp.buf.rename,         "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cl", "<cmd>LspInfo<cr>",         "LSP info")

          -- Inlay hints (toggle per buffer)
          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            map("n", "<leader>uh", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
              )
            end, "Toggle inlay hints")
          end

          -- ruff: let basedpyright own hover
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          -- Highlight references under cursor (snacks.words also does this
          -- with better UX; kept here as a fallback)
          if client:supports_method("textDocument/documentHighlight") and not package.loaded["snacks"] then
            local hl = vim.api.nvim_create_augroup("lsp_document_highlight." .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              group = hl, buffer = bufnr, callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = hl, buffer = bufnr, callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },

  -- Nicer notifications during LSP progress messages, workspace indexing, etc.
  -- snacks.notifier picks these up automatically, so no extra config needed.

  -- lazydev: superfast Lua LSP for Neovim config editing (replaces
  -- neodev.nvim). Registers a blink.cmp source for vim.* API completion.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
