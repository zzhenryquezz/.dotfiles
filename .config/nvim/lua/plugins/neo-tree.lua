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
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true
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
                        '.git'
                    },
                },
            },
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function() 
                        vim.cmd("Neotree close") 
                    end
                }
            }
        })

        vim.keymap.set("n", "<C-n>", ":Neotree reveal<CR>")
    end,
}
