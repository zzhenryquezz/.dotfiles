vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')
vim.keymap.set("i", "<c-s>", '<Esc>:w<cr>')



-- toggle relative numbers
vim.keymap.set("n", "<leader>rn", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true })

-- center on cursor or page up/down
vim.keymap.set("n", "<c-d>", '<c-d>zz')
vim.keymap.set("n", "<c-s>", ':w<cr>')
vim.keymap.set("n", "<c-u>", '<c-u>zz')

vim.keymap.set("n", "<PageUp>", "<c-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<PageDown>", "<c-d>zz", { noremap = true, silent = true })
