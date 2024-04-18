-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.guicursor = ""

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false

vim.o.swapfile = true
vim.o.backup = false
vim.opt.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.o.updatetime = 50

vim.o.colorcolumn = "80"

vim.o.termguicolors = true

vim.g.netrw_banner = 0
