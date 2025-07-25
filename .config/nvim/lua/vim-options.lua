-- Basic Options
vim.cmd("language en_US.UTF-8")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.g.mapleader = " "
vim.opt.swapfile = false

local opts = { noremap = true, silent = true }

-- System Clipboard
vim.keymap.set({ "n", "v" }, "<C-c>", '"+y', opts)
-- vim.keymap.set({ 'n', 'v' }, '<C-v>', '"+p', opts)

-- Indentation Binds
vim.keymap.set("n", "<S-Tab>", "<<", opts)
vim.keymap.set("i", "<S-Tab>", "<C-\\><C-N><<<C-\\><C-N>^i")
vim.keymap.set("n", "<Tab>", ">>", opts)

-- Splits and Tabs
vim.keymap.set("n", "<C-w>v", ":vsplit<CR>", opts)
vim.keymap.set("n", "<C-w>s", ":split<CR>", opts)
vim.keymap.set("n", "<C-w>t", ":tabnew<CR>", opts)
vim.keymap.set("n", "<C-w>c", ":tabclose<CR>", opts)
vim.keymap.set("n", "<C-w>o", ":only<CR>", opts)

-- Navigation
vim.keymap.set("n", "<C-PageUp>", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<C-PageDown>", ":tabnext<CR>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize Splits
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Copilot accept suggestion
vim.keymap.set('i', '<M-CR>', 'copilot#Accept("<CR>")', { expr=true, noremap = true, silent = true })
vim.g.copilot_no_tab_map = true
