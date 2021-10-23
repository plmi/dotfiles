-- navigation
vim.api.nvim_set_keymap('n', '<up>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<down>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<left>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<right>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<space>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', {})
vim.api.nvim_set_keymap('n', 'k', 'gk', {})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- switch tab buffer
vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-tab>', ':bprevious<cr>', { noremap = true, silent = true })

-- move selected line/block in visual mode
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true })

-- umlaute
vim.api.nvim_set_keymap('i', ';a', 'ä', {})
vim.api.nvim_set_keymap('i', ';A', 'Ä', {})
vim.api.nvim_set_keymap('i', ';u', 'ü', {})
vim.api.nvim_set_keymap('i', ';U', 'Ü', {})
vim.api.nvim_set_keymap('i', ';o', 'ö', {})
vim.api.nvim_set_keymap('i', ';O', 'Ö', {})

-- binding
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
vim.api.nvim_set_keymap('n', '<leader>,', ':w<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', {})
vim.api.nvim_set_keymap('n', 'QQ', ':q!<cr>', {})
vim.api.nvim_set_keymap('n', '<C-c>', ':nohl<cr><C-l>:echo "Search cleared!"<cr>', { noremap = true, silent = true})
