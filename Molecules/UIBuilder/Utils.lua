local addonName, WLVX = ...

--- Calcula la siguiente posición disponible para un elemento y actualiza los punteros del padre.
---@param parent table El objeto frame padre.
---@param w number Ancho del elemento.
---@param h number Alto del elemento.
---@param margin number|nil Espaciado opcional.
---@return number x, number y
function WLVX:GetNextOffset(parent, w, h, margin)
    margin = margin or 10
    local posX = parent.nextX or 0
    local posY = parent.nextY or 0

    if parent.isHorizontal then
        parent.nextX = posX + w + margin
        return posX, 0
    else
        parent.nextY = posY - h - margin
        return 10, posY
    end
end




--- Crea un tooltip personalizado para un botón o frame específico.
---@param frame table El frame al que se le asignará el tooltip.
---@param title string Título del tooltip.
---@param lines table|nil (Opcional) Una lista de líneas, donde cada línea es una tabla con 'text' y opcionalmente 'r', 'g', 'b' para el color. 
function WLVX:CreateTooltip(frame, title, lines)
    if not frame then
        print("|cff00ff00[WLV_UI]|r Warning: No se proporcionó un frame para el tooltip.")
        return
    end
    if not title then
        print("|cff00ff00[WLV_UI]|r Warning: No se proporcionó un título para el tooltip.")
        return
    end

    frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText(title)
        if lines then
            for _, line in ipairs(lines) do
                GameTooltip:AddLine(line.text, line.r or 1, line.g or 1, line.b or 1)
            end
        end
        GameTooltip:Show()
    end)

    frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end