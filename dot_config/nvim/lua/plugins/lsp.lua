return {
	{ "williamboman/mason.nvim", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "gopls", "lua_ls" },
		}

	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").gopls.setup {}
			require("lspconfig").lua_ls.setup {}
		end,
		keys = {
			-- Keymap for LSP actions
			{ "gd",        vim.lsp.buf.definition,     desc = "Go to Definition" },
			{ "gr",        vim.lsp.buf.references,     desc = "Go to References" },
			{ "gi",        vim.lsp.buf.implementation, desc = "Go to Implementation" },
			{ "K",         vim.lsp.buf.hover,          desc = "Hover Documentation" },
			{ "<leader>r", vim.lsp.buf.rename,         desc = "Rename Symbol" }
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		opts = function(_, opts)
			local cmp = require "cmp"
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and
				vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- Setup cmp with options
			opts.snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				end,
			}

			opts.mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			})

			opts.sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' }, -- For vsnip users.
			}, {
				{ name = 'buffer' },
				{ name = 'nvim_lsp_signature_help' }
			})

			return opts
		end,
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	}
}
