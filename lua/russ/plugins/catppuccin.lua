return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        -- load the colorschem here
        vim.cmd("colorscheme catppuccin-frappe")
    end,
}
