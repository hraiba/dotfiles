local function toggle_unchanged()
  vim.t.diffview_show_full = not vim.t.diffview_show_full
  for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.wo[winid].diff then
      vim.wo[winid].foldlevel = 0
      vim.wo[winid].foldenable = not vim.t.diffview_show_full
    end
  end
end

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewFocusFiles", "DiffviewToggleFiles" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { winbar_info = true },
      file_history = { winbar_info = true },
    },
    file_panel = { win_config = { width = 28 } },
    hooks = {
      diff_buf_win_enter = function(_, winid, ctx)
        local win = vim.wo[winid]
        win.list = false
        win.wrap = false
        win.cursorline = false
        win.relativenumber = false
        win.signcolumn = "no"
        win.foldlevel = 0
        win.foldenable = not vim.t.diffview_show_full
        vim.opt_local.fillchars:append({ diff = " ", eob = " " })
        local old_side = ctx.layout_name == "diff2_horizontal" and ctx.symbol == "a"
        win.winhighlight = table.concat({
          "Normal:CleanDiffNormal",
          "NormalNC:CleanDiffNormal",
          "DiffAdd:" .. (old_side and "CleanDiffRemoved" or "CleanDiffAdded"),
          "DiffChange:" .. (old_side and "CleanDiffRemoved" or "CleanDiffAdded"),
          "DiffText:" .. (old_side and "CleanDiffRemovedText" or "CleanDiffAddedText"),
          "DiffDelete:CleanDiffFiller",
          "EndOfBuffer:CleanDiffNormal",
        }, ",")
      end,
    },
    keymaps = {
      -- Keep <leader>e available for the global diagnostics mapping.
      view = {
        { "n", "<leader>e", false },
        { "n", "<leader>gu", toggle_unchanged, { desc = "Toggle unchanged code" } },
      },
      file_panel = {
        { "n", "<leader>e", false },
        { "n", "<leader>gu", toggle_unchanged, { desc = "Toggle unchanged code" } },
      },
      file_history_panel = {
        { "n", "<leader>e", false },
        { "n", "<leader>gu", toggle_unchanged, { desc = "Toggle unchanged code" } },
      },
    },
  },
  config = function(_, opts)
    require("diffview").setup(opts)
    local function highlights()
      local function darker_diff_bg(group)
        local color = vim.api.nvim_get_hl(0, { name = group, link = false }).bg
          or vim.api.nvim_get_hl(0, { name = "DiffText", link = false }).bg
          or vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
        if not color then
          return "NONE"
        end

        -- Preserve the theme's hue while making changed words 35% darker.
        local red = math.floor(math.floor(color / 0x10000) * 0.65)
        local green = math.floor((math.floor(color / 0x100) % 0x100) * 0.65)
        local blue = math.floor((color % 0x100) * 0.65)
        return red * 0x10000 + green * 0x100 + blue
      end

      local groups = {
        CleanDiffNormal = { bg = "NONE" },
        CleanDiffAdded = { link = "DiffAdd" },
        CleanDiffRemoved = { link = "DiffDelete" },
        -- Darker word highlights stand out against the softer line backgrounds.
        CleanDiffAddedText = { bg = darker_diff_bg("DiffAdd") },
        CleanDiffRemovedText = { bg = darker_diff_bg("DiffDelete") },
        CleanDiffFiller = { bg = "NONE" },
      }
      for name, spec in pairs(groups) do
        vim.api.nvim_set_hl(0, name, spec)
      end
    end
    highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("CleanDiffview", { clear = true }),
      callback = highlights,
    })
  end,
  keys = {
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git history for current file" },
    {
      "<leader>gv",
      function()
        if require("diffview.lib").get_current_view() then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Toggle git diff",
    },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close git diff" },
  },
}
