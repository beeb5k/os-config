local load_w_after = require("lzextras").loaders.with_after

return {{
    "cmp-buffer",
    event = "InsertEnter",
    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp-cmdline",
    event = "CmdlineEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp-cmdline-history",
    event = "CmdlineEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp-nvim-lsp",
    on_plugin = {"nvim-cmp"},
    dep_of = {"nvim-lspconfig", "nvim-cmp"},
    load = load_w_after
}, {
    "cmp-nvim-lsp-signature-help",
    dep_of = {"nvim-cmp"},
    event = "DeferredUIEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp-nvim-lua",
    event = "DeferredUIEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp-path",
    event = "InsertEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "cmp_luasnip",
    event = "InsertEnter",

    on_plugin = {"nvim-cmp"},
    load = load_w_after
}, {
    "friendly-snippets",
    event = "DeferredUIEnter",

    dep_of = {"nvim-cmp"}
}, {
    "lspkind.nvim",
    event = "DeferredUIEnter",

    dep_of = {"nvim-cmp"},
    load = load_w_after
}, {
    "luasnip",
    -- event = "DeferredUIEnter",

    dep_of = {"nvim-cmp"},
    after = function(plugin)
        local luasnip = require 'luasnip'
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}

        local ls = require('luasnip')
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local extras = require('luasnip.extras')
        local rep = extras.rep
        local fmta = require('luasnip.extras.fmt').fmta
        local c = ls.choice_node
        local f = ls.function_node
        local d = ls.dynamic_node
        local sn = ls.snippet_node

        vim.keymap.set({"i", "s"}, "<M-n>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)
    end
}, {
    "nvim-cmp",
    event = "DeferredUIEnter",

    on_require = "cmp",
    after = function(plugin)
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        cmp.setup {
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'text',
                    with_text = true,
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                    menu = {
                        buffer = '[BUF]',
                        nvim_lsp = '[LSP]',
                        nvim_lsp_signature_help = '[LSP]',
                        nvim_lsp_document_symbol = '[LSP]',
                        nvim_lua = '[API]',
                        path = '[PATH]',
                        luasnip = '[SNIP]'
                    }
                }
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-p>'] = cmp.mapping.scroll_docs(-4),
                ['<C-n>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            },

            sources = cmp.config.sources { -- The insertion order influences the priority of the sources
            {
                name = 'nvim_lsp' --[[ , keyword_length = 3 ]]
            }, {
                name = 'nvim_lsp_signature_help' --[[ , keyword_length = 3  ]]
            }, {
                name = 'path'
            }, {
                name = 'luasnip'
            }, {
                name = 'buffer'
            }},
            enabled = function()
                return vim.bo[0].buftype ~= 'prompt'
            end,
            experimental = {
                native_menu = false,
                ghost_text = false
            }
        }

        cmp.setup.filetype('lua', {
            sources = cmp.config.sources {{
                name = 'nvim_lua'
            }, {
                name = 'nvim_lsp' --[[ , keyword_length = 3  ]]
            }, {
                name = 'nvim_lsp_signature_help' --[[ , keyword_length = 3  ]]
            }, {
                name = 'path'
            }, {
                name = 'luasnip'
            }, {
                name = 'buffer'
            }},
            {{
                name = 'cmdline',
                option = {
                    ignore_cmds = {'Man', '!'}
                }
            }}
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = 'nvim_lsp_document_symbol' --[[ , keyword_length = 3  ]]
            }, {
                name = 'buffer'
            }, {
                name = 'cmdline_history'
            }},
            view = {
                entries = {
                    name = 'wildmenu',
                    separator = '|'
                }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources {{
                name = 'cmdline'
            }, -- { name = 'cmdline_history' },
            {
                name = 'path'
            }}
        })
    end
}}
