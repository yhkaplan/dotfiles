-- ~/.config/nvim/lua/config/keymaps.lua
-- Core, non-plugin keymaps. Plugin-specific keymaps live with the plugin spec
-- (so lazy.nvim can register them for lazy-loading).

local map = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Sensible defaults
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")
map("n", "j", "v:count == 0 ? 'gj' : 'j'", "Down (visual line)", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", "Up (visual line)", { expr = true, silent = true })

-- Save / quit
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")
map("n", "<leader>w", "<cmd>w<cr>", "Save")
map("n", "<leader>q", "<cmd>confirm qa<cr>", "Quit all")

-- Better window navigation (Ctrl-hjkl)
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

-- Resize windows with arrows
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          "Resize up")
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          "Resize down")
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", "Resize left")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Resize right")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", "Prev buffer")
map("n", "<S-l>", "<cmd>bnext<cr>",     "Next buffer")
map("n", "<leader>bd", "<cmd>bd<cr>",   "Delete buffer")
map("n", "<leader>bD", "<cmd>bd!<cr>",  "Delete buffer (force)")

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", "Half-page down")
map("n", "<C-u>", "<C-u>zz", "Half-page up")
map("n", "n", "nzzzv", "Next search")
map("n", "N", "Nzzzv", "Prev search")

-- Move lines (visual mode)
map("v", "J", ":m '>+1<cr>gv=gv", "Move line down")
map("v", "K", ":m '<-2<cr>gv=gv", "Move line up")
map("v", "<", "<gv", "Dedent")
map("v", ">", ">gv", "Indent")

-- Paste over selection without yanking it
map("x", "<leader>p", [["_dP]], "Paste without yank")

-- Yank to system clipboard explicitly
map({ "n", "v" }, "<leader>y", [["+y]], "Yank to clipboard")
map("n", "<leader>Y", [["+Y]], "Yank line to clipboard")

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
map("n", "]d", function() vim.diagnostic.jump({ count = 1,  float = true }) end, "Next diagnostic")
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
map("n", "]e", function() vim.diagnostic.jump({ count = 1,  severity = vim.diagnostic.severity.ERROR, float = true }) end, "Next error")
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, float = true }) end, "Prev error")

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", "New file")

-- Lazy
map("n", "<leader>L", "<cmd>Lazy<cr>", "Lazy")
map("n", "<leader>M", "<cmd>Mason<cr>", "Mason")
