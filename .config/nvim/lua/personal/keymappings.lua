-- navigation
vim.g.mapleader = ','
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<up>', '<nop>', {})
vim.keymap.set('n', '<down>', '<nop>', {})
vim.keymap.set('n', '<left>', '<nop>', {})
vim.keymap.set('n', '<right>', '<nop>', {})
vim.keymap.set('n', '<space>', '<nop>', { noremap = true, silent = true })
vim.keymap.set('n', 'j', 'gj', {})
vim.keymap.set('n', 'k', 'gk', {})

-- keep curor in the middle while scrolling half page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- keep cursor in the middle while searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- paste buffer without loosing it
vim.keymap.set('x', '<leader>p', '"_dP')

-- yank into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

-- replace current word under cursor
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- 'chmod +x' current file
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- bindings
vim.keymap.set('i', 'jk', '<esc>', {})
vim.keymap.set('n', '<leader>,', ':w<cr>', {})
vim.keymap.set('n', '<leader>q', ':q<cr>', {})
vim.keymap.set('n', 'QQ', ':q!<cr>', {})
vim.keymap.set('n', '<C-c>', ':nohl<cr><C-l>:echo "Search cleared!"<cr>', { noremap = true, silent = true })

-- navigation quickfix list
vim.keymap.set('n', '<C-j>', ':cnext<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', ':cprevious<cr>', { noremap = true, silent = true })

-- substitute visual selection: https://stackoverflow.com/a/676619/14634871
vim.keymap.set('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>', { noremap = true })

-- better indentation
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- switch buffers
vim.keymap.set('n', '<tab>', ':bnext<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-tab>', ':bprevious<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bn', ':bn<cr>', { noremap = true, silent = true})

-- move selected line/block in visual mode
vim.keymap.set('v', 'J', ":move '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- umlaute
vim.keymap.set('i', ';a', 'ä', {})
vim.keymap.set('i', ';A', 'Ä', {})
vim.keymap.set('i', ';u', 'ü', {})
vim.keymap.set('i', ';U', 'Ü', {})
vim.keymap.set('i', ';o', 'ö', {})
vim.keymap.set('i', ';O', 'Ö', {})
vim.keymap.set('i', ';s', 'ß', {})
