return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup()
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {
            desc = "nvim-telescope: find files"
        })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {
            desc = "nvim-telescope: live grep"
        })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {
            desc = "nvim-telescope: buffers"
        })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {
            desc = "nvim-telescope: help tags"
        })
    end
}
