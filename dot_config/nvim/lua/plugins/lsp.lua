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

			-- Setup cmp with options
			opts.snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					-- Uncomment and use the snippet engine you prefer:
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					vim.snippet.expand(args.body) -- For native Neovim snippets (Neovim v0.10+)
				end,
			}

			opts.mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			})

			opts.sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' }, -- For vsnip users.
				-- { name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'buffer' },
				{ name = 'nvim_lsp_signature_help' }
			})

			return opts
		end,
		keys = {
			{ "<C-b>",     function() require('cmp').mapping.scroll_docs(-4) end,            mode = "i", desc = "Scroll docs up" },
			{ "<C-f>",     function() require('cmp').mapping.scroll_docs(4) end,             mode = "i", desc = "Scroll docs down" },
			{ "<C-Space>", function() require('cmp').mapping.complete() end,                 mode = "i", desc = "Trigger completion" },
			{ "<C-e>",     function() require('cmp').mapping.abort() end,                    mode = "i", desc = "Abort completion" },
			{ "<Tab>",     function() require('cmp').mapping.confirm({ select = true }) end, mode = "i", desc = "Confirm selection" },
		},
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	}
}
