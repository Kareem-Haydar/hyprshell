local configs = require("nvim-treesitter.configs")
require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = { "clang" }

configs.setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "cpp", "nu", "rust" },
  sync_install = true,
  auto_install = true,
  highlight = { enable = true },
})

vim.g.neo_tree_sitter_verbose = 1

require("treesitter-context").setup()
