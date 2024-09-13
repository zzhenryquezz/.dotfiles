vim.cmd("set nu")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set smarttab")
vim.cmd("set smartindent")
vim.cmd("set signcolumn=yes")
vim.cmd("set mouse=")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set spelllang=en_us")
vim.cmd("set spell")
vim.cmd("set relativenumber")

vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')
vim.keymap.set("n", "<c-s>", ':w<cr>')
vim.keymap.set("i", "<c-s>", '<Esc>:w<cr>')

vim.keymap.set("n", "<c-d>", '<c-d>zz')
vim.keymap.set("n", "<c-u>", '<c-u>zz')

vim.api.nvim_create_autocmd('TermOpen', {
	callback = function ()
		vim.opt_local.spell = false
		vim.cmd("startinsert")
	end
})

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd(
    { "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "CmdlineLeave" },
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
    { "BufLeave", "FocusLost", "InsertEnter", "WinLeave", "CmdlineEnter" },
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
vim.api.nvim_create_user_command("FixWindowsSpaces", function()
	vim.cmd("%s/\r//g")
end, {})

require("config.lazy")
