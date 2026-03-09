return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  event = "VeryLazy",
  opts = {
    windows = {
      sidebar_header ={
        enable =false,
      },
      input = {
        prefix = "> ",
      }
    },
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    render_mode = "stream",
    providers = {
      copilot = {
        model = "gpt-4o-2024-08-06",
        proxy =nil,
        allow_insecure =false,
      },
    },
  },
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "github/copilot.vim",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
