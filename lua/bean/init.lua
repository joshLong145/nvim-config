local rt = require("rust-tools")

rt.setup({
	server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- flog keymap
vim.keymap.set("n", "<C-f>", ":Flog<CR>", {
  noremap = true
})

-- tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- nvim dap todo: move this
require("mason-nvim-dap").setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        node2 = function(config)
            config.adapters = {
              type = 'executable';
              command = 'node',
              args = { vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' };
            }
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
    },
})

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

--lazygit
vim.keymap.set("n", "<Leader>ll", ":LazyGit<CR>", {
  noremap = true
});

-- colorscheme
vim.cmd('colorscheme everforest')
