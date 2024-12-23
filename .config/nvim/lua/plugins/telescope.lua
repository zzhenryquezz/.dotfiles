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
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { ".git/", "node_modules/" },
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                            ["d"] = require("telescope.actions").delete_buffer,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    buffers = {
                        initial_mode = "normal",
                    },
                    grep_string = {
                        additional_args = { "--hidden" }
                    },
                    live_grep = {
                        additional_args = { "--hidden" }
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            require("telescope").load_extension("ui-select")
        end,
    },
}
