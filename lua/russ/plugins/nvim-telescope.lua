return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
    },
    config = function()
        t = require("telescope")
        actions = require("telescope.actions")

        t.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = { "<Esc>", type = "command" },
                    },
                    n = {
                        ["<C-j>"] = actions.close,
                    },
                },
            },
        })

        t.load_extension("fzf")

        b = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", b.find_files, {
            desc = "nvim-telescope: find files"
        })
        vim.keymap.set("n", "<leader>fg", b.live_grep, {
            desc = "nvim-telescope: live grep"
        })
        vim.keymap.set("n", "<leader>fb", b.buffers, {
            desc = "nvim-telescope: buffers"
        })
        vim.keymap.set("n", "<leader>fh", b.help_tags, {
            desc = "nvim-telescope: help tags"
        })
    end
}
