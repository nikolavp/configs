-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- For some reason this is needed to be able to copy paste on a remote machine in the terminal
-- see also https://github.com/LazyVim/LazyVim/discussions/2715. Try in a couple of versions if this works
-- out of the box with lazyvim.
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "MatchWord", { fg = "red", underline = true })
