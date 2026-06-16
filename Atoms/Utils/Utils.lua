local addonName, WLVX = ...
local errorHandler = WLVX.errorsHandler
local enums = WLVX.errorsHandler.Utils.Enums


function WLVX:GetVersion()
    return "0.0.1"
end

--- Detecta el tipo de entrada (número o porcentaje) y devuelve el valor real en píxeles.
---@param w number|string Ancho (ej: 100 o "50%").
---@param h number|string Alto (ej: 200 o "20%").
---@param parentFrame table|nil (Opcional) Frame de referencia para los cálculos porcentuales.
---@return table {x, y} Valores finales en unidades de WoW.
function WLVX:resolveDimensions(w, h, parentFrame)
    local ref = parentFrame or UIParent
    local totalW = (ref.size and tonumber(ref.size.width)) or ref:GetWidth() or 0
    local totalH = (ref.size and tonumber(ref.size.height)) or ref:GetHeight() or 0
    
    local function process(val, total, label)
        -- Si es un número, devolvemos el valor directo (píxeles)
        if type(val) == "number" then
            return val
        -- Si es un string, validamos el formato de porcentaje
        elseif type(val) == "string" then
            local numStr = val:match("^(%d+%.?%d*)%%$")
            if numStr then
                return (tonumber(numStr) / 100) * total
            else
                errorHandler:HandleError(enums.PercentageFormatError, label, val)
            end
        else
            errorHandler:HandleError(enums.StringError, label)
        end
    end

    local finalX = process(w, totalW, "w")
    local finalY = process(h, totalH, "h")

    return {
        x = finalX,
        y = finalY
    }
end
