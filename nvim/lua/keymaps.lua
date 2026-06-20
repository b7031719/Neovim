vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "move to left window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "move to bottom window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "move to top window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "move to right window" })
