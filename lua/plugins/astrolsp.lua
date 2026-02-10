-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- :h astrolsp

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    -- LSP features
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },

    -- Formatting behavior
    formatting = {
      format_on_save = {
        enabled = true,
      },
      timeout_ms = 1000,
    },

    -- ⭐ ENABLE LANGUAGE SERVERS HERE
    -- Mason will auto-install these
    servers = {
      "pyright", -- Python ✅
    },

    -- Optional per-server config
    config = {
      -- pyright = {},
    },

    -- Custom handlers (leave default)
    handlers = {},

    -- Keymaps on LSP attach
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle semantic tokens (buffer)",
          cond = function(client) return client.supports_method "textDocument/semanticTokens/full" end,
        },
      },
    },
  },
}
