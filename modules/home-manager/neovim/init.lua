vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmode = false
vim.g.mapleader = '.'
vim.g.maplocalleader = '.'
vim.loader.enable()

require("plugins")

local stylixPalette = nixCats.extra("base16colors")
require('mini.base16').setup({
    palette = {
        base00 = stylixPalette.base00,
        base01 = stylixPalette.base00,
        base02 = stylixPalette.base02,
        base03 = stylixPalette.base03,
        base04 = stylixPalette.base04,
        base05 = stylixPalette.base05,
        base06 = stylixPalette.base06,
        base07 = stylixPalette.base07,
        base08 = stylixPalette.base08,
        base09 = stylixPalette.base09,
        base0A = stylixPalette.base0A,
        base0B = stylixPalette.base0B,
        base0C = stylixPalette.base0C,
        base0D = stylixPalette.base0D,
        base0E = stylixPalette.base0E,
        base0F = stylixPalette.base0F
    }
})

-- Lualine (loads at startup)

require('gitsigns').setup {}
require('which-key').setup {}

-- Lze for lazy-loading
require('lze').load {{
    import = "plugins"
}, {
    'nvim-autopairs',
    event = 'InsertEnter', -- Load on entering insert mode
    after = function() -- Post-load setup
        require('nvim-autopairs').setup {}
    end
}, -- Auto-Save
{
    'auto-save.nvim',
    event = {'InsertLeave', 'TextChanged', 'TextChangedI'}, -- Load on these events
    after = function()
        require('auto-save').setup {}
    end
}}

