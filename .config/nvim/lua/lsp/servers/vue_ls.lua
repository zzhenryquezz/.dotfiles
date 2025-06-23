local utils = require("lsp.utils")

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function get_typescript_server_path(root_dir)
	local global_ts = lspconfig.util.path.join(utils.get_global_node_modules_path(), "typescript", "lib")

	local found_ts = ""
	local function check_dir(path)
		found_ts = lspconfig.util.path.join(path, "node_modules", "typescript", "lib")
		if vim.loop.fs_stat(found_ts) then
			return path
		end
	end
	if lspconfig.util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

lspconfig.volar.setup({
	capabilities = capabilities,
	on_new_config = function(new_config, new_root_dir)
		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
	end,
})

