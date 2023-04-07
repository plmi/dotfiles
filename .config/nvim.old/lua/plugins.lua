local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
  use {'L3MON4D3/LuaSnip'}

  -- completion
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-nvim-lua'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'onsails/lspkind-nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {'jiangmiao/auto-pairs'}
  use {'puremourning/vimspector'}
  use { 'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  -- use {'terrortylor/nvim-comment'}
  -- require('nvim_comment').setup()

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'kyazdani42/nvim-web-devicons'}
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
