local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup_servers({'tsserver', 'eslint', 'rust-analyzer', 'sumneko_lua'})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)

end)

lsp.set_preferences({
  set_lsp_keymaps = {omit = { '<C-k>' }}
})

lsp.setup_nvim_cmp({
    sources = {
        { name = 'nvim_lsp', max_item_count = 10 },
        { name = 'buffer', max_item_count = 10},
    }
})

lsp.setup()

