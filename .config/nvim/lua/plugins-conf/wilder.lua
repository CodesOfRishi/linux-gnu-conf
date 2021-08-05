-- CONFIGURATION (1)
vim.cmd([[
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" only / and ? are enabled by default
call wilder#set_option('modes', ['/', '?', ':'])
]])

-- -- CONFIGURATION (2)
-- -- use fuzzy matching instead of substring matching
-- -- For wild#cmdline_pipeline():
-- --   'language'   : set to 'python' to use python
-- --   'fuzzy'      : set fuzzy searching
-- -- For wild#python_search_pipeline():
-- --   'pattern'    : can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
-- --   'sorter'     : omit to get results in the order they appear in the buffer
-- --   'engine'     : can be set to 're2' for performance, requires pyre2 to be installed
-- vim.cmd([[
-- call wilder#set_option('pipeline', [ wilder#branch(wilder#cmdline_pipeline({'language': 'python','fuzzy': 1, }), wilder#python_search_pipeline({'pattern': wilder#python_fuzzy_pattern(), 'sorter': wilder#python_difflib_sorter(), 'engine': 're',}), ), ])
-- ]])
-- 
-- -- CONFIGURATION (3)
-- -- when the cmdline is empty, provide suggestions based on the cmdline history
-- vim.cmd([[
-- call wilder#set_option('pipeline', [ wilder#branch([wilder#check({_, x -> empty(x)}), wilder#history(),], wilder#cmdline_pipeline(), wilder#search_pipeline(),),])
-- ]])
-- 
-- -- CONFIGURATION (4)
-- -- file finder
-- -- 'filters'      : use ['cpsm_filter'] for performance, needs cpsm to be installed
-- vim.cmd([[
-- call wilder#set_option('pipeline', [wilder#branch(wilder#python_file_finder_pipeline({'file_command': ['fd', '--hidden', '--type', 'f'],'dir_command': ['fd', '--hidden', '--type', 'd'],'filters': ['fuzzy_filter', 'difflib_sorter'],}),wilder#cmdline_pipeline(),wilder#python_search_pipeline(),),])
-- ]])

-- configurations (2), (3) & (4) merged in one:
vim.cmd([[
call wilder#set_option('pipeline', [wilder#branch( wilder#cmdline_pipeline({ 'language': 'python', 'fuzzy': 1, }), wilder#python_search_pipeline({ 'pattern': wilder#python_fuzzy_pattern(), 'sorter': wilder#python_difflib_sorter(), 'engine': 're', }), [ wilder#check({_, x -> empty(x)}), wilder#history(), ], wilder#python_file_finder_pipeline({ 'file_command': ['fd', '--hidden', '--type', 'f',], 'dir_command': ['fd', '--hidden', '--type', 'd'], 'filters': ['fuzzy_filter', 'difflib_sorter'], }), wilder#cmdline_pipeline(), wilder#search_pipeline(),), ])
]])
