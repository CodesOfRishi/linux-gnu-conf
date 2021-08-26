local map = require("utils").map

-- create mappings for running python scripts
-- make sure script contains the shebang specifying the interpreter &,
-- the scpript has the executable permission
map("n", "<C-_>", ":FloatermNew ./%<CR>", {})
