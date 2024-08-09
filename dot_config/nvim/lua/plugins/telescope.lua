return {
	'nvim-telescope/telescope.nvim',
	tag = "0.1.3",
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	opts = {}, -- define config options here, or use a config() function
	keys = {
		{ '<leader>ff', function() require 'telescope.builtin'.find_files() end, mode = 'n' },
		{ '<leader>fg', function() require('telescope.builtin').live_grep() end, mode = 'n' },
		{ '<leader>fb', function() require('telescope.builtin').buffers() end,   mode = 'n' },
		{ '<leader>fh', function() require('telescope.builtin').help_tags() end, mode = 'n' }
	},
}
