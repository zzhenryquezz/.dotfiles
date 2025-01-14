return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			local telescopeConfig = require("telescope.config")

			if not table.unpack then
				table.unpack = unpack
			end

			local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }

			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
            -- ignore .git and node_modules
			table.insert(vimgrep_arguments, "!{**/.git/*,**/node_modules/*}")

			telescope.setup({
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					mappings = {
						n = {
							["q"] = require("telescope.actions").close,
							["d"] = require("telescope.actions").delete_buffer,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--no-ignore",
							"--glob",
                            "!{**/.git/*,**/node_modules/*}",
						},
					},
					buffers = {},
					grep_string = {
						additional_args = { "--hidden" },
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
                    ['noice'] = {
                    },
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
