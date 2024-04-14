return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- LSP completion source
        { "hrsh7th/cmp-nvim-lsp" },
        -- Buffer words completion source
        --{ "hrsh7th/cmp-buffer" },
        -- Filesystem paths completion source
        --{ "hrsh7th/cmp-path" },
        -- Vim command-line completion source
        --{ "hrsh7th/cmp-cmdline" },

        -- Snippet engine
        "L3MON4D3/LuaSnip",
        -- Luasnip completion source
        --{ "saadparwaiz1/cmp_luasnip" },
        -- User-friendly snippets
        --{ "rafamadriz/friendly-snippets" },
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            -- NOTE: Order of sources matter!
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
            },
        })
    end
}
