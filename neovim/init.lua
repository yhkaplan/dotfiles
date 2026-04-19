-- ~/.config/nvim/init.lua
-- Entry point. Keep this file tiny: load options/keymaps first (so leader
-- is set before lazy.nvim), then bootstrap the plugin manager.

require("config.options")
require("config.keymaps")
require("config.lazy")        -- bootstraps lazy.nvim and imports lua/plugins/*
require("config.autocmds")
