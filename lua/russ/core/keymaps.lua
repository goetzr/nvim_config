-- '>+1, :h range, navigate to section 10.3, move down to "USING MARKS" and
--     "VISUAL MODE AND RANGES"
-- =, :h v_=, adjusts the indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selected lines down, adjusting indent as necessary"
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selected lines up, adjusting indent as necessary"
})

vim.keymap.set("n", "J", "mzJ`z", {
    desc = "Join next line with current, retaining cursor position"
})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {
    desc = "Scroll window down in buffer, redrawing current line \z
            in center of window"
})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {
    desc = "Scroll window up in buffer, redrawing current line \z
            in center of window"
})
vim.keymap.set("n", "n", "nzzzv", {
    desc = "Repeat last pattern search, redrawing current line \z
            in center of window, unfolding to view line if necessary"
})
vim.keymap.set("n", "N", "Nzzzv", {
    desc = "Repeat last reverse pattern search, redrawing current line \z
            in center of window, unfolding to view line if necessary"
})

vim.keymap.set("x", "<leader>p", [["_dP]], {
    desc = "Deletes the selected text, not ovewriting the last yanked text, \z
            then pastes the last yanked text in its place."
})

vim.keymap.set("i", "<C-v>", [[<Esc>"+p`]A]], {
    desc = "Pastes the text in the system clipboard at the cursor location."
})
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], {
    desc = "Yank text into the system clipboard so the yanked text can be \z
            pasted into another application."
})
vim.keymap.set("n", "<leader>Y", [["+Y]], {
    desc = "Yank lines into the system clipboard so the yanked lines can be \z
            pasted into another application."
})

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], {
    desc = "Deletes the selected text, not overwriting the last yanked text."
})

-- the '!' is the ':!' ex command, which executes tmux in the shell
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", {
    desc = ""
})

-- in a pattern "\<" matches the beginning of a word (:h /ordinary-atom, :h /\<)
-- in a pattern "\>" matches the end of a word (:h /ordinary-atom, :h /\>)
-- in command mode, <C-r><C-w> inserts the word under the cursor (:h c_<C-R>_<C-W>)
-- in command mode, <Left> moves the cursor to the left one (:h c_<Left>)
-- NOTE: <CR> is not specified, so the substitution is not executed
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
        desc = "Prepares a global substitution of the word under the cursor."
})

vim.keymap.set("i", "<C-o>", "<Esc>O", {
    desc = "Insert blank line above the current line, remaining in insert mode."
})

vim.keymap.set("i", "<C-j>", "<Esc>", {
    desc = "Faster way to exit insert mode."
})

vim.keymap.set("n", "p", "p`]", {
    desc = "Make paste move to the end of the pasted text automatically."
})
