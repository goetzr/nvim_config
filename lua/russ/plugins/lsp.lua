local lsp_on_attach_setup = {
    lua_ls = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            })
        end
    end,
}

local lsp_on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    local setup_fn = lsp_on_attach_setup[client.name]
    if setup_fn then
        setup_fn(client)
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", function()
        vim.lsp.buf.code_action { context = { only = { "quickfix", "refactor", "source" } } }
    end, "[C]ode [A]ction")

    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    -- NOTE: Conflicted with harpoon mapping.
    --nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    -- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    --     vim.lsp.buf.format()
    -- end, { desc = "Format current buffer with LSP" })
    nmap("<leader>fc", function()
        vim.lsp.buf.format { async = true }
    end, "[F]ormat [C]ode")
end

local lsp_servers = {
    rust_analyzer = {},
    lua_ls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local mason_lspconfig = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "cmp_nvim_lsp",
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(lsp_servers),
        })
        mason_lspconfig.setup_handlers {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = vim.tbl_deep_extend("force", capabilities,
                        require("cmp_nvim_lsp").default_capabilities(),
                        lsp_servers[server_name].capabilities or {}),
                    on_attach = lsp_on_attach,
                    settings = lsp_servers[server_name],
                    filetypes = (lsp_servers[server_name] or {}).filetypes,
                })
            end,
        }
    end,
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        mason_lspconfig,
        { "folke/neodev.nvim",       config = true },
    },
}
