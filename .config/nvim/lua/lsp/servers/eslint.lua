local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig.util")

lspconfig.eslint.setup({
	capabilities,
	root_dir = util.root_pattern(
		"eslint.config.js",
		"eslint.config.mjs",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml"
	),
	on_attach = function(_client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
