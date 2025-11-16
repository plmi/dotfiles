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
vim.opt.cursorline = true

vim.opt.breakindent = true
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.bo.autoindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- spell checking
vim.opt.spelllang = 'de'
vim.opt.spellsuggest = 'best,9'

-- disable line numbers in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

