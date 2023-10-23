local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("search=") });
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
local function current_buffer_fuzzy_find()
  require("telescope.builtin").current_buffer_fuzzy_find()
end
vim.keymap.set('n', '<leader>f/', current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
