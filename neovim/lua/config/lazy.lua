-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap + configure lazy.nvim. Importing "plugins" auto-loads every file
-- in lua/plugins/ as a plugin spec.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false }, -- use latest git unless pinned
  install = { colorscheme = { "tokyonight-moon", "habamax" } },
  checker = { enabled = true, notify = false },  -- auto-check updates quietly
  change_detection = { notify = false },
  performance = {
    rtp = {
      -- Disable some unused builtin plugins
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
        "netrwPlugin",
      },
    },
  },
  ui = { border = "rounded" },
})
