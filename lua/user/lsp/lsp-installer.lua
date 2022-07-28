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

local node_servers = {
  "cssls", "html", "jsonls",
  "yamlls", "dockerls", "bashls", "tsserver",
  "pyright", "nimls",
}
for _, server_name in pairs(node_servers) do
  require("lspconfig")[server_name].setup {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
end
-- vim.g.nvim_nim_enable_default_binds = 0
-- local opts = { cmd = {
--   "nimlsp",
--   "/data/work/projects/nim-src/",
-- } }
-- -- local opts = {cmd={
-- --     "/dev/shm/temp-workspaces/langserver/nimls",
-- --   }}
-- require("lspconfig")["nimls"].setup(opts)
-- vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<cr>", { silent = true })
-- vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<cr>", { silent = true })
-- vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<cr>", { silent = true })
-- vim.api.nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<cr>", { silent = true })
