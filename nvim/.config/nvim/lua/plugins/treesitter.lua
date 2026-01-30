return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = { "lua", "xml", "http", "json", "graphql", "c", "c_sharp","rust" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
