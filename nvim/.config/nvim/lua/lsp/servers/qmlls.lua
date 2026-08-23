local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('qmlls', {
	capabilities = capabilities,
    cmd = { "qmlls6"  },
    filetypes = { "qml" },
})

vim.lsp.enable('qmlls')
