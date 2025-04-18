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
vim.keymap.set({ 'n', 'v' }, '<C-c>', '"+y', opts)
vim.keymap.set({ 'n', 'v' }, '<C-v>', '"+p', opts)

-- Indentation Binds
vim.keymap.set('n', '<S-Tab>', '<<', opts)
vim.keymap.set('i', '<S-Tab>', '<C-\\><C-N><<<C-\\><C-N>^i')
vim.keymap.set('n', '<Tab>', '>>', opts)
