vim.opt.termguicolors = true
vim.g.syntax = "on"
vim.g.mapleader = " "
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 100

-- Disable netrw in favour of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Shorter pane switching
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>")
