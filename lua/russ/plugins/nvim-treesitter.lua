return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "cpp", "bash", "cmake", "lua", "make", "query", "rust", "toml", "vim", "vimdoc" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
