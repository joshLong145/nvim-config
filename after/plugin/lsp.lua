local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
'tsserver',
'eslint',
'rust_analyzer',
})

lsp.use('solidity', {
	cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
	filetypes = { 'solidity' },
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true,
})

lsp.setup()
