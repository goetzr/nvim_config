return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    config = function()
        --textobjects = {}

        --textobjects.select = {
        --    enable = true,
        --    keymaps = {
        --        ["aa"] = "@parameter.outer",
        --        ["ia"] = "@parameter.inner",
        --        ["af"] = "@function.outer",
        --        ["if"] = "@function.inner",
        --        ["ac"] = "@class.outer",
        --        ["ic"] = "@class.inner",
        --    },
        --}

        --textobjects.move = {
        --    enable = true,
        --    set_jumps = true,
        --    goto_next_start = {
        --      ["]m"] = "@function.outer",
        --      ["]]"] = "@class.outer",
        --    },
        --    goto_next_end = {
        --      ["]M"] = "@function.outer",
        --      ["]["] = "@class.outer",
        --    },
        --    goto_previous_start = {
        --      ["[m"] = "@function.outer",
        --      ["[["] = "@class.outer",
        --    },
        --    goto_previous_end = {
        --      ["[M"] = "@function.outer",
        --      ["[]"] = "@class.outer",
        --    },
        --}

        --textobjects.swap = {
        --    enable = true,
        --    swap_next = {
        --        ["<leader>a"] = "@parameter.inner",
        --    },
        --    swap_previous = {
        --        ["<leader>A"] = "@parameter.inner",
        --    },
        --}

        vim.defer_fn(function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "bash", "cmake", "lua", "make", "query", "rust", "toml", "vim", "vimdoc" },
                highlight = { enable = true },
                indent = { enable = true },
                --incremental_selection = {
                --    enable = true,
                --    keymaps = {
                --        init_selection = "<c-space>",
                --        node_incremental = "<c-space>",
                --        scope_incremental = "<c-s>",
                --        node_decremental = "<M-space>",
                --    },                
                --},
                --textobjects = textobjects,
            })
        end, 0)
    end
}
