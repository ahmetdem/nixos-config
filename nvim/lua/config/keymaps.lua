-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save file
map("n", "<leader>w", "<cmd>w<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move selected text up and down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Select all text
map("n", "<leader>a", ":keepjumps normal! ggVG<CR>", { desc = "Select all text" })

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })

-- Move focus between windows
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

-- Open the Alpha dashboard
map("n", "<leader>l", "<cmd>Alpha<CR>", { desc = "Open Dashboard" })

-- Commenting
map({ "n", "v" }, "<leader>/", "gc", { remap = true, desc = "Comment operator" })
map("n", "<leader>//", "gcc", { remap = true, desc = "Toggle line comment" })

-- Word movement for all modes
map({ 'n', 'v', 'c' }, '<M-b>', 'b')
map({ 'n', 'v', 'c' }, '<M-f>', 'w')
map('i', '<M-b>', '<C-o>b')
map('i', '<M-f>', '<C-o>w')

-- Word deletion 
map({ 'i', 'c' }, '<M-BS>', '<C-w>')
map({ 'i', 'c' }, '<C-Delete>', '<C-o>dw')

map("v", ">", ">gv", { desc = "Indent and reselect" })
map("v", "<", "<gv", { desc = "Unindent and reselect" })
