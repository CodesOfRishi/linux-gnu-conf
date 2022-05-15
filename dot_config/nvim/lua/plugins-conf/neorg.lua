require('neorg').setup {
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				}
			}
		},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {},
		["core.integrations.nvim-cmp"] = {},
	}
}
