return {{
    'telescope.nvim',
    cmd = 'Telescope',
    keys = '<leader>ff',
    after = function()
        require('telescope').setup {}
        vim.keymap.set('n', '<leader>ff', ':Telescope fd<CR>', {
            desc = 'Find Files'
        })
    end
}}
