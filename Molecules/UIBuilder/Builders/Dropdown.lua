local addonName, WLVX = ...

--- Crea un menú desplegable (Dropdown) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el menú desplegable.
---@param labelText string El texto que se mostrará junto al menú desplegable.
---@param items table Lista de strings o tablas {text="Nombre", value="Valor"}.
---@param defaultValue string Valor inicial que se mostrará en el menú desplegable.
---@param width number|nil Ancho del menú desplegable (por defecto 180).
---@param height number|nil Alto del menú desplegable (por defecto 32).
---@param callback function|nil Función que se ejecutará al seleccionar una opción, recibiendo el valor de la opción seleccionada como argumento.
function WLVX:AddDropdown(parent, id, labelText, items, defaultValue, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 180, height or 32, parent)
    local label = parent:CreateFontString(id .. "_label", "OVERLAY", "GameFontNormalSmall")
    label:SetText(labelText)

    local dropDown = CreateFrame("Frame", id, parent, "UIDropDownMenuTemplate")
    dropDown.size = { width = res.x, height = res.y }
    dropDown:SetSize(res.x, res.y)
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    if parent.isHorizontal then
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, 0)
        dropDown:SetPoint("TOPLEFT", label, "BOTTOMLEFT", -20, -2)
    else
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, y)
        dropDown:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y - 15)
    end
    
    UIDropDownMenu_SetWidth(dropDown, res.x)
    -- WoW API handles height somewhat automatically for dropdowns, but we use res.y for vertical spacing
    UIDropDownMenu_SetText(dropDown, defaultValue or "Seleccionar...")

    UIDropDownMenu_Initialize(dropDown, function(self, level, menuList)
        for _, item in ipairs(items) do
            local info = UIDropDownMenu_CreateInfo()
            local text = type(item) == "table" and item.text or item
            local val = type(item) == "table" and item.value or item
            info.text = text
            info.arg1 = val
            info.func = function(btn, arg1)
                UIDropDownMenu_SetText(dropDown, text)
                if callback then callback(arg1) end
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    parent:addChild(id, dropDown)
    return dropDown
end