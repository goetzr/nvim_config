local textobjects = {}

textobjects.select = {
    enable = false,
    keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
    },
}

textobjects.move = {
    enable = false,
    -- 't/T' => "[T]ype"
    -- 'a/A' => "P[a]rameter"
    goto_next_start = {
        ["]m"] = "@function.outer",
        ["]t"] = "@class.outer",
        ["]a"] = "@parameter.outer",
    },
    goto_next_end = {
        ["]M"] = "@function.outer",
        ["]T"] = "@class.outer",
        ["]A"] = "@parameter.outer",
    },
    goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[t"] = "@class.outer",
        ["[a"] = "@parameter.outer",
    },
    goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[T"] = "@class.outer",
        ["[A"] = "@parameter.outer",
    },
}

textobjects.swap = {
    enable = false,
    swap_next = {
        ["<leader>wn"] = "@parameter.inner",
    },
    swap_previous = {
        ["<leader>wp"] = "@parameter.inner",
    },
}

textobjects.lsp_interop = {
    enable = false,
    peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dt"] = "@class.outer",
    },
}

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "bash", "cmake", "java", "lua", "make", "query", "rust", "toml", "vim", "vimdoc" },
            -- builtin modules
            highlight = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>si",
                    node_incremental = "<leader>si",
                    node_decremental = "<leader>sd",
                    scope_incremental = "<leader>ss",
                },                
            },
            indent = { enable = true },
            textobjects = textobjects,
        })
    end
}
