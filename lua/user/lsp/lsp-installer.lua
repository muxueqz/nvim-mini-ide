local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end


mason_lspconfig.setup({
  ensure_installed = {
    "sumneko_lua",
  }
})
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }
  end
})
