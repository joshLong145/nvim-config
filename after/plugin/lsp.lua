local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
'tsserver',
'eslint',
'rust_analyzer',
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
end)


lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
    formatting_options = {
	insertSpaces = true,
	trimTrailingWhitespace = true,
	insertFinalNewline = true,
    }
  },
  servers = {
    ['tsserver'] = {'javascript', 'typescript'},
    ['rust_analyzer'] = {'rust'},
  }
})
lsp.setup()
