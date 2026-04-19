-- ~/.config/nvim/lua/plugins/formatting.lua
-- conform.nvim for formatting, nvim-lint for linters the LSP can't do.

return {
  -- conform.nvim — formatter runner
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" }, desc = "Format" },
    },
    opts = {
      default_format_opts = { timeout_ms = 3000, async = false, quiet = false, lsp_format = "fallback" },
      formatters_by_ft = {
        lua              = { "stylua" },
        python           = { "ruff_organize_imports", "ruff_format" },
        javascript       = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact  = { "prettierd", "prettier", stop_after_first = true },
        typescript       = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact  = { "prettierd", "prettier", stop_after_first = true },
        json             = { "prettierd", "prettier", stop_after_first = true },
        jsonc            = { "prettierd", "prettier", stop_after_first = true },
        yaml             = { "prettierd", "prettier", stop_after_first = true },
        markdown         = { "prettierd", "prettier", stop_after_first = true },
        html             = { "prettierd", "prettier", stop_after_first = true },
        css              = { "prettierd", "prettier", stop_after_first = true },
        scss             = { "prettierd", "prettier", stop_after_first = true },
        sh               = { "shfmt" },
        bash             = { "shfmt" },
        zsh              = { "shfmt" },
        swift            = { "swift_format" },   -- or "swiftformat"
      },
      format_on_save = function(bufnr)
        -- Disable per-buffer with `:lua vim.b.disable_autoformat = true`
        -- or globally with `:lua vim.g.disable_autoformat = true`.
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 1500, lsp_format = "fallback" }
      end,
      formatters = {
        -- If Apple's swift-format isn't on PATH, xcrun it (ships with Xcode).
        swift_format = {
          command = "swift-format",
          args = { "--configuration", ".swift-format", "--" },
          stdin = true,
          cwd = function(_, ctx)
            local found = vim.fs.find({ ".swift-format" }, { upward = true, path = ctx.dirname })[1]
            return found and vim.fs.dirname(found) or nil
          end,
          require_cwd = false,
        },
      },
    },
    init = function()
      -- Autoformat toggles
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then vim.b.disable_autoformat = true
        else               vim.g.disable_autoformat = true end
      end, { desc = "Disable autoformat-on-save", bang = true })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat-on-save" })
    end,
  },

  -- nvim-lint — linters that aren't covered by LSPs
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        markdown        = { "markdownlint-cli2" },
        sh              = { "shellcheck" },
        bash            = { "shellcheck" },
        -- python: ruff LSP handles all diagnostics; no separate linter.
        -- swift: swiftlint run separately (via xcodebuild.nvim) works better.
      }
      local grp = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = grp,
        callback = function()
          if vim.bo.buftype ~= "" then return end
          require("lint").try_lint()
        end,
      })
    end,
  },
}
