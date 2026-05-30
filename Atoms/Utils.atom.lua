local addonName, WLVX = ...

function WLVX:GetVersion()
    return "0.0.1"
end

--- Traduce valores porcentuales en coordenadas de píxeles basadas en un frame padre o el viewport global.
---@param valPctW string Porcentaje del ancho (ej: "50%").
---@param valPctH string Porcentaje del alto (ej: "20%").
---@param parentFrame table|nil (Opcional) El frame de referencia. Si es nil, se usa UIParent (el viewport del juego).
---@return table {x, y} Un objeto con los valores calculados en píxeles.
function WLVX:getResponsiveValues(valPctW, valPctH, parentFrame)
    local function validateAndParse(val, label)
        if type(val) ~= "string" then
            error("WLVX:getResponsiveValues: El parámetro " .. label .. " debe ser un String.")
        end
        -- Patrón: Uno o más dígitos (opcionalmente con decimales) seguidos de un símbolo de %
        local numStr = val:match("^(%d+%.?%d*)%%$")
        if not numStr then
            error("WLVX:getResponsiveValues: " .. label .. " ('" .. val .. "') debe ser un valor numérico seguido de '%'.")
        end
        return tonumber(numStr)
    end

    local pctW = validateAndParse(valPctW, "valPctW")
    local pctH = validateAndParse(valPctH, "valPctH")

    -- Si no se proporciona parentFrame, usamos UIParent como referencia del viewport
    local ref = parentFrame or UIParent
    
    local totalW = ref:GetWidth() or 0
    local totalH = ref:GetHeight() or 0

    return {
        x = (pctW / 100) * totalW,
        y = (pctH / 100) * totalH
    }
end

--- Detecta el tipo de entrada (número o porcentaje) y devuelve el valor real en píxeles.
---@param w number|string Ancho (ej: 100 o "50%").
---@param h number|string Alto (ej: 200 o "20%").
---@param parentFrame table|nil (Opcional) Frame de referencia para los cálculos porcentuales.
---@return table {x, y} Valores finales en unidades de WoW.
function WLVX:resolveDimensions(w, h, parentFrame)
    local ref = parentFrame or UIParent
    local totalW = ref:GetWidth() or 0
    local totalH = ref:GetHeight() or 0
    
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
                error("WLVX:resolveDimensions: El formato de '" .. label .. "' (" .. val .. ") es inválido. Use números o 'n%'.")
            end
        else
            error("WLVX:resolveDimensions: El parámetro '" .. label .. "' debe ser un número o un string con '%'.")
        end
    end

    local finalX = process(w, totalW, "w")
    local finalY = process(h, totalH, "h")

    return {
        x = finalX,
        y = finalY
    }
end

--- Crea un tooltip personalizado para un botón o frame específico.
---@param frame table El frame al que se le asignará el tooltip.
---@param title string Título del tooltip.
---@param lines table Una lista de líneas, donde cada línea es una tabla con 'text' y opcionalmente 'r', 'g', 'b' para el color. 
function WLVX:CreateTooltip(frame, title, lines)
    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText(title)
        for _, line in ipairs(lines) do
            GameTooltip:AddLine(line.text, line.r or 1, line.g or 1, line.b or 1)
        end
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end