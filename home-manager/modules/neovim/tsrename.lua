vim.api.nvim_create_autocmd('FileType', {
  pattern = { "*.ts" },
  callback = function()
    function LSPRename(args)
      local curr_name = vim.fn.expand("%:p")

      local current_file = vim.fn.input("LSP Rename from: ", curr_name)

      local new_name = vim.fn.input("To: ", current_file)

      if new_name == "" or new_name == current_file then
          return
      end

      local lsp_params = vim.lsp.util.make_position_params()

      lsp_params.command = "_typescript.applyRenameFile"
      lsp_params.arguments = {
        {
          sourceUri = current_file,
          targetUri = new_name,
        }
      }
      vim.lsp.buf_request(0, "workspace/executeCommand", lsp_params, function(_, res, ctx, _)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.loop.fs_rename(current_file, new_name)
      end)
    end

    vim.api.nvim_create_user_command("LspRename", LSPRename, { desc = "test desc" })
  end
})
