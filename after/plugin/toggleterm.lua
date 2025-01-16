require("toggleterm").setup({
	size=10,
	start_in_insert=true,
	direction="float"
})

vim.keymap.set('n','<leader>tt', ':ToggleTerm<CR>', {})

