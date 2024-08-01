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
		local components = require('neo-tree.sources.common.components')

		neotree.setup({
			--			close_if_last_window = true,
--			open_files_do_not_replace_filetypes = { "terminal", "trouble", "qf" },
			autoselect_one = true,
			filesystem = {
				components = {
					name = function(config, node, state)
						local name = components.name(config, node, state)
						if node:get_depth() == 1 then
							name.text = vim.fs.basename(vim.loop.cwd() or '')
						end
						return name
					end,
				},
				filtered_items = {
					hide_dotfiles = false,
					visible = true,
				}
			},
			event_handlers = {

				{
					event = "file_opened",
					handler = function(file_path)
						require("neo-tree.command").execute({ action = "close" })

						vim.cmd(':only')
					end
				},

			}
		})

		vim.keymap.set("n", "<C-n>", ":Neotree toggle right<CR>")
	end,
}
