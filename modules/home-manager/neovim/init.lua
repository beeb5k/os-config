vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmode = false
vim.g.mapleader = '.'
vim.g.maplocalleader = '.'
vim.loader.enable()
vim.g.loaded_netrwPlugin = 1

require("plugins")

local stylixPalette = nixCats.extra("base16colors")
require('mini.base16').setup({
    palette = (function()
        local palette = {}
        for i = 0, 15 do
            local key = string.format("base%02X", i)
            if key == "base00" or key == "base01" then
                palette[key] = stylixPalette.base00
            else
                palette[key] = stylixPalette[key]
            end
        end
        return palette
    end)()
})

vim.api.nvim_set_hl(0, 'LineNr', {
    fg = stylixPalette.base0F
})

require('which-key').setup {}

require('lze').register_handlers(require('lzextras').lsp)
require('lze').load {{
    import = "plugins"
}, {
    'nvim-autopairs',
    event = 'InsertEnter',
    after = function()
        require('nvim-autopairs').setup {}
    end
}, {
    "comment.nvim",
    event = "BufReadPost",
    after = function()
        require('Comment').setup {}
    end
}, {
    'eyeliner.nvim',
    event = 'DeferredUIEnter',
    after = function()
        require('eyeliner').setup {
            highlight_on_key = true,
            dim = true
        }
    end
}, {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function()
        require('gitsigns').setup {}
    end
}, {
    "noice.nvim", -- Plugin name
    event = "DeferredUIEnter", -- Load lazily
    after = function()
        require("noice").setup {}
    end
}, {
    "oil.nvim",
    event = "CmdlineEnter",
    after = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {"icon", "permissions", "size"},
            keymaps = {
                ["-"] = "actions.parent", -- Your existing keybinding
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split"
            }
        })
    end,
    keys = {{
        "-",
        "<CMD>Oil<CR>",
        desc = "Open Oil"
    } -- Your existing keybinding
    }
}, {
    "nvim-lspconfig",
    event = "DeferredUIEnter",
    for_cat = 'general.lsp',
    on_require = {"lspconfig"},
    lsp = function(plugin)
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        lspconfig[plugin.name].setup {
            capabilities = capabilities,
            settings = plugin.lsp and plugin.lsp.settings or {}
        }
    end
}, {
    "lua_ls",
    lsp = {
        filetypes = {'lua'},
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                formatters = {
                    ignoreComments = true
                },
                signatureHelp = {
                    enabled = true
                },
                diagnostics = {
                    globals = {"vim"},
                    disable = {'missing-fields'}
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        -- '${3rd}/luv/library',
                        -- unpack(vim.api.nvim_get_runtime_file('', true)),
                    }
                },
                completion = {
                    callSnippet = 'Replace'
                },
                telemetry = {
                    enabled = false
                }
            }
        }
    }
}, {
    "pyright",
    lsp = {
        filetypes = {'python'},
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace"
                }
            }
        }
    }
}, {
    "nil_ls",
    lsp = {
        filetypes = {'nix'},
        settings = {
            ['nil'] = {
                formatting = {
                    command = {"nixfmt"}
                }
            }
        }
    }
}}

