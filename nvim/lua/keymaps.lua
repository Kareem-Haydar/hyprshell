-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { silent = true })

vim.keymap.set("n", "<c-s>", ":wa<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-q>", "<C-v>", { noremap = true })

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gc", ":Neogen<CR>", { silent = true })

vim.keymap.set("n", "<leader>q", ":qa<CR>", { silent = true })

vim.keymap.set("n", "<leader>ls", function() require("persistence").load() end)
vim.keymap.set("n", "<leader>lS", function() require("persistence").select() end)
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
vim.keymap.set("n", "<leader>ss", function() require("persistence").stop() end)

vim.keymap.set("n", "<leader>vs", ":vs<CR>", { silent = true })
vim.keymap.set("n", "<leader>hs", ":sp<CR>", { silent = true })

-- mouse users + nvimtree users!
--vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
--  require('menu.utils').delete_old_menus()
--
--  vim.cmd.exec '"normal! \\<RightMouse>"'
--
--  -- clicked buf
--  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
--  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
--
--  require("menu").open(options, { mouse = true })
--end, {})
