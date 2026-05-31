local addonName, WLVX = ...

--- Módulo de manejo de errores para WLVX. Centraliza la gestión de errores, proporcionando mensajes claros y consistentes para los desarrolladores.
--- @param codeError string Codigo de error definido en los enums.
--- @param ... any Parametros adicionales que se pasan a la funcion de manejo de errores especifica
function WLVX.errorsHandler:ShowError(codeError, ...)
    local switch = {
        ["DuplicatedID"] = function(...) WLVX.errorsHandler.Core.DuplicatedID(...) end,
        ["MenuNotFound"] = function(...) WLVX.errorsHandler.Core.MenuNotFound(...) end,
        ["FrameIDNotProvided"] = function(...) WLVX.errorsHandler.Core.FrameIDNotProvided(...) end,
        ["StringError"] = function(...) WLVX.errorsHandler.Utils.StringError(...) end,
        ["PercentageFormatError"] = function(...) WLVX.errorsHandler.Utils.PercentageFormatError(...) end,
        ["FrameNotProvided"] = function(...) WLVX.errorsHandler.Utils.FrameNotProvided(...) end,
        ["TitleNotProvided"] = function(...) WLVX.errorsHandler.Utils.TitleNotProvided(...) end,
    }

    if switch[codeError] then
        switch[codeError](...)
        return
    end

    print("|cffff0000[WLVX]|r Error desconocido: " .. codeError)
end
