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

map("x", "<leader>p", [["_dP]], "Deletes the selected text, not ovewriting the last yanked text, then pastes the last yanked text in its place")

-- TODO: Trying using autocmds and setreg:
-- https://www.reddit.com/r/neovim/comments/13zrqcs/how_do_you_copypaste_stuff_fromto_vim/
map("i", "<C-v>", [[<Esc>"+p`]A]], "Pastes the text in the system clipboard at the cursor location")
map({ "n", "v" }, "<leader>y", [["+y]], "Yank text into the system clipboard so the yanked text can be pasted into another application")
map("n", "<leader>Y", [["+Y]], "Yank lines into the system clipboard so the yanked lines can be pasted into another application")

map({ "n", "v" }, "<leader>d", [["_d]], "Deletes the selected text, not overwriting the last yanked text")

-- the '!' is the ':!' ex command, which executes tmux in the shell
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", "tmux new tmux_sessionizer")

-- in a pattern "\<" matches the beginning of a word (:h /ordinary-atom, :h /\<)
-- in a pattern "\>" matches the end of a word (:h /ordinary-atom, :h /\>)
-- in command mode, <C-r><C-w> inserts the word under the cursor (:h c_<C-R>_<C-W>)
-- in command mode, <Left> moves the cursor to the left one (:h c_<Left>)
-- NOTE: <CR> is not specified, so the substitution is not executed
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Prepares a global substitution of the word under the cursor")

map("i", "kj", "<Esc>", "Faster way to exit insert mode")

map("n", "p", "p`]", "Make paste move to the end of the pasted text automatically")

map("n", "<leader>bg",
    function()
        if vim.o.bg == "dark" then
            vim.o.bg = "light"
        else
            vim.o.bg = "dark"
        end
    end,
    "Toggle the background color between light and dark"
)

map("n", "<leader>dj", vim.diagnostic.get_next, "Goto next diagnostic")
map("n", "<leader>dk", vim.diagnostic.get_prev, "Goto prev diagnostic")
