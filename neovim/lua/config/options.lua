-- ~/.config/nvim/lua/config/options.lua
-- Vim/editor options. Set leader BEFORE lazy loads plugins.

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable some built-in plugins we don't need (tiny perf win)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"          -- avoid layout shift
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false            -- lualine shows mode
opt.laststatus = 3              -- one global statusline
opt.cmdheight = 1
opt.pumheight = 12              -- popup menu max lines
opt.winborder = "rounded"       -- default border for LSP/hover floats (0.11+)
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = true
opt.linebreak = true            -- wrap at word boundaries (needs wrap)
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", fold = " ", foldopen = "▾", foldclose = "▸" }

-- Editing
opt.expandtab = true
opt.shiftwidth = 4              -- Swift default; TS/JS override in ftplugin
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.breakindent = true
opt.virtualedit = "block"
opt.undofile = true
opt.undolevels = 10000
opt.confirm = true
opt.updatetime = 200            -- faster CursorHold → gitsigns/snacks.words
opt.timeoutlen = 300            -- faster which-key

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"        -- live-preview :s
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Completion
opt.completeopt = "menu,menuone,noselect,fuzzy"
opt.wildmode = "longest:full,full"

-- Folds (treesitter-driven; see autocmds)
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Session / clipboard
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.clipboard = "unnamedplus"   -- share with macOS clipboard

-- Per-filetype: smaller indent for web languages
local ftindent = vim.api.nvim_create_augroup("ftindent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = ftindent,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact",
              "json", "jsonc", "yaml", "html", "css", "scss", "lua", "markdown" },
  callback = function(a)
    vim.bo[a.buf].shiftwidth = 2
    vim.bo[a.buf].tabstop = 2
    vim.bo[a.buf].softtabstop = 2
  end,
})
