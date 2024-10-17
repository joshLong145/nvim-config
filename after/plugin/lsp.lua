local lspz = require('lsp-zero')

lspz.preset('recommended')

lspz.ensure_installed({
'ts_ls',
'eslint',
'rust_analyzer',
'denols'
})

require("mason").setup()
local lsp = require("mason-lspconfig")
lsp.setup()

require("lspconfig").denols.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end,
  root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
}

require("lspconfig").ts_ls.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end,
  root_dir = require("lspconfig").util.root_pattern("package.json"),
  single_file_support = false,
  settings = {
    expose_as_code_action = {
      "fix_all",
      "add_missing_imports",
      "remove_unused_imports"
    },
    tsserver_file_preferences = {
       includeInlayParameterNameHints = "all",
       includeCompletionsForModuleExports = true,
       quotePreferences = "auto"
    },
    code_lens = "on"
  }
}

lspz.setup()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local builtin = require "telescope.builtin"

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })
        end,
      })


local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
  }),
})
