local addonName, WLVX = ...


--- Crea un selector de teclas (Keybind) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el selector de teclas.
---@param labelText string El texto que se mostrará junto al selector de teclas.
---@param currentKey string Tecla actual asignada.
---@param width number|nil Ancho del selector de teclas (por defecto 150).
---@param height number|nil Alto del selector de teclas (por defecto 25).
---@param callback function|nil Función que se ejecutará al cambiar la tecla, recibiendo la nueva tecla como argumento.
function WLVX:AddKeybind(parent, id, labelText, currentKey, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 150, height or 25, parent)
    local label = parent:CreateFontString(id .. "_label", "OVERLAY", "GameFontNormalSmall")
    label:SetText(labelText)

    local btn = CreateFrame("Button", id, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    btn.size = { width = res.x, height = res.y }
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    if parent.isHorizontal then
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, 0)
        btn:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 5, -2)
    else
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, y)
        btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 35, y - 15)
    end
    btn:SetText(currentKey or "Sin asignar")

    btn:SetScript("OnClick", function(self)
        self:SetText("Presiona una tecla...")
        self:SetScript("OnKeyDown", function(s, key)
            if key ~= "ESCAPE" then
                s:SetText(key)
                if callback then callback(key) end
            end
            s:SetScript("OnKeyDown", nil)
        end)
    end)

    parent:addChild(id, btn)
    return btn
end