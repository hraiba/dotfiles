return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }
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
      sections = {
        lualine_a={"mode", job_indicator}
      }
    })
  end,
}
