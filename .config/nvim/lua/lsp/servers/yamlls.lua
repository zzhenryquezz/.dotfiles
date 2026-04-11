local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('yamlls', {
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
	settings = {
		yaml = {
			format = {
				enable = true,
			},
			schemaStore = {
				enable = true,
			},
		},
		editor = {
			tabSize = 4,
		},
	},
})
