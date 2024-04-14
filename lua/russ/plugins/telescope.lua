return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
    },
    config = function()
        local map = function(mode, keys, func, desc)
            require("russ.core.util").map("telescope", mode, keys, func, desc)
        end

        local telescope = require("telescope")
        telescope.setup()
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        map("n", "<leader>ff", builtin.find_files, "[F]ind [F]iles")
        map("n", "<leader>fb", builtin.buffers, "[F]ind [B]uffers")
        map("n", "<leader>fh", builtin.help_tags, "[F]ind [H]elp tags")
        -- NOTE: Hitting ctrl-q in this window adds the diagnostics to the quickfix window
        map("n", "<leader>dl", builtin.diagnostics, "[D]iagnostics [L]ist")
    end
}
