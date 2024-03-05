require("russ.core.options")
require("russ.core.keymaps")

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.md",
    callback = function(ev)
        vim.opt_local.wrap = true
    end
})
