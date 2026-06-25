local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "copilot"},
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


    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

})
