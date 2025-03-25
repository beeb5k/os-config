return {require("lze").load {{
    import = "plugins.telescope"
}}, { --  Non lazy-loaded plugins
    import = "plugins.treesitter"
}, {
    import = "plugins.lualine"
}}
