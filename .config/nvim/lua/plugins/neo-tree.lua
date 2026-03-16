return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neotree = require("neo-tree")
		local components = require("neo-tree.sources.common.components")

		neotree.setup({
			close_if_last_window = true,
			autoselect_one = true,
			window = {
				position = "current",
				mappings = {
					["Y"] = function(state)
						-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
						-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local filename = node.name
						local modify = vim.fn.fnamemodify

						local results = {
							filepath,
							modify(filepath, ":."),
							modify(filepath, ":~"),
							filename,
							modify(filename, ":r"),
							modify(filename, ":e"),
						}

						-- absolute path to clipboard
						local i = vim.fn.inputlist({
							"Choose to copy to clipboard:",
							"1. Absolute path: " .. results[1],
							"2. Path relative to CWD: " .. results[2],
							"3. Path relative to HOME: " .. results[3],
							"4. Filename: " .. results[4],
							"5. Filename without extension: " .. results[5],
							"6. Extension of the filename: " .. results[6],
						})

						if i > 0 then
							local result = results[i]
							if not result then
								return print("Invalid choice: " .. i)
							end
							vim.fn.setreg('+', result)
							vim.notify("Copied: " .. result)
						end
					end,
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
				components = {
					name = function(config, node, state)
						local name = components.name(config, node, state)
						if node:get_depth() == 1 then
							name.text = vim.fs.basename(vim.loop.cwd() or "")
						end
						return name
					end,
				},
				filtered_items = {
					hide_dotfiles = false,
					visible = true,
					never_show = {
						".git",
					},
				},
			},
			event_handlers = {
				{
					event = "file_open_requested",
					handler = function()
						vim.cmd("Neotree close")
					end,
				},
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree reveal<CR>")
	end,
}
