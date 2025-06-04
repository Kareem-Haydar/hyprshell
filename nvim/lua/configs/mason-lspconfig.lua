require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "clangd", "glsl_analyzer", "bashls", "zls", "pyright", "cmake"},
})
