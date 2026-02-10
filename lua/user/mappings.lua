return {
  n = {
    -- =====================
    -- GENERAL CODING
    -- =====================

    -- Run current file
    ["<F5>"] = {
      function()
        local filetype = vim.bo.filetype
        local filename = vim.fn.expand "%:p"

        if filetype == "python" then
          vim.cmd("terminal python3 " .. filename)
        elseif filetype == "cpp" or filetype == "c" then
          local output = vim.fn.expand "%:p:r"
          vim.cmd("terminal g++ -std=c++17 -o " .. output .. " " .. filename .. " && " .. output)
        elseif filetype == "rust" then
          vim.cmd "terminal cargo run"
        elseif filetype == "lua" then
          vim.cmd("terminal lua " .. filename)
        elseif filetype == "javascript" or filetype == "typescript" then
          vim.cmd("terminal node " .. filename)
        else
          print("No run command for filetype: " .. filetype)
        end
      end,
      desc = "Run current file",
    },

    -- Build/Run with make
    ["<F6>"] = {
      function()
        if vim.fn.filereadable "Makefile" == 1 or vim.fn.filereadable "makefile" == 1 then
          vim.cmd "terminal make"
        elseif vim.fn.filereadable "CMakeLists.txt" == 1 then
          vim.cmd "terminal mkdir -p build && cd build && cmake .. && make"
        elseif vim.bo.filetype == "rust" then
          vim.cmd "terminal cargo build"
        else
          print "No build system detected"
        end
      end,
      desc = "Build project",
    },

    -- Toggle terminal
    ["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },

    -- =====================
    -- DEBUGGING KEYBINDS
    -- =====================

    ["<leader>db"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    ["<leader>dc"] = { "<cmd>lua require('dap').continue()<cr>", desc = "Continue/Start debug" },
    ["<leader>ds"] = { "<cmd>lua require('dap').step_over()<cr>", desc = "Step over" },
    ["<leader>di"] = { "<cmd>lua require('dap').step_into()<cr>", desc = "Step into" },
    ["<leader>do"] = { "<cmd>lua require('dap').step_out()<cr>", desc = "Step out" },
    ["<leader>dr"] = { "<cmd>lua require('dap').repl.open()<cr>", desc = "Open REPL" },
    ["<leader>du"] = { "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle debug UI" },
    ["<leader>dt"] = { "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate debug" },

    -- =====================
    -- TESTING KEYBINDS
    -- =====================

    ["<leader>tt"] = { "<cmd>lua require('neotest').run.run()<cr>", desc = "Run test" },
    ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run test file" },
    ["<leader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug test" },
    ["<leader>ts"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle test summary" },
    ["<leader>to"] = { "<cmd>lua require('neotest').output.open()<cr>", desc = "Open test output" },

    -- =====================
    -- CODE NAVIGATION
    -- =====================

    ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go to definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to declaration" },
    ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Show references" },
    ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "Go to implementation" },
    ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show documentation" },

    -- =====================
    -- CODE ACTIONS
    -- =====================

    ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" },
    ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
    ["<leader>f"] = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format buffer" },

    -- =====================
    -- TERMINAL CONTROLS
    -- =====================

    ["<leader>gg"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Lazygit" },
    ["<leader>tn"] = { "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal terminal" },
    ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Vertical terminal" },

    -- =====================
    -- QUICK FIX / LOCATION LIST
    -- =====================

    ["<leader>q"] = { "<cmd>cclose<cr>", desc = "Close quickfix" },
    ["<leader>Q"] = { "<cmd>lclose<cr>", desc = "Close location list" },
    ["[q"] = { "<cmd>cprev<cr>", desc = "Previous quickfix item" },
    ["]q"] = { "<cmd>cnext<cr>", desc = "Next quickfix item" },

    -- =====================
    -- TOGGLE UI ELEMENTS
    -- =====================

    ["<leader>uT"] = { "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    ["<leader>uz"] = { "<cmd>ZenMode<cr>", desc = "Toggle Zen mode" },
    ["<leader>ub"] = { "<cmd>lua require('dapui').float_element('breakpoints')<cr>", desc = "Toggle breakpoints panel" },
    ["<leader>us"] = { "<cmd>lua require('dapui').float_element('scopes')<cr>", desc = "Toggle scopes panel" },

    -- =====================
    -- SNIPPETS & COMPLETION
    -- =====================

    ["<C-j>"] = {
      function()
        if vim.fn.pumvisible() == 1 then
          return "<C-n>"
        elseif require("luasnip").expand_or_jumpable() then
          return "<cmd>lua require('luasnip').expand_or_jump()<cr>"
        else
          return "<C-j>"
        end
      end,
      desc = "Next item or expand snippet",
      expr = true,
      silent = true,
    },

    ["<C-k>"] = {
      function()
        if vim.fn.pumvisible() == 1 then
          return "<C-p>"
        elseif require("luasnip").jumpable(-1) then
          return "<cmd>lua require('luasnip').jump(-1)<cr>"
        else
          return "<C-k>"
        end
      end,
      desc = "Prev item or jump snippet",
      expr = true,
      silent = true,
    },
  },

  t = {
    -- Terminal mode keybinds
    ["<Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", desc = "Move left from terminal" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", desc = "Move down from terminal" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", desc = "Move up from terminal" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", desc = "Move right from terminal" },
  },

  v = {
    -- Visual mode keybinds
    ["<leader>f"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", desc = "Format selection" },
    ["<leader>r"] = { "<cmd>lua require('refactoring').select_refactor()<cr>", desc = "Refactor selection" },
  },

  i = {
    -- Insert mode keybinds
    ["<C-s>"] = { "<cmd>w<cr><esc>", desc = "Save file" },
  },
}
