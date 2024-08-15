return {
	'nvim-telescope/telescope.nvim',
	tag = "0.1.3",
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		"nvim-telescope/telescope-project.nvim"
	},
	opts = {}, -- define config options here, or use a config() function
	config = function()
		require('telescope').load_extension('project')
	end,
	keys = {
		{ '<leader>ff', function() require 'telescope.builtin'.find_files() end,           desc = 'Find files',  mode = 'n' },
		{ '<leader>fg', function() require('telescope.builtin').live_grep() end,           desc = 'Live grep',   mode = 'n' },
		{ '<leader>fb', function() require('telescope.builtin').buffers() end,             desc = 'Buffers',     mode = 'n' },
		{ '<leader>fh', function() require('telescope.builtin').help_tags() end,           desc = 'Help tags',   mode = 'n' },
		{ '<leader>fp', function() require('telescope').extensions.project.project {} end, desc = 'Projects',    mode = 'n' },
		{ '<leader>fd', "<cmd>Telescope diagnostics<CR>",                                  desc = 'Diagnostics', mode = 'n' }
	},
}
