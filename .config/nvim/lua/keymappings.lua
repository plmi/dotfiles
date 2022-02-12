-- navigation
vim.api.nvim_set_keymap('n', '<up>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<down>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<left>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<right>', '<nop>', {})
vim.api.nvim_set_keymap('n', '<space>', '<nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', {})
vim.api.nvim_set_keymap('n', 'k', 'gk', {})

-- substitute visual selection: 
-- https://stackoverflow.com/a/676619/14634871
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//g<left><left>', { noremap = true })

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- switch buffers
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

-- bindings
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
vim.api.nvim_set_keymap('n', '<leader>,', ':w<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', {})
vim.api.nvim_set_keymap('n', 'QQ', ':q!<cr>', {})
vim.api.nvim_set_keymap('n', '<C-c>', ':nohl<cr><C-l>:echo "Search cleared!"<cr>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<cr>', { noremap = true, silent = true})

-- terminal mode
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>split | terminal<cr>A', {})
vim.api.nvim_set_keymap('t', '<leader>t', '<C-\\><C-n>:q!<cr>', { noremap = true })
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = false })
-- does not work?
-- vim.api.nvim_set_keymap('t', '<leader>t', '<cmd>term ++close<cr>', {})

-- telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Telescope lsp_code_actions<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fa', '<cmd>lua vim.lsp.buf.formatting()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', {})

-- vimspector
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>call vimspector#Launch()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dx', '<cmd>VimspectorReset<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>de', '<cmd>VimspectorEval<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dw', ':VimspectorWatch ', {})
vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>VimspectorShowOutput<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>call vimspector#StepInto()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dj', '<cmd>call vimspector#StepOver()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dk', '<cmd>call vimspector#StepOut()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>call vimspector#RunToCursor()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>d_', '<cmd>call vimspector#Restart()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>call vimspector#ToggleBreakpoint()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>d<space>', '<cmd>call vimspector#Continue()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>di', '<Plug>VimspectorBalloonEval', {})
vim.api.nvim_set_keymap('x', '<leader>di', '<Plug>VimspectorBalloonEval', {})