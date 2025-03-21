local utils = require("lsp.utils")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ts_ls.setup({
	root_dir = function(fname)
		return lspconfig.util.root_pattern(".git")(fname)
			or lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
	end,
	capabilities = capabilities,
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath("data")
					.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
				-- location = lspconfig.util.path.join(
				-- 	utils.get_global_node_modules_path(),
				-- 	"node_modules/@vue/typescript-plugin"
				-- ),
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"vue",
	},
})
