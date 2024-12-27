return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

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
                "markdown_inline"
            }
		})
	end,
}
