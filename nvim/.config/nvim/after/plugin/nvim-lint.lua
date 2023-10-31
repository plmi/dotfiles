local lint = require('lint')
lint.linters_by_ft = {
  python = { 'flake8' },
  sh = { 'shellcheck' },
}

-- clear pre-existing auto commands
local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true });

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  -- apply auto command only to matching pattern
  -- pattern = { "*.py" },
  group = lint_augroup,
  -- execute whenever one of the above events are triggered
  callback = function()
    require('lint').try_lint()
  end,
})


vim.keymap.set('n', '<leader>xl', function()
  lint.try_lint()
end, { desc = 'Lint current file' })
