require('Comment').setup()

-- <C-_> means Ctrl+/
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false })
vim.api.nvim_set_keymap('v', '<C-_>', 'gcc<Esc>', { noremap = false })
