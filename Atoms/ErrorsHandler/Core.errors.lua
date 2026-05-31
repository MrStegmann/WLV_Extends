
local addonName, WLVX = ...

WLVX.errorsHandler.Core = {}
WLVX.errorsHandler.Core.Enums = {}

local errorPrefix = "|cffff0000[WLVX:Core]|r: "


WLVX.errorsHandler.Core.Enums.DuplicatedID = "DuplicatedID"
WLVX.errorsHandler.Core.DuplicatedID = function(id) 
    print(errorPrefix .. "El menu con ID '" .. id .. "' ya existe.")
end

WLVX.errorsHandler.Core.Enums.MenuNotFound = "MenuNotFound"
WLVX.errorsHandler.Core.MenuNotFound = function(id) 
    print(errorPrefix .. "Menu no encontrado: " .. id)
end

WLVX.errorsHandler.Core.Enums.FrameIDNotProvided = "FrameIDNotProvided" 
WLVX.errorsHandler.Core.FrameIDNotProvided = function()
    print(errorPrefix .. "ID del frame no proporcionado.")
end