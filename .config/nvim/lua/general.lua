vim.g.mapleader = ','

local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

local wo = vim.wo
wo.number = true

local bo = vim.bo
bo.autoindent = true

local o = vim.o
o.termguicolors = true

-- vimspector
vim.g.vimspector_enable_mappings = 'HUMAN'