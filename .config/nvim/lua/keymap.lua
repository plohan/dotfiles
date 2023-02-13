vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

vim.keymap.set("n", "<C-f>", function() vim.lsp.buf.format() end)

vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<C-j>", ":cn<CR>")
vim.keymap.set("n", "<C-k>", ":cp<CR>")

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<C-p>", ":Neotree toggle<CR>")


-- Buffers
vim.keymap.set("n", "<C-h>", vim.cmd.BufferPrev)
vim.keymap.set("n", "<C-l>", vim.cmd.BufferNext)
vim.keymap.set("n", "<C-m>", vim.cmd.BufferDelete)

