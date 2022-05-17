-- Install packer.nvim at first.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(function(use)
  -- packer.nvim could manage itself
  use "wbthomason/packer.nvim"
  -- Speed up vim's startup time
  use "lewis6991/impatient.nvim"
  -- notify message
  use "rcarriga/nvim-notify"


  ------------[[Core Plugin]]------------

  -- Fzf
  -- Other plugins like this: telescope, vim-clap
  use {
    'junegunn/fzf',
    run = './install --bin',
    disable = true,
  }

  use {
    'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' -- NOTE: optional for icons
    },
    config = [[require('plugins.fzf')]],
    disable = true,
  }

  -- Telescope, instead of fzf
  use {
    "nvim-telescope/telescope.nvim",
    tag = "nvim-0.6",  -- NOTE: 0.6 is latest now
    config = [[require('plugins.telescope')]]
  }
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }
  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   requires = {"tami5/sqlite.lua"}   -- NOTE: need to install sqlite lib
  -- }
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-live-grep-raw.nvim"
  -- use "MattesGroeger/vim-bookmarks"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-dap.nvim"

  -- Update tags file automatically
  use 'ludovicchabant/vim-gutentags'

  ------------[[Directory Display]]------------

  -- Ranger File Browser
  use {
    "francoiscabrol/ranger.vim",
    requires = "rbgrouleff/bclose.vim",
    disable = false,
    config = function ()
      vim.g.ranger_map_keys = 0
      vim.g.NERDTreeHijackNetrw = 0  -- add this line if you use NERDTree.
      vim.g.ranger_replace_netrw = 1  -- open ranger when vim open a directory.
    end
  }

  -- Better Edit: <cmd>Tabularize /:/r1c1l0<CR>
  use "godlygeek/tabular"

  -- Better text object selection
  use "tpope/vim-surround"

  use {
    "windwp/nvim-autopairs",
    config = [[require('plugins.autopairs')]],
    disable = false,
    event = "InsertEnter",
  }

  ------------[[BETTER EDITOR DISPLAY]]-------------

  -- code align with virtual line
  use {
    "Yggdroot/indentLine",
    disable = true,
    config = function ()
      -- none X terminal
      vim.g.indentLine_color_tty_light = 7
      vim.g.indentLine_color_dark = 1
      end
  }

  -- Show <space> and <eol> char, colorize current pairs.
  use {
    "lukas-reineke/indent-blankline.nvim",
    --config = [[require('plugins.blankline')]],
  }

  -- Pretty color code display
  use {
    'norcalli/nvim-colorizer.lua',
    config = [[require('plugins.colorizer')]]
  }

  -- Show whitespace
  use "bronson/vim-trailing-whitespace"

  -- Better Icon Display
  use "kyazdani42/nvim-web-devicons"

  -- Better Display: heighlight and sidebar icon.
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[require('plugins.todo-comments')]]
  }

  -- Async git status signs at signcolumn.
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = [[require('plugins.gitsigns')]],
    event = "BufRead",
  }

  -- Better Code Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    run = ':TSUpdate',
  }

  -- Better StatusLine
  -- use {
    -- "glepnir/galaxyline.nvim",
    -- config = require("plugins.galaxyline"),
    -- disable = true,
  -- }

  -- Better Bufferline Display
  use {
    "akinsho/bufferline.nvim",
    config = [[require('plugins.bufferline')]],
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- ColorTheme
  use {
    "GustavoPrietoP/doom-themes.nvim",
    disable = true,
    event = "ColorSchemePre",
  }

  use {
    'NTBBloodbath/doom-one.nvim',
    config = [[require('plugins.doom-one')]],
  }

  -- Focusing Mode
  use {
    "folke/zen-mode.nvim",
    config = [[require('plugins.zen-mode')]]
  }

  -- Outline
  use {
    "stevearc/aerial.nvim",
    config = [[require('plugins.aerial')]]
  }

  -- open file which locate on opened lastest
  use {
     "ethanholz/nvim-lastplace",
     config = [[require('plugins.nvim-lastplace')]]
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = [[require('plugins.lualine')]],
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }

  ----------[[SNIPPETS]]----------

  -- snippets repository
  use 'rafamadriz/friendly-snippets'


  -----------[[LSP Plugins]]------------

  -- NOTE: lspconfig ONLY has configs, for people reading this.

  use {
    'neovim/nvim-lspconfig',
    config = require('plugins.lspconfig'),
  }

  use {
    'williamboman/nvim-lsp-installer',
    -- config = [[require('plugins.lspinstall')]],
  }

  use {
    'onsails/lspkind-nvim',
  }

  -- must have before requires
  use {
    'L3MON4D3/LuaSnip',
  }

  use {
    'hrsh7th/nvim-cmp',
    config = require('plugins.nvim-cmp'),
    requires = {
      {
        'L3MON4D3/LuaSnip',
        -- the following is required, if path not specified, default to '.config/nvim/snippets'
        config = require("luasnip.loaders.from_vscode").lazy_load()
      },
      'saadparwaiz1/cmp_luasnip',
    }
  }

  use {
    'hrsh7th/cmp-nvim-lsp',
  }

  use {
    'hrsh7th/cmp-buffer',
  }

  use {
    'hrsh7th/cmp-path',
  }

  use {
    'hrsh7th/cmp-nvim-lua',
  }

  use {
    "ray-x/lsp_signature.nvim",
    config = [[require('plugins.lsp-signature')]]
  }-- show function sigature when typing

  use "f3fora/cmp-spell" -- spell check

  use "ray-x/cmp-treesitter"

  use {
    "nvim-pack/nvim-spectre", -- search and replace pane
    config = [[require('plugins.nvim-spectre')]]
  }

  ------------[[Git Plugins]]------------

    -- Provides some git commands in vim.
  use "tpope/vim-fugitive"

  -- Gitflow integrated with LAZYGIT
  use {
    'kdheepak/lazygit.nvim',
    config = [[require('plugins.lazygit')]],
    cmd = { "LazyGit", "LazyGitConfig" },
  }

  -- Not git but similar
  use "ravenxrz/vim-local-history"

  --------------[[LANGUAGE]]------------

  -- Setup for Lua development in Neovim
  use {
    "folke/lua-dev.nvim",
    module = "lua-dev",
  }

  -- Auto code format when save
  use {
    "lukas-reineke/format.nvim",
    config = [[require('plugins.format')]],
    disable = true,
    event = "BufWinEnter",
  }

  use {
    "editorconfig/editorconfig-vim",
    disable = true,
  }

  use {
    "tpope/vim-commentary",
  }

  ------------[[TRANSLATOR]]------------

  use {
     "voldikss/vim-translator",
     config = [[require('plugins.vim-translator')]]
  }


  ------------[[RUN & DEBUG]]------------

  --use "skywind3000/asyncrun.vim"
  -- Async building & commands TODO: decide
  --use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
  --use "skywind3000/asynctasks.vim"


  ----------[[OTHERS]]-----------

  -- Better profiling output for startup.
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    disable = true,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
