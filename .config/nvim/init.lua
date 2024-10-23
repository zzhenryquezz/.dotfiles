local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd(
    { "InsertLeave" },
    {
        group = numbertoggle,
        callback = function()
            if vim.opt.number and vim.api.nvim_get_mode() ~= "i" then
                vim.opt.relativenumber = true
            end
        end,
    }
)

vim.api.nvim_create_autocmd(
    { "InsertEnter" },
    {
        group = numbertoggle,
        callback = function()
            if vim.opt.number then
                vim.opt.relativenumber = false
                vim.cmd("redraw")
            end
        end,
    }
)

require("config.lazy")
require("options")
require("keymaps")
