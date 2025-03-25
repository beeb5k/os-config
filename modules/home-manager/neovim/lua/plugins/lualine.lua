return {{require('lualine').setup {
    options = {
        theme = 'auto',
        laststatus = 2,
        globalstatus = true
    }, -- Default theme
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}}}
