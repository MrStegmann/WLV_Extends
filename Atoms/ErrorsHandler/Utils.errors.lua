local addonName, WLVX = ...

WLVX.errorsHandler.Utils = {}
WLVX.errorsHandler.Utils.Enums = {}

local errorPrefix = "|cffff0000[WLVX:Utils]|r: "

WLVX.errorsHandler.Utils.Enums.StringError = "StringError"
WLVX.errorsHandler.Utils.StringError = function(label) 
    print(errorPrefix .. "El parámetro " .. label .. " debe ser un String.")
end


WLVX.errorsHandler.Utils.Enums.PercentageFormatError = "PercentageFormatError"
WLVX.errorsHandler.Utils.PercentageFormatError = function(label, val) 
    print(errorPrefix .. label .. " ('" .. val .. "') debe ser un valor numérico seguido de '%'.")
end


-- WLVX.errorsHandler.Utils.Enums.FrameNotProvided = "FrameNotProvided"
-- WLVX.errorsHandler.Utils.FrameNotProvided = function()
--     print(errorPrefix .. "No se ha proporcionado ningún frame.")
-- end

-- WLVX.errorsHandler.Utils.Enums.TitleNotProvided = "TitleNotProvided"
-- WLVX.errorsHandler.Utils.TitleNotProvided = function()
--     print(errorPrefix .. "No se ha proporcionado ningún título.")
-- end