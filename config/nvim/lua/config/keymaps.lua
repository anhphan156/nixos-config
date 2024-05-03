-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local opt = { noremap = true, silent = true }

map("i", "jk", "<esc>")
map("n", "\\w", "<esc>:w<CR>", opt)

map("n", "\\f", "<esc>:BLines<CR>", opt)
map("n", "\\g", "<esc>:GFiles<CR>", opt)
map("n", "\\r", "<esc>:Rg<CR>", opt)
map("n", "Y", "<esc>Vy", opt)

map("n", "\\\"", "<esc>bi\"<esc>ea\"<esc>", opt)
