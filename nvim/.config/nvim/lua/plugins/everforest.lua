return {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.everforest_enable_italic = true
        vim.g.everforest_background = 'soft'
        vim.g.everforest_transparent_background = 1
        -- vim.g.everforest_float_style= 'dim'
        vim.g.everforest_inlay_hints_background = 'dimmed'
        vim.cmd[[colorscheme everforest]]
      end
    }
