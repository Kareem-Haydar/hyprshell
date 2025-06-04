local on_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})

	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "<leader>th", function()
		if vim.lsp.inlay_hint.is_enabled() then
			vim.notify("inlay hints disabled")
		else
			vim.notify("inlay hints enabled")
		end
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup({
  on_attach = on_attach,
  cpapbilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Add 'vim' as a global to avoid warnings
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim's runtime library
        checkThirdParty = false, -- Disable checking of third-party libraries (optional)
      },
      telemetry = {
        enable = false, -- Disable telemetry (optional)
      },
    },
  },
})
require("lspconfig").clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").glsl_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").zls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
require("lspconfig").cmake.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  vim.diagnostic.config({ virtual_text = true, severity_sort = true }),
})
