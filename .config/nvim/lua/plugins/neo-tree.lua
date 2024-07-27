return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require('neo-tree')

		neotree.setup({
			close_if_last_window = true,
			hide_root_node = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					visible = true,
				}
			}
		})

		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
	end,
}
