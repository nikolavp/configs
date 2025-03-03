-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("i", "#", "X<BS>#", { desc = "Do clever indent things. Don't make a # force column zero." })
map("n", "F1", ':set paste<CR>"+p:set nopaste<CR>', { desc = "set paste before pasting and then do it" })
map("c", "Q!", "q!")
map("c", "q1", "q!")
map("c", "Q1", "q!")
map("c", "W", "w")

map("n", "qq", ":bdelete<CR>", { desc = "Delete current buffer" })
map("n", ",e", ":e ~/.config/nvim/lua<CR>")
map("n", "<leader>i", "i<space><esc>r", { desc = "Add a single character" })
map("n", "<leader>o", "o<esc>", { desc = "Add a single line below current line" })
map("n", "<leader>O", "O<esc>", { desc = "Add a single line above the current line" })
map("n", "<leader>dbl", ":g/^$/d<CR>:nohls<CR>", { desc = "Delete blank lines in a file" })
map("n", "<Leader>ed", ':e <C-r>=expand("%:p:h")<CR>/<C-d>')

map("n", "<F7>", ":make<CR><CR>")
map("v", "<F7>", ":make<CR><CR>")
map("i", "<F7>", "<esc>:make<CR><CR>")
map({ "n", "i", "v" }, "<F2>", ":nohl<ESC>")
map({ "n", "i", "v" }, "<F2><F2>", ":on<cr>")

map("n", "<c-f>", "<c-f>zz")
map("n", "<c-b>", "<c-b>zz")

map("c", "w!!", "%!sudo tee > /dev/null %")
map("n", "Q", "<NOP>")

map({ "n", "v" }, ";", ":")

map("n", ",p", '"0p')
map("n", ",P", '"0P')

map("x", "p", '"_dP', { desc = "Make the overwriting paste in visual mode keep the last yank" })

map(
  "i",
  "<C-l>",
  "<c-g>u<Esc>[s1z=`]a<c-g>u",
  { desc = "fix the last spelling mistake and continue at the same insert mode position with ctrl-l" }
)
map("n", "<CR>", "gd", { desc = "Map Enter to go to definition" })
