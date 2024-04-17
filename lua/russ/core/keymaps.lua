local map = function(mode, keys, func, desc)
    require("russ.core.util").map("keymaps", mode, keys, func, desc)
end

-- '>+1, :h range, navigate to section 10.3, move down to "USING MARKS" and
--     "VISUAL MODE AND RANGES"
-- =, :h v_=, adjusts the indent
map("v", "J", ":m '>+1<CR>gv=gv", "Move selected lines down, adjusting indent as necessary")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selected lines up, adjusting indent as necessary")

map("n", "J", "mzJ`z", "Join next line with current, retaining cursor position")

map("n", "<C-d>", "<C-d>zz", "Scroll window down in buffer, redrawing current line in center of window")
map("n", "<C-u>", "<C-u>zz", "Scroll window up in buffer, redrawing current line in center of window")
map("n", "n", "nzzzv", "Repeat last pattern search, redrawing current line in center of window, unfolding to view line if necessary")
map("n", "N", "Nzzzv", "Repeat last reverse pattern search, redrawing current line in center of window, unfolding to view line if necessary")

-- **********************************************************************
--                              Copy/paste
-- **********************************************************************
map("n", "p", "p`]", "Make paste move to the end of the pasted text automatically")
map("x", "<leader>p", [["_dP]], "Deletes the selected text, not ovewriting the last yanked text, then pastes the last yanked text in its place")
map({ "n", "v" }, "<leader>d", [["_d]], "Deletes the selected text, not overwriting the last yanked text")
-- Added an autocmd for FocusLost in init.lua for copying from neovim to the system clipboard.
-- Keymap explanation:
--      .     => After adding a newline, you need to type at least one character to retain the indentation.
--               Immediately exiting insert mode removes the indent and places the cursor at the start of the line.
--               I want to retain the indentation; the '.' acts as a dummy character to do this.
--      <Esc> => Exit insert mode.   
--      my    => Set the 'y' mark on the dummy '.' character so we can get back to it later.
--      "+p   => Paste the text from the system clipboard after the dummy '.' character.
--      mz    => Set the 'z' mark on the last character of the text pasted from the system clipboard.
--      `yx   => Jump back to the dummy '.' character and delete it.
--      `za   => Jump to the last character of the pasted text and re-enter insert mode after this character.
map("i", "<C-v>", [[.<Esc>my"+pmz`yx`za]], "Pastes the text in the system clipboard at the cursor location")

-- in a pattern "\<" matches the beginning of a word (:h /ordinary-atom, :h /\<)
-- in a pattern "\>" matches the end of a word (:h /ordinary-atom, :h /\>)
-- in command mode, <C-r><C-w> inserts the word under the cursor (:h c_<C-R>_<C-W>)
-- in command mode, <Left> moves the cursor to the left one (:h c_<Left>)
-- NOTE: <CR> is not specified, so the substitution is not executed
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Prepares a global substitution of the word under the cursor")

map("i", "kj", "<Esc>", "Faster way to exit insert mode")

map("n", "<leader>dj", vim.diagnostic.goto_next, "Goto next diagnostic")
map("n", "<leader>dk", vim.diagnostic.goto_prev, "Goto prev diagnostic")
