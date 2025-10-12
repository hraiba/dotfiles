return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        ignore_focus = {},
        always_divide_middle = true,
        -- theme = "rose-pine",
        -- theme = "vscode",
        -- theme = "palenight",
        theme = "gruvbox",
        -- theme = "evil_lualine",
      },
    })
  end,
}
