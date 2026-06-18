--------------------------
-- MAPLEADERS
--------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--------------------------
-- REQUIRES 
--------------------------

-- Custom options defined here
require("vim-options")
require("keymaps")

-- Lazy for installing and loading plugins
require("lazy_init")
