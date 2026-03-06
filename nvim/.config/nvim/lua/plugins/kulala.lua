return {
  "mistweaverco/kulala.nvim",
  config = function()
    require("kulala").setup({
      -- Default request timeout
      default_timeout = 5000,
      -- Show icons in the request list
      folding = true,
      icons = {
        inlay = {
          loading = "⏳",
          done = "✅",
        },
        -- lualine = "🐼",
      },
    })
    vim.keymap.set("n", "<leader>rr", require("kulala").run, { desc = "Execute HTTP request" })
    vim.keymap.set("n", "<leader>ra", require("kulala").run_all, { desc = "Execute all HTTP requests" })
    vim.keymap.set("n", "<leader>ri", require("kulala").inspect, { desc = "Inspect HTTP request" })
    vim.keymap.set("n", "<leader>rt", require("kulala").toggle_view, { desc = "Toggle response view" })
  end,
}
