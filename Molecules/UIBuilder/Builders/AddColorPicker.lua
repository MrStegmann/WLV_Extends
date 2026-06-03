local addonName, WLVX = ...

--- Crea un selector de color en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el selector de color.
---@param text string El texto que se mostrará junto al selector de color.
---@param r number Valor inicial del canal rojo (0-1).
---@param g number Valor inicial del canal verde (0-1).
---@param b number Valor inicial del canal azul (0-1).
---@param a number Valor inicial del canal alfa (0-1).
---@param width number|nil Ancho del selector de color (por defecto 250).
---@param height number|nil Alto del selector de color (por defecto 35).
---@param callback function|nil Función que se ejecutará al cambiar el color, recibiendo los nuevos valores r, g, b, a como argumentos.
function WLVX:AddColorPicker(parent, id, text, r, g, b, a, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 250, height or 35, parent)
    local btn = CreateFrame("Button", id, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    btn.size = { width = res.x, height = res.y }

    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    btn:SetText(text)

    -- Indicador visual del color seleccionado
    btn.swatch = btn:CreateTexture(nil, "OVERLAY")
    local swatchSize = math.min(res.y * 0.5, 16)
    btn.swatch:SetSize(swatchSize, swatchSize)
    btn.swatch:SetPoint("LEFT", 10, 0)
    btn.swatch:SetColorTexture(r or 1, g or 1, b or 1, a or 1)

    btn:SetScript("OnClick", function()
        local function onColorChange()
            local nr, ng, nb = ColorPickerFrame:GetColorRGB()
            local na = 1 - OpacitySliderFrame:GetValue()
            btn.swatch:SetColorTexture(nr, ng, nb, na)
            if callback then callback(nr, ng, nb, na) end
        end

        ColorPickerFrame:SetupColorPickerAndShow({
            swatchFunc = onColorChange,
            opacityFunc = onColorChange,
            cancelFunc = onColorChange,
            hasOpacity = (a ~= nil),
            opacity = 1 - (a or 1),
            r = r or 1, g = g or 1, b = b or 1
        })
    end)
    parent:addChild(id, btn)

    return btn
end