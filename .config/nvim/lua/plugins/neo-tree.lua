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

        local function copy_selector(state, selector)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
                absolute = filepath,
                relative = modify(filepath, ":."),
                home = modify(filepath, ":~"),
                filename = filename,
                name_no_ext = modify(filename, ":r"),
                extension = modify(filename, ":e"),
            }

            local result = results[selector]

            if result then
                vim.fn.setreg("+", result) -- system clipboard 
                vim.fn.setreg('"', result) -- default register
                vim.notify("Copied: " .. result)
            else
                vim.notify("Invalid selector: " .. selector, vim.log.levels.WARN)
            end
        end

        neotree.setup({
            close_if_last_window = true,
            autoselect_one = true,
            window = {
                position = "current",
                mappings = {
                    ["<leader>pa"] = function(state)
                        copy_selector(state, "absolute")
                    end,
                    ["<leader>pr"] = function(state)
                        copy_selector(state, "relative")
                    end,
                    ["<leader>ph"] = function(state)
                        copy_selector(state, "home")
                    end,
                    ["<leader>pf"] = function(state)
                        copy_selector(state, "filename")
                    end,
                    ["<leader>pn"] = function(state)
                        copy_selector(state, "name_no_ext")
                    end,
                    ["<leader>pe"] = function(state)
                        copy_selector(state, "extension")
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
