local lspconfig = require("lspconfig")

-- local capabilities = require('blink.cmp').default_capabilities()

lspconfig.tinymist.setup {
  settings = {
    exportPdf = "onType"
  },
  -- capabilities = capabilities,
  root_dir = function() vim.fn.getcwd() end,
  single_file_support = true
}

lspconfig.pyright.setup {
  -- capabilities = capabilities
}
lspconfig.rust_analyzer.setup {
  -- capabilities = capabilities
}
lspconfig.gopls.setup {
  -- capabilities = capabilities
}
lspconfig.ts_ls.setup {
  -- capabilities = capabilities
}
lspconfig.ccls.setup {
  -- capabilities = capabilities
}
lspconfig.elixirls.setup {
  -- capabilities = capabilities,
  cmd = { "elixir-ls" },
  root_dir = function() vim.fn.getcwd() end,
}
lspconfig.zls.setup {
  -- capabilities = capabilities
}

vim.api.nvim_create_autocmd(
  {
    "BufNewFile",
    "BufRead"
  },
  {
    pattern = "*.typ",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(buf, "filetype", "typst")
    end
  }
)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf };

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>ll', vim.diagnostic.open_float, opts)
    vim.keymap.set({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end
})

