local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('jsonls', {
	capabilities = capabilities,
})
