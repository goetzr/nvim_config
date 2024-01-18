-- move selected lines up/down, adjusting indent as necessary
-- '>+1, :h range, navigate to section 10.3, move down to "USING MARKS" and
--     "VISUAL MODE AND RANGES"
-- =, :h v_=, adjusts the indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
