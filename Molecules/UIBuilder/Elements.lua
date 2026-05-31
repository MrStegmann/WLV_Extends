local addonName, WLVX = ...
--- Elements - Funciones para crear elementos UI comunes (botones, sliders, etc.) con estilos y comportamientos predefinidos.

--- Crea un botón en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el botón.
---@param text string El texto que se mostrará en el botón.
---@param width number|nil Ancho del botón (por defecto 250).
---@param height number|nil Alto del botón (por defecto 35).
---@param onClick function Función que se lanzará al pulsar el botón.
---@param callback function|nil Función que se ejecutará después de crear el botón, recibiendo el botón como argumento.
function WLVX:AddButton(parent, id, text, width, height, onClick, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 250, height or 35, parent)
    local btn = CreateFrame("Button", id, parent, "UIPanelButtonTemplate")
    btn:SetSize(res.x, res.y)
    btn.size = { width = res.x, height = res.y }

    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    btn:SetText(text)

    btn:SetScript("OnClick", function()
        if type(onClick) == "function" then
            onClick()
        end
    end)


    parent:addChild(id, btn)

    if type(callback) == "function" then
        callback(btn)
    end

    return btn
end

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

function WLVX:AddButtons(buttonList)
    if type(buttonList) ~= "table" then return end
    
    for _, btnData in ipairs(buttonList) do
        if btnData.menu and btnData.id and btnData.text then
            self:AddButton(btnData.menu, btnData.id, btnData.text, btnData.width, btnData.height, btnData.onClick, btnData.callback)
        end
    end
end

--- Crea un encabezado (texto resaltado) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el encabezado.
---@param text string El texto que se mostrará en el encabezado.
---@param width number|nil Ancho del encabezado (por defecto "100%").
---@param height number|nil Alto del encabezado (por defecto 30).
function WLVX:AddHeader(parent, id, text, width, height)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or "100%", height or 30, parent)
    local header = parent:CreateFontString(id, "OVERLAY", "GameFontNormalLarge")
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y, 15)
    header:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y) -- El offset 15 se gestionaría con SetGap en el padre
    header:SetText(text)
    header:SetTextColor(1, 0.82, 0) -- Color dorado clásico de WoW
    header:SetSize(res.x, res.y)

    parent:addChild(id, header)

    return header
end

--- Crea una etiqueta de texto en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para la etiqueta.
---@param text string El texto que se mostrará en la etiqueta.
---@param width number|nil Ancho de la etiqueta (por defecto "100%").
---@param height number|nil Alto de la etiqueta (por defecto 20).
function WLVX:AddLabel(parent, id, text, width, height)
    if not parent then return end
    local res = WLVX:resolveDimensions(width or "100%", height or 20, parent)
    local label = parent:CreateFontString(id, "OVERLAY", "GameFontNormal")
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    label:SetText(text)
    label:SetSize(res.x, res.y)

    parent:addChild(id, label)

    return label
end

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

--- Crea un Slider (barra deslizadora) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el slider.
---@param text string El texto que se mostrará junto al slider.
---@param minVal number Valor mínimo del slider.
---@param maxVal number Valor máximo del slider.
---@param step number Paso de incremento del slider.
---@param defaultValue number Valor inicial del slider.
---@param width number|nil Ancho del slider (por defecto 200).
---@param height number|nil Alto del slider (por defecto 20).
---@param callback function|nil Función que se ejecutará al cambiar el valor del slider, recibiendo el nuevo valor como argumento.
function WLVX:AddSlider(parent, id, text, minVal, maxVal, step, defaultValue, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 200, height or 20, parent)
    local sliderName = "WLV_Slider_" .. (text:gsub("%s+", ""))
    local slider = CreateFrame("Slider", sliderName, parent, "OptionsSliderTemplate")
    slider:SetSize(res.x, res.y)
    slider.size = { width = res.x, height = res.y }
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    if parent.isHorizontal then
        slider:SetPoint("TOPLEFT", parent, "TOPLEFT", x, -10)
    else
        slider:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, y - 20)
    end
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

    parent:addChild(id, slider)

    return slider
end

--- Crea un cuadro de texto (EditBox) en el frame indicado.
---@param parent table El objeto frame padre.
---@param id string ID único para el cuadro de texto.
---@param labelText string El texto que se mostrará junto al cuadro de texto.
---@param defaultValue string Valor inicial del cuadro de texto.
---@param width number|nil Ancho del cuadro de texto (por defecto 200).
---@param height number|nil Alto del cuadro de texto (por defecto 20).
---@param callback function|nil Función que se ejecutará al cambiar el valor del cuadro de texto, recibiendo el nuevo valor como argumento.
function WLVX:AddEditBox(parent, id, labelText, defaultValue, width, height, callback)
    if not parent then return end

    local res = WLVX:resolveDimensions(width or 200, height or 20, parent)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetText(labelText)
    local eb = CreateFrame("EditBox", id, parent, "InputBoxTemplate")
    eb:SetSize(res.x, res.y)
    eb.size = { width = res.x, height = res.y }
    local x, y = WLVX:GetNextOffset(parent, res.x, res.y)
    if parent.isHorizontal then
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", x, 0)
        eb:SetPoint("TOPLEFT", label, "BOTTOMLEFT", 5, -2)
    else
        label:SetPoint("TOPLEFT", parent, "TOPLEFT", 30, y)
        eb:SetPoint("TOPLEFT", parent, "TOPLEFT", 35, y - 15)
    end
    eb:SetAutoFocus(false)
    eb:SetText(defaultValue or "")

    eb:SetScript("OnEnterPressed", function(self)
        if callback then callback(self:GetText()) end
        self:ClearFocus()
    end)

    eb:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)

    parent:addChild(id, eb)
    return eb
end

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