-- Minimal clean Neovim defaults
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false
opt.undofile = true

-- Keep netrw enabled by default for a no-plugin baseline.

vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Write file' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
