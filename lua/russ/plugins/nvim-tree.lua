local function my_on_attach(bufnr)
    print("nvim_tree: my_on_attach running")

    local api = require("nvim-tree.api")

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    --vim.keymap.set("n", "<C-t>",    api.tree.change_root_to_parent,         opts("Up"))
    --vim.keymap.set("n", "?",        api.tree.toggle_help,                   opts("Help"))
end

local function open_nvim_tree(data)
    -- buffer is a directory
    local is_directory = vim.fn.isdirectory(data.file) == 1

    if not is_directory then
        return
    end

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
        --on_attach = my_on_attach,
    })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = open_nvim_tree,
        desc = "Open nvim_tree when neovim is opened with a directory.",
    })

    -- toggle nvim-tree window
    vim.keymap.set(
        "n",
        "<leader>ep",
        "<cmd>NvimTreeToggle<CR>",
        { desc = "nvim-tree: Toggle nvim tree window" }
    )
  end,
}
