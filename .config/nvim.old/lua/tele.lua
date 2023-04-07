local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state') -- lua/telescope/actions/state.lua

telescope.setup {
  defaults = {
    prompt_prefix = "$ ",
    mappings = {
      i = {
        ["jk"] = function() vim.cmd"stopinsert" end,
        ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
      n = {
        ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent lcd %s", dir))
          end
      }
    },
    layout_config = {
      prompt_position = 'top'
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

local mappings = {}
mappings.current_buffer_find = function()
  local get_ivy = require('telescope.themes').get_ivy()
  require('telescope.builtin').current_buffer_fuzzy_find(get_ivy)
end
return mappings

-- require'telescope.builtin'.find_files{
--   find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" }
-- }
-- M.find_files = function()
--   telescope_builtin.find_files {
--     find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
--     previewer = false
--   }
-- end
