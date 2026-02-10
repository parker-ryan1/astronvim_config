return {
  -- Terminal with persistent open
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 20,
      open_mapping = [[<F7>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,
      start_in_insert = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = false, -- Change this to false!
      autochdir = false,
      highlights = {
        Normal = {
          guibg = "NONE",
        },
        NormalFloat = {
          guibg = "NONE",
        },
        FloatBorder = {
          guifg = "#3b4261",
          guibg = "NONE",
        },
      },
      float_opts = {
        border = "rounded",
        width = 100,
        height = 30,
        winblend = 0,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- Custom commands for running files
      local Terminal = require("toggleterm.terminal").Terminal

      -- Python runner
      local python_term = Terminal:new {
        cmd = "python3",
        dir = "git_dir",
        hidden = true,
        direction = "horizontal",
        close_on_exit = false,
      }

      -- C++ runner
      local cpp_term = Terminal:new {
        cmd = "bash",
        dir = "git_dir",
        hidden = true,
        direction = "horizontal",
        close_on_exit = false,
      }

      -- Rust runner
      local rust_term = Terminal:new {
        cmd = "bash",
        dir = "git_dir",
        hidden = true,
        direction = "horizontal",
        close_on_exit = false,
      }

      -- Set global functions
      _G._RUN_PYTHON = function()
        local file = vim.fn.expand "%:p"
        python_term:change_dir(vim.fn.getcwd())
        python_term:send("python3 " .. file)
        python_term:toggle()
      end

      _G._RUN_CPP = function()
        local file = vim.fn.expand "%:p"
        local output = vim.fn.expand "%:p:r"
        cpp_term:change_dir(vim.fn.getcwd())
        cpp_term:send("g++ -std=c++17 -o " .. output .. " " .. file .. " && " .. output)
        cpp_term:toggle()
      end

      _G._RUN_RUST = function()
        rust_term:change_dir(vim.fn.getcwd())
        rust_term:send "cargo run"
        rust_term:toggle()
      end
    end,
  },
}
