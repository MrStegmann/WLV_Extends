local addonName, WLVX = ...

-- ========================================================
-- UI BUILDER MOLECULE
-- Funciones de construcción rápida mediante frameId.
-- ========================================================

--- Crea un botón en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddButton(parent, text, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 250, height or 35, parent)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    local currentY = parent.nextY or 0
    btn:SetPoint("TOP", 0, currentY)
    btn:SetText(text)

    btn:SetScript("OnClick", function()
        if callback then
            callback()
        end
    end)

    parent.nextY = currentY - res.y - 10
    table.insert(parent.buttons, btn)

    return btn
end

--- Crea un botón con un icono en el frame indicado.
---@param parent table El objeto frame padre.
---@param iconName string Nombre del icono.
---@param w number|nil Ancho del botón (por defecto 32).
---@param h number|nil Alto del botón (por defecto 32).
---@param callback function Función que se lanzará al pulsar el botón.
function WLVX:AddIconButton(parent, iconName, w, h, callback)
    if not parent then return end

    local res = self:resolveDimensions(w or 32, h or 32, parent)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(res.x, res.y)
    local currentY = parent.nextY or 0
    btn:SetPoint("TOP", 0, currentY)

    local iconTex = btn:CreateTexture(nil, "ARTWORK")
    iconTex:SetTexture(WLVX:setPathForIconName(iconName))
    iconTex:SetAllPoints(btn)
    btn.icon = iconTex

    btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

    btn:SetScript("OnClick", function()
        if callback then callback() end
    end)

    parent.nextY = currentY - res.y - 10
    return btn
end

function WLVX:AddButtons(buttonList)
    if type(buttonList) ~= "table" then return end
    
    for _, btnData in ipairs(buttonList) do
        if btnData.menu and btnData.text then
            self:AddButton(btnData.menu, btnData.text, btnData.callback)
        end
    end
end

-- ========================================================
-- ESTRUCTURA Y LAYOUT (FILAS, COLUMNAS, CONTENEDORES)
-- ========================================================

--- Crea un contenedor genérico (Frame) dentro de otro. Se registra para poder ser usado como frameId.
---@param parent table El objeto frame padre.
---@param containerId string ID único para el nuevo contenedor (servirá como frameId para otros elementos).
function WLVX:AddContainer(parent, containerId, width, height, x, y)
    if not parent then return end

    local res = self:resolveDimensions(width or 100, height or 100, parent)
    local pW = parent:GetWidth() or 0
    local pH = parent:GetHeight() or 0
    local offX = x or 0
    local offY = y or 0

    local w = math.max(1, res.x)
    local h = math.max(1, res.y)

    -- Prevenir desbordamiento horizontal: offX + width no debe superar pW
    if pW > 0 and (offX + w) > pW then
        w = math.max(1, pW - offX)
    end

    -- Prevenir desbordamiento vertical: considerando anclaje TOPLEFT y desplazamiento negativo (hacia abajo)
    if pH > 0 and (math.abs(offY) + h) > pH then
        h = math.max(1, pH - math.abs(offY))
    end

    local container = CreateFrame("Frame", containerId, parent, "BackdropTemplate")
    container:SetSize(w, h)
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", offX, offY)

    -- Establecemos un fondo base transparente para permitir que SetBackgroundColor funcione
    container:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        tile = true, tileSize = 16, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    container:SetBackdropColor(0, 0, 0, 0)

    -- Inicializamos el sistema de coordenadas local para este contenedor
    container.nextY = 0
    container.nextX = 0
    container.buttons = {}

    -- Registramos el contenedor para que WLVX:GetMenu(containerId) pueda encontrarlo
    self.frames[containerId] = container
    return container
end

--- Crea una fila que ocupa el ancho del padre y gestiona el apilado vertical automático.
---@param parent table El objeto frame padre.
---@param rowId string ID único para la fila.
---@param width number|nil Ancho de la fila. Si supera el espacio disponible, se ajustará.
---@param height number|nil Altura de la fila (por defecto 50).
---@param callback function|nil (Opcional) Función que recibe la fila para inicializar su estructura.
function WLVX:AddRow(parent, rowId, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or "100%", height or 50, parent)
    local h = res.y
    local pWidth = parent:GetWidth()
    local padding = (parent.padding and (parent.padding.left + parent.padding.right)) or 20
    local maxWidth = (pWidth > 0 and pWidth or 100) - padding
    local w = res.x
    if w > maxWidth then
        w = maxWidth
    end
    -- Colocamos la fila en la posición vertical actual del padre
    local row = self:AddContainer(parent, rowId, w, h, parent.nextX or 0, parent.nextY or 0)
    -- Desplazamos el puntero vertical del padre usando el alto real (clamped) del contenedor
    parent.nextY = (parent.nextY or 0) - row:GetHeight() - 5

    if type(callback) == "function" then
        callback(row)
    end

    return row
end

--- Crea una columna dentro de un frame (idealmente dentro de una fila) y gestiona el apilado horizontal.
---@param parent table El objeto frame padre.
---@param colId string ID único para la columna.
---@param width number|nil Ancho de la columna.
---@param callback function|nil (Opcional) Función que recibe la columna para inicializar su estructura.
function WLVX:AddColumn(parent, colId, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 100, height or "100%", parent)
    local w = res.x
    local h = res.y

    -- Colocamos la columna según el puntero horizontal del padre
    local col = self:AddContainer(parent, colId, w, h, parent.nextX or 0, parent.nextY or 0)

    -- Desplazamos el puntero horizontal del padre usando el ancho real (clamped) del contenedor
    parent.nextX = (parent.nextX or 0) + col:GetWidth() + 5

    if type(callback) == "function" then
        callback(col)
    end

    return col
end

--- Alinea un frame o contenedor respecto a su padre basado en una etiqueta.
---@param frame table El objeto frame a alinear.
---@param alignTag string "Top" | "Bottom" | "Left" | "Right" | "Center"
function WLVX:AlignTo(frame, alignTag)
    if not frame then return end

    local parent = frame:GetParent()
    frame:ClearAllPoints()

    local tag = string.lower(alignTag)
    if tag == "top" then
        frame:SetPoint("TOP", parent, "TOP", 0, -5)
    elseif tag == "bottom" then
        frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 5)
    elseif tag == "left" or tag == "lef" then
        frame:SetPoint("LEFT", parent, "LEFT", 5, 0)
    elseif tag == "right" then
        frame:SetPoint("RIGHT", parent, "RIGHT", -5, 0)
    elseif tag == "center" then
        frame:SetPoint("CENTER", parent, "CENTER", 0, 0)
    end
end

--- Crea un encabezado (texto resaltado) en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddHeader(parent, text, width, height)
    if not parent then return end

    local res = self:resolveDimensions(width or "100%", height or 30, parent)
    local header = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    header:SetPoint("TOP", 0, parent.nextY - 10)
    header:SetText(text)
    header:SetTextColor(1, 0.82, 0) -- Color dorado clásico de WoW
    header:SetSize(res.x, res.y)

    parent.nextY = parent.nextY - res.y - 15
    return header
end

--- Crea una etiqueta de texto en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddLabel(parent, text, width, height)
    if not parent then return end
    local res = self:resolveDimensions(width or "100%", height or 20, parent)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", 0, parent.nextY)
    label:SetText(text)
    label:SetSize(res.x, res.y)

    parent.nextY = parent.nextY - res.y - 10

    return label
end

--- Crea un Checkbox (casilla de verificación) en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddCheckbox(parent, text, defaultValue, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 32, height or 32, parent)
    local check = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    check:SetSize(res.x, res.y)
    check:SetPoint("TOPLEFT", parent, "TOPLEFT", 50, parent.nextY)
    check:SetChecked(defaultValue)

    check.text = check:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    check.text:SetPoint("LEFT", check, "RIGHT", 5, 0)
    check.text:SetText(text)

    check:SetScript("OnClick", function(self)
        if callback then callback(self:GetChecked()) end
    end)

    parent.nextY = parent.nextY - res.y - 5
    return check
end

--- Crea un Slider (barra deslizadora) en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddSlider(parent, text, minVal, maxVal, step, defaultValue, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 200, height or 20, parent)
    local sliderName = "WLV_Slider_" .. (text:gsub("%s+", ""))
    local slider = CreateFrame("Slider", sliderName, parent, "OptionsSliderTemplate")
    slider:SetSize(res.x, res.y)
    slider:SetPoint("TOP", 0, parent.nextY - 20)
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(step or 1)
    slider:SetValue(defaultValue or minVal)
    slider:SetObeyStepOnDrag(true)

    _G[sliderName .. "Text"]:SetText(text)
    _G[sliderName .. "Low"]:SetText(tostring(minVal))
    _G[sliderName .. "High"]:SetText(tostring(maxVal))

    slider:SetScript("OnValueChanged", function(self, value)
        if callback then callback(value) end
    end)

    parent.nextY = parent.nextY - res.y - 30
    return slider
end

--- Crea un cuadro de texto (EditBox) en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddEditBox(parent, labelText, defaultValue, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 200, height or 20, parent)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, parent.nextY)
    label:SetText(labelText)

    local eb = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    eb:SetSize(res.x, res.y)
    eb:SetPoint("TOPLEFT", parent, "TOPLEFT", 35, parent.nextY - 15)
    eb:SetAutoFocus(false)
    eb:SetText(defaultValue or "")

    eb:SetScript("OnEnterPressed", function(self)
        if callback then callback(self:GetText()) end
        self:ClearFocus()
    end)

    eb:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)

    parent.nextY = parent.nextY - res.y - 30
    return eb
end

--- Crea un menú desplegable (Dropdown) en el frame indicado.
---@param parent table El objeto frame padre.
---@param items table Lista de strings o tablas {text="Nombre", value="Valor"}.
function WLVX:AddDropdown(parent, labelText, items, defaultValue, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 180, height or 32, parent)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, parent.nextY)
    label:SetText(labelText)

    local dropDown = CreateFrame("Frame", "WLV_Dropdown_" .. (labelText:gsub("%s+", "")), parent, "UIDropDownMenuTemplate")
    dropDown:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, parent.nextY - 15)
    
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

    parent.nextY = parent.nextY - res.y - 25
    return dropDown
end

--- Crea un selector de color en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddColorPicker(parent, text, r, g, b, a, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 250, height or 35, parent)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    btn:SetPoint("TOP", 0, parent.nextY)
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

    parent.nextY = parent.nextY - res.y - 10
    return btn
end

--- Crea un selector de teclas (Keybind) en el frame indicado.
---@param parent table El objeto frame padre.
function WLVX:AddKeybind(parent, labelText, currentKey, width, height, callback)
    if not parent then return end

    local res = self:resolveDimensions(width or 150, height or 25, parent)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, parent.nextY)
    label:SetText(labelText)

    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 35, parent.nextY - 15)
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

    parent.nextY = parent.nextY - res.y - 25
    return btn
end

print("|cff00ff00[WLV_Molecule]|r UIBuilder cargado correctamente.")
