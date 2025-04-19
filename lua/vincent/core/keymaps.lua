local set = vim.keymap.set

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Center the cursor
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("n", "J", "mzJ`z")

-- Keep register
set("x", "<leader>p", [["_dP]])
set({ "n", "v" }, "<leader>d", [["_d]])

-- System register
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])
set({ "n", "v" }, "<leader>p", [["+p]])
set("n", "<leader>P", [["+P]])

-- Unbind
set("n", "Q", "<nop>")
set("n", "<Up>", "<nop>")
set("n", "<Right>", "<nop>")
set("n", "<Down>", "<nop>")
set("n", "<Left>", "<nop>")
