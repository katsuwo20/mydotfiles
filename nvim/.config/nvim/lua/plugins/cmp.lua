local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),

        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),

        ["<Tab>"] = cmp.mapping.select_next_item(),

        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
})
