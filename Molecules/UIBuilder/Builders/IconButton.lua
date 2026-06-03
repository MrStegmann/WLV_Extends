local addonName, WLVX = ...


--- Crea un botón con un icono en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el botón.
---@param iconName string Nombre del icono.
---@param w number|nil Ancho del botón (por defecto 32).
---@param h number|nil Alto del botón (por defecto 32).
---@param onClick function Función que se lanzará al pulsar el botón.
---@param callback function Función que se ejecutará después de crear el botón.
function WLVX:AddIconButton(parent, id, iconName, w, h, onClick, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(w or 32, h or 32, parent)
    local btn = CreateFrame("Button", id, parent)
    btn:SetSize(res.x, res.y)
    btn.size = { width = res.x, height = res.y }

    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    local iconTex = btn:CreateTexture(nil, "ARTWORK")
    iconTex:SetTexture(WLVX:setPathForIconName(iconName))
    iconTex:SetAllPoints(btn)
    btn.icon = iconTex

    btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    btn:SetScript("OnClick", function()
        if type(onClick) == "function" then
            onClick()
        end
    end)

    if type(callback) == "function" then
        callback(btn)
    end

    parent:addChild(id, btn)

    return btn
end