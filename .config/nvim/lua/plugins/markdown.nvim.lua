return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "codecompanion" },
			})

			vim.keymap.set("n", "<leader>rm", function()
				require("render-markdown").toggle()
			end, { noremap = true, silent = true })
		end,
	},
}
