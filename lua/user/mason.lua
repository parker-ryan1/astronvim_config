-- Mason configuration for AstroVim with full language support for top 20+ languages

return {
  -- Mason core setup
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP Servers
        "clangd",                     -- C/C++
        "rust-analyzer",              -- Rust
        "pyright",                    -- Python
        "typescript-language-server", -- TypeScript/JavaScript
        "tailwindcss-language-server",-- Tailwind CSS
        "json-lsp",                   -- JSON
        "lua-language-server",        -- Lua
        "r-languageserver",           -- R
        "jdtls",                      -- Java
        "omnisharp",                  -- C#
        "gopls",                      -- Go
        "ruby_lsp",                   -- Ruby
        "intelephense",               -- PHP
        "kotlin-language-server",     -- Kotlin
        "html-lsp",                   -- HTML
        "css-lsp",                    -- CSS
        "bash-language-server",       -- Bash/Shell
        "sqlls",                      -- SQL
        "yaml-language-server",       -- YAML
        "taplo",                      -- TOML
        "marksman",                   -- Markdown
        
        -- Debug Adapters
        "cpptools",                   -- C/C++ debugging
        "debugpy",                    -- Python debugging
        "js-debug-adapter",           -- JavaScript/TypeScript debugging
        "lldb",                       -- Rust/C/C++ debugging (alternative)
        "java-debug-adapter",         -- Java debugging
        "java-test",                  -- Java testing
        "netcoredbg",                 -- C# debugging
        "delve",                      -- Go debugging
        "ruby-debug-adapter",         -- Ruby debugging
        "php-debug-adapter",          -- PHP debugging
        "bash-debug-adapter",         -- Bash debugging
        "codelldb",                   -- Rust/C/C++ debugging (alternative)
        
        -- Linters
        "clang-format",               -- C/C++
        "cpplint",                    -- C/C++
        "rustfmt",                    -- Rust
        "clippy",                     -- Rust
        "prettier",                   -- JS/TS/HTML/CSS/JSON/YAML/Markdown
        "eslint-lsp",                 -- JS/TS
        "pylint",                     -- Python
        "black",                      -- Python
        "isort",                      -- Python
        "ruff",                       -- Python
        "stylua",                     -- Lua
        "golangci-lint",              -- Go
        "rubocop",                    -- Ruby
        "phpcs",                      -- PHP
        "ktlint",                     -- Kotlin
        "shellcheck",                 -- Bash/Shell
        "sqlfluff",                   -- SQL
        
        -- Formatters
        "shfmt",                      -- Bash/Shell
        "latexindent",                -- LaTeX
        "gofumpt",                    -- Go
        "goimports",                  -- Go
        "phpcbf",                     -- PHP
        "csharpier",                  -- C#
        
        -- Tools
        "tree-sitter-cli",            -- Treesitter parser generator
      },
    },
  },
  
  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "rust_analyzer",
        "pyright",
        "tsserver",
        "tailwindcss",
        "jsonls",
        "lua_ls",
        "r_language_server",
        "jdtls",
        "omnisharp",
        "gopls",
        "ruby_lsp",
        "intelephense",
        "kotlin_language_server",
        "html",
        "cssls",
        "bashls",
        "sqlls",
        "yamlls",
        "taplo",
        "marksman",
      },
      automatic_installation = true,
    },
  },
  
  -- LSP Config with language-specific settings
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- C/C++
        clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname) or vim.loop.os_homedir()
          end,
          settings = {
            clangd = {
              inlayHints = { enabled = true, parameterNames = true, deducibleTemplates = true },
              path = { compilationDatabasePath = "build/" },
            },
          },
        },
        
        -- Rust
        rust_analyzer = {
          cmd = { "rust-analyzer" },
          filetypes = { "rust" },
          root_dir = require("lspconfig").util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
          settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy", extraArgs = { "--", "-D", "warnings" } },
              cargo = { features = "all", loadOutDirsFromCheck = true, allFeatures = true },
              diagnostics = { enable = true, disabled = {} },
              inlayHints = { bindingModeHints = true, closureReturnTypeHints = "always", typeHints = true, parameterHints = true, chainingHints = true, maxLength = 25 },
              procMacro = { enable = true },
            },
          },
        },
        
        -- Python
        pyright = {
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_dir = require("lspconfig").util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "strict",
                autoImportCompletions = true,
                inlayHints = { variableTypes = true, functionReturnTypes = true, callArgumentNames = true },
              },
            },
          },
        },
        
        -- TypeScript/JavaScript
        tsserver = {
          cmd = { "typescript-language-server", "--stdio" },
          filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
          root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
          settings = {
            completions = { completeFunctionCalls = true },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = { completeFunctionCalls = true },
              diagnostics = { enable = true, run = "onSave" },
              rename = { enable = true },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = { completeFunctionCalls = true },
            },
          },
        },
        
        -- Tailwind CSS
        tailwindcss = {
          filetypes = { "typescriptreact", "javascriptreact", "html", "css", "scss" },
          root_dir = require("lspconfig").util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json"),
        },
        
        -- R
        r_language_server = {
          cmd = { "R", "--slave", "-e", "languageserver::run()" },
          filetypes = { "r", "rmd" },
          root_dir = require("lspconfig").util.root_pattern(".git", "DESCRIPTION", ".Rprofile"),
          settings = { r = { lsp = { useDocumentHighlight = true } } },
        },
        
        -- Lua
        lua_ls = {
          cmd = { "lua-language-server" },
          filetypes = { "lua" },
          root_dir = require("lspconfig").util.root_pattern(".luarc.json", ".luarc.jsonc", ".git"),
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" }, enable = true },
              workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
              telemetry = { enable = false },
              completion = { callSnippet = "Both" },
              format = { enable = true, defaultConfig = { indent_style = "space", indent_size = "2" } },
            },
          },
        },
        
        -- Go
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true, shadow = true },
              staticcheck = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        
        -- HTML/CSS/JSON/YAML
        html = {},
        cssls = {},
        jsonls = {
          settings = { json = { validate = { enable = true } } },
        },
        yamlls = {
          settings = { yaml = { keyOrdering = false } },
        },
        
        -- Bash
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        
        -- C#
        omnisharp = {
          cmd = { "omnisharp" },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
        
        -- PHP
        intelephense = {
          settings = { intelephense = { files = { maxSize = 1000000 } } },
        },
        
        -- Ruby
        ruby_lsp = {},
        
        -- Kotlin
        kotlin_language_server = {},
        
        -- Java (Note: jdtls often requires specific nvim-jdtls plugin setup for full functionality, but this provides basic LSP)
        jdtls = {},
        
        -- SQL
        sqlls = {},
        
        -- TOML / Markdown
        taplo = {},
        marksman = {},
      },
      
      -- LSP setup handlers
      setup = {
        clangd = function(_, opts) require("lspconfig").clangd.setup(opts) end,
        rust_analyzer = function(_, opts) require("lspconfig").rust_analyzer.setup(opts) end,
        pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end,
        -- AstroVim typically handles the rest automatically if not specified in setup
      },
    },
  },
  
  -- Null-ls for additional formatting/linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
      local null_ls = require("null-ls")
      
      if not config.sources then config.sources = {} end
      
      local sources = {
        -- C/C++
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.cpplint,
        
        -- Rust
        null_ls.builtins.diagnostics.clippy,
        
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.pylint,
        
        -- JS/TS/HTML/CSS/JSON/YAML/Markdown
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
        
        -- Go
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint,
        
        -- Ruby
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.formatting.rubocop,
        
        -- PHP
        null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.formatting.phpcbf,
        
        -- C#
        null_ls.builtins.formatting.csharpier,
        
        -- Kotlin
        null_ls.builtins.diagnostics.ktlint,
        null_ls.builtins.formatting.ktlint,
        
        -- Shell/Bash
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,
        
        -- SQL
        null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
        null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
        
        -- R
        null_ls.builtins.formatting.styler,
        
        -- Lua
        null_ls.builtins.formatting.stylua,
      }
      
      vim.list_extend(config.sources, sources)
      return config
    end,
  },
  
  -- DAP configuration for debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- C/C++
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
      }
      
      -- Rust/C/C++ alternative
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }
      
      -- Python
      require("dap-python").setup("debugpy")
      
      -- JavaScript/TypeScript
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = { command = "js-debug-adapter", args = { "${port}" } },
      }
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = { command = "js-debug-adapter", args = { "${port}" } },
      }
      
      -- Go
      dap.adapters.go = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/go-debug-adapter/extension/dist/debugAdapter.js" },
      }
      
      -- C#
      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      
      -- PHP
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
      }
      
      -- Ruby
      dap.adapters.ruby = {
        type = "executable",
        command = "bundle",
        args = { "exec", "readapt", "stdio" },
      }
      
      -- Bash
      dap.adapters.bashdb = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
        name = "bashdb",
      }
      
      -- DAP UI setup
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
      
      -- Virtual text for debug values
      require("nvim-dap-virtual-text").setup()
    end,
  },
}