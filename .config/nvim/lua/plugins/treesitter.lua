return {
	"nvim-treesitter/nvim-treesitter",
	version = "v0.9.2",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.install").compilers = {"zig", "clang", "gcc", "zig" } -- List your available compilers

		local configs = require("nvim-treesitter.configs")
		vim.opt.makeprg = "clang"

		configs.setup({
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"python",
				"typescript",
				"javascript",
				"html",
				"css",
				"json",
				"yaml",
				"bash",
				"markdown",
			},
		})
	end,
}
