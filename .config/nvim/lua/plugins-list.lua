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
		requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-path", "hrsh7th/cmp-calc" },
		config = function() require ("plugins-conf.cmp") end
	}--}}}

	-- LSP
	use { 'neovim/nvim-lspconfig',--{{{
		config = function() require'plugins-conf.nvim-lspconfig' end
	}--}}}

	use { 'glepnir/lspsaga.nvim',--{{{
		requires = { 'neovim/nvim-lspconfig' },
		config = function()
			local saga = require 'lspsaga'

			saga.init_lsp_saga {
				use_saga_diagnostic_sign = true,
				error_sign = '',
				warn_sign = '',
				hint_sign = ' ',
				infor_sign = '',
				dianostic_header_icon = '   ',
				code_action_icon = ' ',
				code_action_prompt = {
				  enable = true,
				  sign = true,
				  sign_priority = 20,
				  virtual_text = true,
				},
				finder_definition_icon = '  ',
				finder_reference_icon = '  ',
				definition_preview_icon = '  ',
				-- "single" "double" "round" "plus"
				border_style = "round", 
				rename_prompt_prefix = '❯',
			}
		end
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
		config = function() 
			require'nvim-treesitter.configs'.setup {
				ensure_installed = { "c", "cpp", "java", "toml", "bash", "python", "lua" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
				ignore_install = {}, -- List of parsers to ignore installing
				highlight = {
					enable = true,              -- false will disable the whole extension
					disable = {},  -- list of language that will be disabled
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			}
		end
	}--}}}

	use { "SmiteshP/nvim-gps",--{{{
		requires = "nvim-treesitter/nvim-treesitter",
		after = { "nvim-treesitter" },
		config = function()
			require("nvim-gps").setup({
				icons = {
					["class-name"] = ' ',      -- Classes and class-like objects
					["function-name"] = ' ',   -- Functions
					["method-name"] = ' '      -- Methods (functions inside class-like objects)
				},
				languages = {                    -- You can disable any language individually here
					["c"] = true,
					["cpp"] = true,
					["go"] = true,
					["java"] = true,
					["javascript"] = true,
					["lua"] = true,
					["python"] = true,
					["rust"] = true,
				},
				separator = '  ',
			})
		end
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
	use { "akinsho/toggleterm.nvim",--{{{
		config = function() require ("plugins-conf.toggleterm") end
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
