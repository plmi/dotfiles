vim.g.mapleader = ','
-- respect my tabstop settings
vim.g.python_recommended_style = 0

local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

local wo = vim.wo
wo.number = true

local bo = vim.bo
bo.autoindent = true

-- local o = vim.o
-- o.termguicolors = true

vim.cmd.colorscheme "catppuccin"
