-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- disable mouse
vim.opt.mouse = ''

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.breakindent = true
vim.opt.termguicolors = true

vim.wo.number = true
vim.bo.autoindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- respect my tabstop settings
-- vim.g.python_recommended_style = 0

-- spell checking
vim.opt.spelllang = 'de'
vim.opt.spellsuggest = 'best,9'

-- theme
vim.cmd.colorscheme "catppuccin"
