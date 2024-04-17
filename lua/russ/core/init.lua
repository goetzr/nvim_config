require("russ.core.options")
require("russ.core.keymaps")

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    callback = function(ev)
        vim.opt_local.wrap = true
    end
})

-- Copy to the system clipboard when focus is lost.
-- This allows the use of all neovim-native yanking capabilities.
vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    callback = function(ev)
        vim.fn.setreg("+", vim.fn.getreg("\""))
    end
})
-- For me it feels most natural to paste from the system clipboard while in insert mode
-- because other applications don't add newlines as appropriate like neovim does when
-- yanking text.
-- So instead of the following autocmd, I added a mapping in keymaps.lua
-- for <C-v> in insert mode to paste text from the system clipboard.
--vim.api.nvim_create_autocmd("FocusGained", {
--    pattern = "*",
--    callback = function(ev)
--        vim.fn.setreg("\"", vim.fn.getreg("+"))
--    end
--})
