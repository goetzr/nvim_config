local textobjects = {}

textobjects.select = {
    enable = true,
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
    enable = true,
    -- 't/T' => "type"
    goto_next_start = {
        ["]m"] = "@function.outer",
        ["]t"] = "@class.outer",
    },
    goto_next_end = {
        ["]M"] = "@function.outer",
        ["]T"] = "@class.outer",
    },
    goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[t"] = "@class.outer",
    },
    goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[T"] = "@class.outer",
    },
}

textobjects.swap = {
    enable = true,
    swap_next = {
        ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
        ["<leader>A"] = "@parameter.inner",
    },
}

textobjects.lsp_interop = {
    enable = true,
}

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
