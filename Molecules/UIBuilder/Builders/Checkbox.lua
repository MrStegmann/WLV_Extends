local addonName, WLVX = ...

--- Crea un Checkbox (casilla de verificación) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el checkbox.
---@param text string El texto que se mostrará junto al checkbox.
---@param defaultValue boolean Valor inicial del checkbox (true para marcado, false para desmarcado).
---@param width number|nil Ancho del checkbox (por defecto 32).
---@param height number|nil Alto del checkbox (por defecto 32).
---@param callback function|nil Función que se ejecutará al cambiar el estado del checkbox, recibiendo el nuevo valor (true/false) como argumento.
function WLVX:AddCheckbox(parent, id, text, defaultValue, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 32, height or 32, parent)
    local check = CreateFrame("CheckButton", id, parent, "UICheckButtonTemplate")
    check:SetSize(res.x, res.y)
    check.size = { width = res.x, height = res.y }
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    if parent.isHorizontal then
        check:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    else
        check:SetPoint("TOPLEFT", parent, "TOPLEFT", 50, y)
    end
    check:SetChecked(defaultValue)

    check.text = check:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    check.text:SetPoint("LEFT", check, "RIGHT", 5, 0)
    check.text:SetText(text)

    check:SetScript("OnClick", function(self)
        if callback then callback(self:GetChecked()) end
    end)

    parent:addChild(id, check)

    return check
end