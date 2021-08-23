local gps = require("nvim-gps") -- requires "SmiteshP/nvim-gps" to be installed

require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'github',
		section_separators = {'', ''},
		component_separators = {'', ''},
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'b:gitsigns_status'},
		lualine_c = {{'filename', path = 1}, {gps.get_location, condition = gps.is_available}},
		lualine_x = {
			{'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}},
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
