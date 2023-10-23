-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- require("mason-lspconfig").setup_handlers {
--     -- The first entry (without a key) will be the default handler
--     -- and will be called for each installed server that doesn't have
--     -- a dedicated handler.
--     function (server_name) -- default handler (optional)
--         require("lspconfig")[server_name].setup {}
--     end
-- }

-- use lsp-zero instead
-- automatic setup of LSP servers
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    -- will use default keymaps:
    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/api-reference.md#default_keymapsopts
    lsp_zero.default_setup,
  },
})
