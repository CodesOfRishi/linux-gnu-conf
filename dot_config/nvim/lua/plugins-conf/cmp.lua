local cmp = require('cmp')

local cmp_kind = {
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
			vim_item.kind = cmp_kind[vim_item.kind]
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
