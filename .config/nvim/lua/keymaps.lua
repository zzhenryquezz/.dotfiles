vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')
vim.keymap.set("i", "<c-s>", '<Esc>:w<cr>')

vim.keymap.set("n", "<c-d>", '<c-d>zz')
vim.keymap.set("n", "<c-s>", ':w<cr>')
vim.keymap.set("n", "<c-u>", '<c-u>zz')


-- toggle relative numbers
vim.keymap.set("n", "<leader>rn", function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true })
