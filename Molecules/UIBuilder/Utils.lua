local addonName, WLVX = ...

--- Calcula la siguiente posición disponible para un elemento y actualiza los punteros del padre.
---@param parent table El objeto frame padre.
---@param w number Ancho del elemento.
---@param h number Alto del elemento.
---@return number x, number y
function WLVX:GetNextOffset(parent, w, h)
    local styles = parent.styles or {}
    local m = styles.margin or { top = 0, left = 0, right = 0, bottom = 0 }
    local gap = styles.gap or 0 -- Obtener el valor del gap

    local offsetX = m.left or 0
    local offsetY = -(m.top or 0)

    -- Calculamos el offset sumando el tamaño de los hijos existentes más el margen definido en el padre
    if parent.childrens then
        for _, child in pairs(parent.childrens) do
            if parent.isHorizontal then
                offsetX = offsetX + (child.size and child.size.width or child:GetWidth()) + gap
            else
                offsetY = offsetY - (child.size and child.size.height or child:GetHeight()) - gap
            end
        end
    end

    return offsetX, offsetY
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