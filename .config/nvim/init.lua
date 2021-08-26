--[[
██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗ 
██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝ Rishi K.
--]]

-- load nvim configurations modules
local nvim_configuration_modules = {
	"utils",
    "options",
	"plugins-list",
    "mappings",
	"autocmds"
}

for i = 1, #nvim_configuration_modules, 1 do
	require(nvim_configuration_modules[i])
end
