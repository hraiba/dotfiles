return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "json",
      "html",
      "lua",
      "rust",
      "csharp",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = vim.lsp.config
      local util = require("lspconfig.util")
      local _border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
      })

      require("lspconfig.ui.windows").default_options = {
        border = _border,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {})
          end
          -- whatever other lsp config you want
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        float = {
          header = false,
          border = "rounded",
          focusable = true,
        },
      })

      local lsps = {
    { "rust_analyzer" },
    { "gopls" },
    { "ts_ls" },
    { "cssls" },
    { "lua_ls" },
    { "hls" },
    { "vue_ls" },
    { "jsonls" },
    { "html" },
    { "csharp_ls" }
      }

for _, lsp in pairs(lsps) do 
        local name, config = lsp[1], lsp[2]
        vim.lsp.enable(name)
        if config then 
          vim.lsp.config(name, config)
        end
      end
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "dp", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "dn", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      -- vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, {})
      vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>")
    end,
  },
}

