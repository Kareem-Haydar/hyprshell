require("nvim-tree").setup {
  git = {
    enable = true,
    ignore = false
  }
}

vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<CR>", { silent = true })
