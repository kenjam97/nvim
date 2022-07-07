local Remap = require("kenjam.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")
nnoremap("<M-w>", ":bdelete<CR>")

