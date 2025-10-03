return {
 "ellisonleao/gruvbox.nvim",
  lazy = false,
  name = "gruvbox",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      italics = {
        comments = true,
        keywords =true,
        functions = true,
        strings =true,
        variables = false,

      },
      contrast = "hard",
      transparent_mode = true,
    })
   -- vim.cmd[[colorscheme gruvbox]]
  end,
}
