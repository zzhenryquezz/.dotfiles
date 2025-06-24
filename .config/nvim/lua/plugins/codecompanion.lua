return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("codecompanion").setup({
            opts = {
                log_leve = "DEBUG",
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                    tools = {
                        groups = {
                            ["editor"] = {
                                tools = {
                                    "cmd_runner",
                                    "create_file",
                                    "file_search",
                                    "grep_search",
                                    "insert_edit_into_file",
                                    "read_file",
                                    "web_search",
                                },
                                opts = {
                                    collapse_tools = true,
                                },
                            },
                        },
                    },
                },
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        show_result_in_chat = true, -- Show mcp tool results in chat
                        make_vars = true,           -- Convert resources to #variables
                        make_slash_commands = true, -- Add prompts as /slash commands
                    },
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        vim.keymap.set(
            { "n", "v" },
            "<leader>a",
            "<cmd>CodeCompanionChat Toggle<cr>",
            { noremap = true, silent = true }
        )
        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

        -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd([[cab cc CodeCompanion]])
    end,
}
