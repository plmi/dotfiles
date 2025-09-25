return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  enabled = true,
  config = function()
    -- close Telescope by pressing <esc> once
    local telescope = require('telescope')
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require('telescope.actions').close,
          },
        },
      },
    }

    -- toggle hidden files with Ctrl+h
    local find_files_toggle_hidden
    find_files_toggle_hidden = function(opts, no_ignore)
      opts = opts or {}
      no_ignore = vim.F.if_nil(no_ignore, false)
      opts.attach_mappings = function(_, map)
        map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
          local prompt = require("telescope.actions.state").get_current_line()
          require("telescope.actions").close(prompt_bufnr)
          no_ignore = not no_ignore
          find_files_toggle_hidden({ default_text = prompt }, no_ignore)
        end)
        return true
      end

      if no_ignore then
        opts.no_ignore = true
        opts.hidden = true
        opts.prompt_title = "Find Files <ALL>"
        require("telescope.builtin").find_files(opts)
      else
        opts.prompt_title = "Find Files"
        require("telescope.builtin").find_files(opts)
      end
    end

    -- keybindings
    vim.keymap.set('n', '<leader>ff', find_files_toggle_hidden, {})
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    local function current_buffer_fuzzy_find()  
      require("telescope.builtin").current_buffer_fuzzy_find()
    end
    vim.keymap.set('n', '<leader>f/', current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
  end
}
