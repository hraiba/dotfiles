-- ============================================================================
-- rustaceanvim Complete Configuration
-- ============================================================================
-- Place this file in your Neovim config directory
-- For lazy.nvim users: This should be in your plugins directory
-- ============================================================================

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended to pin to tagged releases
  lazy = false,   -- This plugin is already lazy
  ft = { 'rust' },
  
  config = function()
    vim.g.rustaceanvim = {
      -- ========================================================================
      -- PLUGIN TOOLS CONFIGURATION
      -- ========================================================================
      tools = {
        -- How to execute terminal commands
        -- Options: 'termopen' | 'quickfix' | 'toggleterm' | 'vimux' | 'background'
        executor = 'termopen',
        
        -- Whether to enable Cargo nextest for testables
        enable_nextest = true,
        
        -- Whether to enable clippy checks on save
        enable_clippy = true,
        
        -- Executor for testables
        -- Options: 'termopen' | 'background' | 'neotest'
        test_executor = 'background',
        
        -- Crate graph options
        crate_graph = {
          -- Backend for crate graph visualization
          -- Options: 'x11' | 'png' | 'svg' | 'dot'
          backend = 'x11',
          -- Output path (nil for default)
          output = nil,
          -- Enable full dependencies
          full = true,
          -- Enabled graphviz backends
          enabled_graphviz_backends = {
            'bmp', 'cgimage', 'canon', 'dot', 'gv', 'xdot', 'xdot1.2', 
            'xdot1.4', 'eps', 'exr', 'fig', 'gd', 'gd2', 'gif', 'gtk', 
            'ico', 'cmap', 'ismap', 'imap', 'cmapx', 'imap_np', 'cmapx_np', 
            'jpg', 'jpeg', 'jpe', 'jp2', 'json', 'json0', 'dot_json', 
            'xdot_json', 'pdf', 'pic', 'pct', 'pict', 'plain', 'plain-ext', 
            'png', 'pov', 'ps', 'ps2', 'psd', 'sgi', 'svg', 'svgz', 'tga', 
            'tiff', 'tif', 'tk', 'vml', 'vmlz', 'wbmp', 'webp', 'xlib', 'x11',
          },
        },
        
        -- Hover actions configuration
        hover_actions = {
          -- Auto focus the hover actions window
          auto_focus = false,
          -- Replace the built-in hover handler
          replace_builtin_hover = true,
        },
        
        -- Code actions configuration
        code_actions = {
          -- Use vim.ui.select if there are no grouped code actions
          ui_select_fallback = false,
        },
        
        -- Float window configuration
        float_win_config = {
          -- Whether the float window is always on top
          on_top = false,
          -- Border style: 'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
          border = 'rounded',
          -- Auto focus the float window
          auto_focus = false,
        },
      },
      
      -- ========================================================================
      -- LSP SERVER CONFIGURATION
      -- ========================================================================
      server = {
        -- Callback for when the LSP attaches to the buffer
        on_attach = function(client, bufnr)
          -- Set buffer-local keymaps
          local opts = { buffer = bufnr, silent = true }
          
          -- Code action
          vim.keymap.set('n', '<leader>ca', function()
            vim.cmd.RustLsp('codeAction')
          end, vim.tbl_extend('force', opts, { desc = 'Code Action' }))
          
          -- Hover actions (override default K)
          vim.keymap.set('n', 'K', function()
            vim.cmd.RustLsp { 'hover', 'actions' }
          end, vim.tbl_extend('force', opts, { desc = 'Hover Actions' }))
          
          -- Runnables
          vim.keymap.set('n', '<leader>rr', function()
            vim.cmd.RustLsp('runnables')
          end, vim.tbl_extend('force', opts, { desc = 'Runnables' }))
          
          -- Debuggables
          vim.keymap.set('n', '<leader>rd', function()
            vim.cmd.RustLsp('debuggables')
          end, vim.tbl_extend('force', opts, { desc = 'Debuggables' }))
          
          -- Testables
          vim.keymap.set('n', '<leader>rt', function()
            vim.cmd.RustLsp('testables')
          end, vim.tbl_extend('force', opts, { desc = 'Testables' }))
          
          -- Expand macro
          vim.keymap.set('n', '<leader>em', function()
            vim.cmd.RustLsp('expandMacro')
          end, vim.tbl_extend('force', opts, { desc = 'Expand Macro' }))
          
          -- Rebuild proc macros
          vim.keymap.set('n', '<leader>pm', function()
            vim.cmd.RustLsp('rebuildProcMacros')
          end, vim.tbl_extend('force', opts, { desc = 'Rebuild Proc Macros' }))
          
          -- Move item up/down
          vim.keymap.set('n', '<leader>mu', function()
            vim.cmd.RustLsp { 'moveItem', 'up' }
          end, vim.tbl_extend('force', opts, { desc = 'Move Item Up' }))
          
          vim.keymap.set('n', '<leader>md', function()
            vim.cmd.RustLsp { 'moveItem', 'down' }
          end, vim.tbl_extend('force', opts, { desc = 'Move Item Down' }))
          
          -- Hover range
          vim.keymap.set('v', '<leader>hr', function()
            vim.cmd.RustLsp { 'hover', 'range' }
          end, vim.tbl_extend('force', opts, { desc = 'Hover Range' }))
          
          -- Explain error
          vim.keymap.set('n', '<leader>ee', function()
            vim.cmd.RustLsp('explainError')
          end, vim.tbl_extend('force', opts, { desc = 'Explain Error' }))
          
          -- Render diagnostic
          vim.keymap.set('n', '<leader>ed', function()
            vim.cmd.RustLsp('renderDiagnostic')
          end, vim.tbl_extend('force', opts, { desc = 'Render Diagnostic' }))
          
          -- Related diagnostics
          vim.keymap.set('n', '<leader>er', function()
            vim.cmd.RustLsp('relatedDiagnostics')
          end, vim.tbl_extend('force', opts, { desc = 'Related Diagnostics' }))
          
          -- Open Cargo.toml
          vim.keymap.set('n', '<leader>oc', function()
            vim.cmd.RustLsp('openCargo')
          end, vim.tbl_extend('force', opts, { desc = 'Open Cargo.toml' }))
          
          -- Open docs.rs
          vim.keymap.set('n', '<leader>od', function()
            vim.cmd.RustLsp('openDocs')
          end, vim.tbl_extend('force', opts, { desc = 'Open docs.rs' }))
          
          -- Parent module
          vim.keymap.set('n', '<leader>pm', function()
            vim.cmd.RustLsp('parentModule')
          end, vim.tbl_extend('force', opts, { desc = 'Parent Module' }))
          
          -- Join lines
          vim.keymap.set({ 'n', 'v' }, '<leader>jl', function()
            vim.cmd.RustLsp('joinLines')
          end, vim.tbl_extend('force', opts, { desc = 'Join Lines' }))
          
          -- Structural search replace
          vim.keymap.set({ 'n', 'v' }, '<leader>sr', function()
            vim.cmd.RustLsp('ssr')
          end, vim.tbl_extend('force', opts, { desc = 'Structural Search Replace' }))
          
          -- Crate graph
          vim.keymap.set('n', '<leader>cg', function()
            vim.cmd.RustLsp('crateGraph')
          end, vim.tbl_extend('force', opts, { desc = 'Crate Graph' }))
          
          -- Syntax tree
          vim.keymap.set('n', '<leader>st', function()
            vim.cmd.RustLsp('syntaxTree')
          end, vim.tbl_extend('force', opts, { desc = 'Syntax Tree' }))
          
          -- View HIR
          vim.keymap.set('n', '<leader>vh', function()
            vim.cmd.RustLsp { 'view', 'hir' }
          end, vim.tbl_extend('force', opts, { desc = 'View HIR' }))
          
          -- View MIR
          vim.keymap.set('n', '<leader>vm', function()
            vim.cmd.RustLsp { 'view', 'mir' }
          end, vim.tbl_extend('force', opts, { desc = 'View MIR' }))
          
          -- Fly check
          vim.keymap.set('n', '<leader>fc', function()
            vim.cmd.RustLsp { 'flyCheck', 'run' }
          end, vim.tbl_extend('force', opts, { desc = 'Fly Check Run' }))
          
          vim.keymap.set('n', '<leader>fx', function()
            vim.cmd.RustLsp { 'flyCheck', 'clear' }
          end, vim.tbl_extend('force', opts, { desc = 'Fly Check Clear' }))
          
          vim.keymap.set('n', '<leader>fs', function()
            vim.cmd.RustLsp { 'flyCheck', 'cancel' }
          end, vim.tbl_extend('force', opts, { desc = 'Fly Check Cancel' }))
          
          -- Workspace symbol search
          vim.keymap.set('n', '<leader>ws', function()
            vim.cmd.RustLsp('workspaceSymbol')
          end, vim.tbl_extend('force', opts, { desc = 'Workspace Symbol' }))
          
          -- Enable inlay hints if supported
          -- Wrapped in pcall to handle potential errors gracefully
          -- if client.server_capabilities.inlayHintProvider then
          --   pcall(function()
          --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          --   end)
          -- end
          
          -- You can add more keymaps or LSP-related configurations here
        end,
        
        -- Standalone file support
        standalone = true,
        
        -- Automatically attach to buffers
        auto_attach = true,
        
        -- Default settings for rust-analyzer
        default_settings = {
          ['rust-analyzer'] = {
            -- ================================================================
            -- CARGO CONFIGURATION
            -- ================================================================
            cargo = {
              -- Automatically detect and enable all features
              allFeatures = true,
              -- Load out-of-directory members
              loadOutDirsFromCheck = true,
              -- Build scripts configuration
              buildScripts = {
                enable = true,
              },
            },
            
            -- ================================================================
            -- PROCEDURAL MACROS CONFIGURATION
            -- ================================================================
            procMacro = {
              enable = true,
              -- Ignore certain macros that might cause issues
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
            
            -- ================================================================
            -- CHECK ON SAVE CONFIGURATION
            -- ================================================================
            checkOnSave = true,
            -- Use clippy instead of cargo check
            check = {
              command = 'clippy',
              extraArgs = { '--all', '--', '-W', 'clippy::all' },
            },
            
            -- ================================================================
            -- DIAGNOSTICS CONFIGURATION
            -- ================================================================
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
            
            -- ================================================================
            -- INLAY HINTS CONFIGURATION
            -- ================================================================
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = false,
              },
              closingBraceHints = {
                enable = false,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = 'never',
              },
              lifetimeElisionHints = {
                enable = 'never',
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = false,
              },
              reborrowHints = {
                enable = 'never',
              },
              renderColons = true,
              typeHints = {
                enable = false,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            
            -- ================================================================
            -- COMPLETION CONFIGURATION
            -- ================================================================
            completion = {
              callable = {
                snippets = 'fill_arguments',
              },
            },
            
            -- ================================================================
            -- HOVER CONFIGURATION
            -- ================================================================
            hover = {
              actions = {
                enable = true,
                references = {
                  enable = true,
                },
                run = {
                  enable = true,
                },
                debug = {
                  enable = true,
                },
                gotoTypeDef = {
                  enable = true,
                },
              },
            },
            
            -- ================================================================
            -- LENS CONFIGURATION
            -- ================================================================
            lens = {
              enable = true,
              debug = {
                enable = true,
              },
              implementations = {
                enable = true,
              },
              run = {
                enable = true,
              },
              references = {
                adt = {
                  enable = true,
                },
                enumVariant = {
                  enable = true,
                },
                method = {
                  enable = true,
                },
                trait = {
                  enable = true,
                },
              },
            },
          },
        },
        
        -- Command to start rust-analyzer
        -- nil = automatic detection
        cmd = nil,
        
        -- Initialization options
        init_options = {},
        
        -- LSP capabilities
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      },
      
      -- ========================================================================
      -- DAP (DEBUG ADAPTER PROTOCOL) CONFIGURATION
      -- ========================================================================
      dap = {
        -- Automatically load DAP configurations when LSP attaches
        autoload_configurations = true,
        
        -- DAP adapter configuration
        -- Default: uses lldb-vscode
        adapter = {
          type = 'executable',
          command = 'lldb-vscode', -- or 'lldb-dap'
          name = 'rt_lldb',
        },
        
        -- If you want to use codelldb instead, uncomment and configure:
        -- adapter = require('rustaceanvim.config').get_codelldb_adapter(
        --   '/path/to/codelldb',      -- path to codelldb executable
        --   '/path/to/liblldb.so'     -- path to liblldb (or .dylib on macOS)
        -- ),
        
        -- DAP configuration
        configuration = {
          name = 'Launch',
          type = 'rt_lldb',
          request = 'launch',
          stopOnEntry = false,
          runInTerminal = false,
        },
      },
    }
  end,
}
