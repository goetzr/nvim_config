local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        require("russ.core.util").map("LSP", "n", keys, func, desc, bufnr)
    end

    local tsb = require("telescope.builtin")
    nmap("gd", tsb.lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", tsb.lsp_references, "[G]oto [R]eferences")
    nmap("gi", tsb.lsp_implementations, "[G]oto [I]mplementation")
    nmap("gt", tsb.lsp_type_definitions, "[G]oto [T]ype Definition")
    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<leader>fc", vim.lsp.buf.format, "[F]ormat [C]ode")
    -- Remember: code actions are context-sensitive.
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("<leader>ds", tsb.lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", tsb.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local lspconfig = require("lspconfig")

        local capabilities = vim.tbl_deep_extend("force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
        })

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
}
