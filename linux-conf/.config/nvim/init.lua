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
    "options",
	"plugins-list",
    "mappings",
	"utils"
}

for i = 1, #nvim_configuration_modules, 1 do
	require(nvim_configuration_modules[i])
end
