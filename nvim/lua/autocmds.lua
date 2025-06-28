vim.cmd([[ set tabstop=2 ]])
vim.cmd([[ set shiftwidth=2 ]])
vim.cmd([[ set expandtab ]])

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.laststatus = 3
vim.o.cmdheight = 0

vim.diagnostic.config({ update_in_insert = true })
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

local signs = {
	Error = "", -- Error icon
	Warn = "", -- Warning icon
	Hint = "", -- Hint icon
	Info = " ", -- Information icon
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")

-- Disable line numbers in the Lazy.nvim overview window
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
		pattern = {"*.hl", "hypr*.conf"},
		callback = function(event)
				print(string.format("starting hyprls for %s", vim.inspect(event)))
				vim.lsp.start {
						name = "hyprlang",
						cmd = {"hyprls"},
						root_dir = vim.fn.getcwd(),
				}
		end
})

vim.lsp.inlay_hint.enable(true)

package.path = package.path .. vim.fn.getcwd() .. "/?.lua;" .. vim.fn.getcwd() .. "/lua/?.lua;" .. vim.fn.getcwd() .. "/plugin/?.lua;"

vim.cmd[[ colorscheme catppuccin-frappe ]]

vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#969696", italic = true })

-- Center the cursor in Normal mode
vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = "*",
  callback = function()
    if vim.api.nvim_get_mode().mode == "n" then
      vim.cmd("normal! zz")
    end
  end,
})

-- Center the cursor when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! zz")
  end,
})

