-- Ensure packer.nvim is installed{{{
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end--}}}

-- Plugin specifications
return require('packer').startup(function() 
	-- Packer can manage itself 
	use 'wbthomason/packer.nvim'

	-- completion
	use { 'hrsh7th/nvim-cmp', --{{{
		after = { "lspkind-nvim" },
		requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-path", "hrsh7th/cmp-calc" },
		config = function() 
			local lspkind = require('lspkind')
			local cmp = require('cmp')

			cmp.setup {
				-- You must set mapping if you want.
				mapping = {
					['<S-Tab>'] = cmp.mapping.select_prev_item(),
					['<Tab>'] = cmp.mapping.select_next_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.close(),
					['<CR>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					})
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = lspkind.presets.default[vim_item.kind]
						return vim_item
					end
				},

				-- You should specify your *installed* sources.
				sources = {
					{ name = "nvim_lsp" },
					{ name = 'buffer' },
					{ name = 'nvim_lua' },
					{ name = 'path' },
					{ name = 'calc' }
				},
			}
		end
	}--}}}

	-- LSP
	use { 'neovim/nvim-lspconfig',--{{{
		config = function() require'plugins-conf.nvim-lspconfig' end
	}--}}}

	use { "onsails/lspkind-nvim", 
		config = function() 
			require('lspkind').init({
				symbol_map = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "",
					Variable = "",
					Class = "",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "練",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "ﱮ",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = ""
				}
			})
		end
	}

	use { 'glepnir/lspsaga.nvim',--{{{
		config = function() require'plugins-conf.lspsaga' end,
		requires = { 'neovim/nvim-lspconfig' }
	}--}}}

	use { 'folke/trouble.nvim',--{{{
		config = function() require'plugins-conf.trouble' end,
		requires = { 'neovim/nvim-lspconfig' },
		cmd = { "Trouble", "TroubleToggle" }
	}--}}}

	use { "ray-x/lsp_signature.nvim",--{{{
		config = function() require"lsp_signature".setup({
			hint_prefix = "💡 "
		}) end
	}--}}}

	-- Editing
	use { 'mg979/vim-visual-multi', --{{{
		branch = 'master',
		event = "BufRead"
	}--}}}

	use { 'tpope/vim-surround',--{{{
		event = "BufRead"
	} --}}}

	use { "terrortylor/nvim-comment",--{{{
		event = "BufRead",
		cmd = "CommentToggle",
		config = function() 
			require('nvim_comment').setup({
				comment_empty = false
			}) 
		end
	}--}}}

	-- Language specific
	use { 'nvim-treesitter/nvim-treesitter', --{{{
		branch = "0.5-compat", 
		run = ":TSUpdate",
		config = function() require'plugins-conf.nvim-treesitter' end
	}--}}}

	use { "SmiteshP/nvim-gps",--{{{
		requires = "nvim-treesitter/nvim-treesitter",
		after = { "nvim-treesitter" },
		config = function() require'plugins-conf.nvim-gps' end
	}--}}}

	-- Search & Explore
	use { 'kyazdani42/nvim-tree.lua', --{{{
		config = function() require'plugins-conf.nvim-tree' end,
		cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" }
	}--}}}

	use { 'karb94/neoscroll.nvim',--{{{
		event = "WinScrolled",
		config = function() require('neoscroll').setup() end
	}--}}}

	use { 'mbbill/undotree',--{{{
		cmd = { "UndotreeToggle" },
		event = "BufRead"
	}--}}}

	use { 'nvim-telescope/telescope.nvim', --{{{
		cmd = { "Telescope" },
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		config = function() require'plugins-conf.telescope' end
	}--}}}

	use { 'nvim-telescope/telescope-fzf-native.nvim', --{{{
		requires = { "nvim-telescope/telescope.nvim" },
		run = 'make',
		cmd = { "Telescope" }
	}--}}}

	use { 'gelguy/wilder.nvim',--{{{
		config = function() require'plugins-conf.wilder' end
	}--}}}

	-- Git
	use 'tpope/vim-fugitive'

	use { 'lewis6991/gitsigns.nvim', --{{{
		requires = {'nvim-lua/plenary.nvim'},
		config = function() require'plugins-conf.gitsigns' end
	}--}}}

	-- Terminal
	use { 'voldikss/vim-floaterm', --{{{
		config = function() 
			vim.g.floaterm_width = 0.8
			vim.g.floaterm_height = 0.7
		end,
		cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev", "FloatermFirst", "FloatermLast", "FloatermUpdate", "FloatermShow", "FloatermSend" }
	}--}}}

	-- UI
	-- use { 'folke/tokyonight.nvim',--{{{
	-- 	config = function() 
	-- 		vim.g.tokyonight_style = "night" -- night OR storm 
	-- 		vim.cmd[[colorscheme tokyonight]]
	-- 	end
	-- }--}}}

	-- use { 'marko-cerovac/material.nvim', --{{{
	-- 	config = function() 
	-- 		vim.g.material_style = "deep ocean" -- darker OR deep ocean OR lighter OR oceanic OR palenight
	-- 		require('material').set()
	-- 	end,
	-- }--}}}

	-- use { 'navarasu/onedark.nvim',--{{{
	-- 	config = function() 
	-- 		vim.g.onedark_transparent_background = 1
	-- 		vim.g.onedark_style = "deep" -- dark OR darker OR cool OR deep OR warm OR warmer
	-- 		require('onedark').setup()
	-- 	end
	-- }--}}}

	use { "projekt0n/github-nvim-theme",--{{{
		config = function() 
			require("github-theme").setup({
				themeStyle = "dark",
				commentStyle = "NONE"
			})
		end
	}--}}}

	use { 'hoob3rt/lualine.nvim', --{{{
		config = function() require'plugins-conf.lualine' end,
		after = { 'github-nvim-theme', 'nvim-gps' }
	}--}}}

	use { 'norcalli/nvim-colorizer.lua',--{{{
		event = "BufReadPre",
		config = function() require'colorizer'.setup() end
	}--}}}

	use 'kyazdani42/nvim-web-devicons'
end)
