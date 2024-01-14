local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    install = {
      missing = true,
      colorscheme = { "catppuccin" }
    },
    defaults = {
      version = false -- always use the latest release
    },
    checker = {       -- Automatically check for plugin updates
      enabled = true
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    -- Add sqlite support for packages that need it
    { "kkharji/sqlite.lua",     enabled = not jit.os:find("Windows") },

    { "tpope/vim-sensible" },
    { "tpope/vim-fugitive" }, -- git integration
    { "tpope/vim-repeat" },   -- make the . work a little bit better
    { "tpope/vim-surround" }, -- add/remove things surrounding text
    { "lewis6991/gitsigns.nvim" },
    { "windwp/nvim-ts-autotag" },
    { "fladson/vim-kitty" },
    { "akinsho/bufferline.nvim" }, -- show buffers on top

    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
    },

    { -- Smarter '%'
      "andymass/vim-matchup",
      setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },

    { -- LSP config
      "VonHeikemen/lsp-zero.nvim",
      branch = "v3.x",
      lazy = true
    },

    { -- LSP Configuration & Plugins
      "neovim/nvim-lspconfig",
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      dependencies = {
        -- Formatter
        -- "stevearc/conform.nvim",
        -- Linter
        -- "mfussenegger/nvim-lint",

        -- Plugin for function signature help
        -- "ray-x/lsp_signature.nvim",

        -- Automatically install LSPs to stdpath for neovim
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Useful status updates for LSP
        "j-hui/fidget.nvim",
      }
    },

    { -- Autocompletion
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    },

    { -- Notifications on the bottom right
      "j-hui/fidget.nvim",
      opts = {
        -- options
      },
    },

    { -- Copilot
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "InsertEnter",
    },


    { --VSCode style icons to use in cmp menu
      "onsails/lspkind.nvim"
    },

    { -- Sidebar with file tree
      "nvim-neo-tree/neo-tree.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" }
    },

    { -- Color scheme
      "catppuccin/nvim",
      lazy = false,
      name = "catppuccin",
      opts = {}
    },

    { -- Name of the current buffer in the upper right corner
      "b0o/incline.nvim",
      priority = 1200,
      dependencies = { "catppuccin/nvim" }
    },

    { -- Status line
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      opts = {}
    },

    { -- A set of small packages with common features
      "echasnovski/mini.nvim",
      config = function()
        require("mini.comment").setup()
        require("mini.bufremove").setup()
        require("mini.cursorword").setup({
          delay = 150
        })
        require("mini.pairs").setup()
        -- require("mini.surround").setup() -- I'm using tpope/vim-surround
        require("mini.trailspace").setup()
        require("mini.splitjoin").setup()
      end
    },

    { -- Colorize color strings like "#ff5511" or "blue"
      "NvChad/nvim-colorizer.lua",
    },

    { -- Show indent lines
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
    },
    { -- Fuzzy finder (files, lsp, etc)
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 'nvim-telescope/telescope-symbols.nvim' },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = vim.fn.executable 'make' == 1
    },

    { -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      build = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
      dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', }
    },

    { -- Smarter comments using treesitter
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      opts = {
        enable_autocmd = false,
      },
    },

    {
      "folke/which-key.nvim",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
      end,
      opts = {}
    },

    { -- package.json goodies
      "vuki656/package-info.nvim",
      lazy = true,
      requires = "MunifTanjim/nui.nvim",
      -- config = function()
      --   require("package-info").setup()
      -- end
    },

    { -- Rails development goodies
      "tpope/vim-bundler",
      "tpope/vim-rails",
      "tpope/vim-rake",
    },

    { -- Better yank
      "gbprod/yanky.nvim",
    },
  },

  {
    ui = {
      -- Accepts same border values as |nvim_open_win|
      border = "single"
    },
  })
