return {
  n = {
    -- VS Code Debugging Keybinds
    ["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start/Continue" },
    ["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" },
    ["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" },
    ["<F12>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" },
    ["<S-F5>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" },
    ["<C-F5>"] = { function() require("dap").restart() end, desc = "Debugger: Restart" },
    ["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" },

    -- Run without debugging (VS Code style run)
    ["<A-r>"] = { 
      function()
        local filetype = vim.bo.filetype
        local file = vim.fn.expand("%")
        local file_no_ext = vim.fn.expand("%:r")
        local cmd = ""
        
        if filetype == "python" then cmd = "python3 " .. file
        elseif filetype == "javascript" then cmd = "node " .. file
        elseif filetype == "typescript" then cmd = "npx tsx " .. file
        elseif filetype == "rust" then
          -- Check if it's a cargo project
          if vim.fn.filereadable("Cargo.toml") == 1 then
            cmd = "cargo run"
          else
            cmd = "rustc " .. file .. " && ./" .. file_no_ext
          end
        elseif filetype == "c" then cmd = "gcc " .. file .. " -o " .. file_no_ext .. " && ./" .. file_no_ext
        elseif filetype == "cpp" then cmd = "g++ " .. file .. " -o " .. file_no_ext .. " && ./" .. file_no_ext
        elseif filetype == "java" then cmd = "java " .. file
        elseif filetype == "go" then cmd = "go run " .. file
        elseif filetype == "ruby" then cmd = "ruby " .. file
        elseif filetype == "php" then cmd = "php " .. file
        elseif filetype == "lua" then cmd = "lua " .. file
        elseif filetype == "sh" then cmd = "bash " .. file
        elseif filetype == "r" then cmd = "Rscript " .. file
        else
          vim.notify("No run command for filetype: " .. filetype, vim.log.levels.WARN)
          return
        end
        
        -- Open terminal at bottom and run the command
        require("toggleterm.terminal").Terminal:new({ 
          cmd = cmd, 
          direction = "horizontal", 
          close_on_exit = false,
          hidden = false
        }):toggle()
      end, 
      desc = "Run Code (ToggleTerm)" 
    },
    ["<leader>rr"] = { "<A-r>", desc = "Run Code", remap = true },
  }
}