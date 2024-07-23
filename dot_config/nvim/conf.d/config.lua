-- general settings
vim.cmd.colorscheme "catppuccin-frappe"
vim.g.mapleader = " "
vim.wo.relativenumber = true

-- CHADTree
vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>CHADopen<CR>', { noremap = true, silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

