vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]]) -- exit terminal mode

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "move to left window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "move to bottom window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "move to top window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "move to right window" })

vim.keymap.set({ "n", "v" }, "<leader>dv", function()
	require("repl").setup()
end, { desc = "Launch a nix devshell and run Python3" })

vim.keymap.set("v", "<leader>rb", function()
	require("repl").run_block()
end, { desc = "Runs highlighted block of code under the cursor in the devshell" })

vim.keymap.set({ "n", "v" }, "<leader>rf", function()
	require("repl").run_file()
end, { desc = "Runs the current file in the devshell" })

