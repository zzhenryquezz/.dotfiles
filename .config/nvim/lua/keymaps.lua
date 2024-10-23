vim.keymap.set("t", "<Esc>", '<C-\\><C-n><CR>')
vim.keymap.set("i", "<c-s>", '<Esc>:w<cr>')

vim.keymap.set("n", "<c-d>", '<c-d>zz')
vim.keymap.set("n", "<c-s>", ':w<cr>')
vim.keymap.set("n", "<c-u>", '<c-u>zz')
vim.keymap.set("n", "p", 'p :silent! %s/\r//g<cr>')
