local navic = require("nvim-navic") -- requires "SmiteshP/nvim-navic" to be installed

require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		section_separators = { left = '', right = ''},
		component_separators = {left = '', right = ''},
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'b:gitsigns_status'},
		lualine_c = {{'filename', path = 1}, { navic.get_location, cond = navic.is_available }},
		lualine_x = {
			{'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}},
			'filetype',
			'encoding'
		},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {'fugitive'}
}
