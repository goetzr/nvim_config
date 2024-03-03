return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        -- NOTE: After starting up nvim, execute:
        --         ":set bg=light" to select the light flavor, or
        --         ":set bg=dark"  to select the dark  flavor
        require("catppuccin").setup({
            background = {
                light = "latte",
                dark = "frappe",
            },
        })
        -- load the colorscheme here
        vim.cmd("colorscheme catppuccin")

        -- set a transparent background
        --vim.cmd.highlight("Normal", "guibg=NONE ctermbg=NONE")
    end,
}
