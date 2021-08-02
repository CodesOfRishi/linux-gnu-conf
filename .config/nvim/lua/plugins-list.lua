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

	-- LSP
	use { 'neovim/nvim-lspconfig',--{{{
		config = function() require'plugins-conf.nvim-lspconfig' end
	}--}}}

	use { 'hrsh7th/nvim-compe', --{{{
		config = function() require'plugins-conf.nvim-compe' end,
		event = "InsertEnter"
	}--}}}

	use { 'glepnir/lspsaga.nvim',--{{{
		config = function() require'plugins-conf.lspsaga' end,
		requires = { 'neovim/nvim-lspconfig' }
	}--}}}

	use { 'folke/trouble.nvim',--{{{
		config = function() require'plugins-conf.trouble' end,
		requires = { 'neovim/nvim-lspconfig' },
		cmd = { "Trouble", "TroubleToggle" }
	}--}}}

	-- Editing
	use { 'mg979/vim-visual-multi', --{{{
		branch = 'master',
		event = "BufRead"
	}--}}}

	use { 'tpope/vim-surround',--{{{
		event = "BufRead"
	} --}}}

	use { 'b3nj5m1n/kommentary',--{{{
		event = "BufRead"
	}--}}}

	-- Language specific
	use { 'nvim-treesitter/nvim-treesitter', --{{{
		event = "BufRead",
		branch = "0.5-compat", 
		run = ":TSUpdate",
		config = function() require'plugins-conf.nvim-treesitter' end
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

	-- Git
	use 'tpope/vim-fugitive'

	use { 'lewis6991/gitsigns.nvim', --{{{
		requires = {'nvim-lua/plenary.nvim'},
		config = function() require'plugins-conf.gitsigns' end
	}--}}}

	-- Terminal
	use { 'voldikss/vim-floaterm', --{{{
		config = function() require'plugins-conf.vim-floaterm' end,
		cmd = { "FloatermNew", "FloatermToggle", "FloatermNext", "FloatermPrev", "FloatermFirst", "FloatermLast", "FloatermUpdate", "FloatermShow", "FloatermSend" }
	}--}}}

	-- UI
	use { 'folke/tokyonight.nvim',--{{{
		config = function() require'plugins-conf.themes' end,
		disable = true,
		lock = true
	}--}}}

	use { 'marko-cerovac/material.nvim', --{{{
		config = function() require'plugins-conf.themes' end,
		disable = true,
		lock = true
	}--}}}

	use { 'navarasu/onedark.nvim',--{{{
		config = function() require'plugins-conf.themes' end
	}--}}}

	use { 'hoob3rt/lualine.nvim', --{{{
		config = function() require'plugins-conf.lualine' end,
		after = { 'onedark.nvim' }
	}--}}}

	use { 'norcalli/nvim-colorizer.lua',--{{{
		config = function() require'colorizer'.setup() end,
		event = "BufRead"
	}--}}}

	use 'kyazdani42/nvim-web-devicons'
end)
