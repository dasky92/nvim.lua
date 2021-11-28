-- Install packer.nvim at first.
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- /etc/sudoers

return require('packer').startup(function(use)
  -- packer.nvim could manage itself
  use "wbthomason/packer.nvim"
  -- Speed up vim's startup time
  use "lewis6991/impatient.nvim"


  ------------[[Core Plugin]]------------

  -- Fzf
  -- Other plugins like this: telescope, vim-clap
  use {
    'junegunn/fzf',
    run = './install --bin',
  }

  use {
    'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' -- NOTE: optional for icons
    },
    config = [[require('plugins.fzf')]]
  }

  ------------[[Directory Display]]------------

  -- Ranger File Browser
  -- TODO: leader-f conflicts with fzf-files
  use {
    "francoiscabrol/ranger.vim",
    requires = "rbgrouleff/bclose.vim",
    disable = false,
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
  use "Yggdroot/indentLine"

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

  -- Better TODO Display: heighlight and sidebar icon.
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[require('plugins.todo')]]
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
  use {
    "glepnir/galaxyline.nvim",
    config = require("plugins.galaxyline"),
    disable = false,
  }

  -- Better Bufferline Display
  use {
    "akinsho/bufferline.nvim",
    config = [[require('plugins.bufferline')]],
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- ColorTheme
  use {
    "GustavoPrietoP/doom-themes.nvim",
    event = "ColorSchemePre",
  }

  -- Focusing Mode
  use "folke/zen-mode.nvim"


  -----------[[LSP Plugins]]------------

  -- NOTE: lspconfig ONLY has configs, for people reading this.
  use {
    "neovim/nvim-lspconfig",
    config = require("plugins.lspconfig"),
  }

  -- Provides the missing `:LspInstall` for `nvim-lspconfig`.
  use {
    "williamboman/nvim-lsp-installer",
    --config = require("plugins.lspinstall"),
    -- after = "nvim-lspconfig",
  }

  -- Not using now.
  -- use "wbthomason/lsp-status.nvim"
  --[[use {
    "ericpubu/lsp_codelens_extensions.nvim",
     config = function()
       require("codelens_extensions").setup()
     end,
  }]]

  -- Completion
  -- Not use
  use {
    "hrsh7th/nvim-compe",
    disable = true,
    requires = {
      {
        "ray-x/lsp_signature.nvim",
        config = require("plugins.lsp-signature"),
      },
    },
    config = [[require("plugins.compe")]],
    opt = true,
    after = "nvim-lspconfig",
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'onsails/lspkind-nvim',
      'L3MON4D3/LuaSnip',
      {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp'
      },
      'hrsh7th/cmp-nvim-lsp',
      {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp'
      },
      {
        'hrsh7th/cmp-nvim-lua',
        after = 'nvim-cmp'
      },
      {
        'saadparwaiz1/cmp_luasnip',
        after = 'nvim-cmp'
      },
    },
    config = [[require('plugins.nvim-cmp')]],
    event = 'InsertEnter *',
  }

  ------------[[Git Plugins]]------------

    -- Provides some git commands in vim.
  use "tpope/vim-fugitive"

  -- Gitflow integrated with LAZYGIT
  use {
    'kdheepak/lazygit.nvim',
    config = [[require('plugins/lazygit')]],
    cmd = { "LazyGit", "LazyGitConfig" },
  }

  ----------[[SNIPPETS]]----------

  use {
    "L3MON4D3/LuaSnip",
    config = require("plugins.luasnip"),
    requires = { "rafamadriz/friendly-snippets" },
    event = "BufWinEnter",
  }

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


  ------------[[RUN & DEBUG]]------------

  --use "skywind3000/asyncrun.vim"
  -- Async building & commands TODO: decide
  --use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } }
  --use "skywind3000/asynctasks.vim"


  ----------[[OTHERS]]-----------

  -- Better terminal
  use {
    "norcalli/nvim-terminal.lua",
    config = function()
      require("terminal").setup()
    end,
  }

  -- Better profiling output for startup.
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
