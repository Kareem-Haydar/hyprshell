local M = {
  {
    'AlphaTechnolog/pywal.nvim',
    opts = {}
  },
  {
    'Mofiqul/vscode.nvim'
  },
  {
    "ayu-theme/ayu-vim",
    event = "VeryLazy",
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sainnhe/gruvbox-material",
    event = "VeryLazy",
  },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    opts = require("configs.tokyonight"),
  },
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
    config = function ()
      require("kanagawa").setup()
    end
  },
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
    opts = require("configs.catppuccin")
  },
  {
    "rose-pine/neovim",
    event = "VeryLazy",
    name = "rose-pine",
  },
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    opts = {},
    event = "VeryLazy",
  },
  {
    'shaunsingh/nord.nvim',
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    opts = require("configs.onedarkpro"),
    event = "VeryLazy",
  },
  {
    'dstein64/vim-startuptime',
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("configs.dashboard")
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
  {
    'akinsho/bufferline.nvim',
    enabled = false,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("configs.bufferline")
    end
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },
  {
    'nvim-telescope/telescope-project.nvim',
    lazy = true,
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    config = function()
      require("configs.telescope")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "VeryLazy",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("configs.treesitter")
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function ()
      require("configs.colorizer")
    end
  },
  {
    "karb94/neoscroll.nvim",
    enabled = false,
    opts = {
      easing = "cubic",
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    --enabled = false,
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("configs.nvim-tree")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function ()
      require("configs.neotree")
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("configs.lualine")
    end
  },
  {
		"m4xshen/autoclose.nvim",
    event = "VeryLazy",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"rafamadriz/friendly-snippets",
    event = "InsertEnter",
	},
	{
		"hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
		config = function()
      require("configs.cmp")
    end
	},
	{
		"onsails/lspkind.nvim",
    lazy = true,
    event = "InsertEnter",
	},
  {
		"williamboman/mason.nvim",
    lazy = true,
    event = "VeryLazy",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
    lazy = true,
    event = "VeryLazy",
		config = function()
      require("configs.mason-lspconfig")
		end,
	},
	{
		"neovim/nvim-lspconfig",
    event = "BufEnter",
    lazy = true,
		config = function()
      require("configs.lsp")
		end,
	},
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { },
  },
  {
    "danymat/neogen",
    config = true,
    version = "*"
  },
  {
		"rcarriga/nvim-notify",
    event = "VeryLazy",
    lazy = true,
		config = function()
			require("configs.notify")
		end,
	},
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
    event = "VeryLazy",
  },
  {
    "folke/noice.nvim",
    --enabled = false;
    event = "VeryLazy",
    opts = {
    },
  },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    dependencies = 'rmagatti/logger.nvim',
    config = function ()
      require("configs.goto-preview")
    end,
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
      require("configs.codeium")
    end
},
}

return M
