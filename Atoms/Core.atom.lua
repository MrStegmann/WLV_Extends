local addonName, WLVX = ...

-- =========================
-- FRAME PRINCIPAL
-- =========================
--- Crea un nuevo menu (Frame) con un titulo y dimensiones especificas.
---@param id string Identificador unico para registrar el menu.
---@param title string|nil (Opcional) Texto que se mostrara en la cabecera del menu.
---@param width number|nil (Opcional) Ancho del frame (por defecto 400).
---@param height number|nil (Opcional) Alto del frame (por defecto 500).
---@param callback function|nil (Opcional) Función que recibe el frame para inicializar su estructura.
---@param alwaysVisible boolean|nil (Opcional) Si es true, el menu siempre estará visible y no se podrá cerrar.
---@param callback function|nil (Opcional) Función que recibe el frame para inicializar su estructura.
---@return table frame El objeto Frame de WoW creado y configurado.
function WLVX:CreateMenu(id, title, movable, width, height, alwaysVisible, callback )
    if self.frames[id] then
        print("|cffff0000[WLVX]|r El menu con ID '" .. id .. "' ya existe.")
        return
    end
    local frame = CreateFrame("Frame", id, UIParent, "BackdropTemplate")
    frame:SetSize(width or 400, height or 500)
    frame:SetPoint("CENTER")
    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4
        }
    })

    frame:SetBackdropColor(0,0,0,0.95)
    frame:EnableMouse(movable)
    frame:SetMovable(movable)
    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function(self)
        if self:IsMovable() then
            self:StartMoving()
        end
    end)

    frame:SetScript("OnDragStop", function(self)
        if self:IsMovable() then
            self:StopMovingOrSizing()
            WLVX:SaveMenuPosition(self)
        end
    end)

    frame.alwaysVisible = alwaysVisible

    local titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    titleText:SetPoint("TOP", 0, -15)
    
    -- Ajuste dinámico del offset inicial según la presencia de título
    if title and title ~= "" then
        titleText:SetText(title)
        frame.nextY = -45
    elseif title == "" then
        titleText:SetText("")
        frame.nextY = -5 -- Margen mínimo si el título es explícitamente vacío
    else
        titleText:SetText("WLV Menu")
        frame.nextY = -45
    end

    -- Intentar cargar posición guardada al inicio
    local function LoadPosition(f)
        local name = f:GetName()
        if name and WLV_Extends_CHAR_DB and WLV_Extends_CHAR_DB.positions and WLV_Extends_CHAR_DB.positions[name] then
            local pos = WLV_Extends_CHAR_DB.positions[name]
            f:ClearAllPoints()
            f:SetPoint(pos.point, UIParent, pos.relativePoint, pos.x, pos.y)
        end
    end

    if IsLoggedIn() then
        LoadPosition(frame)
    end

    if not alwaysVisible then
        local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
        closeBtn:SetScript("OnClick", function() frame:Hide() end)
    end

    frame.buttons = {}

    self.frames[id] = frame

    if alwaysVisible then
        frame:Show()
    else
        frame:Hide()
    end

    if type(callback) == "function" then
        callback(frame)
    end
    print("WLVX: Menu creado correctamente:", id)
    return frame
end

-- =========================
-- GETTERS
-- =========================

function WLVX:GetMenu(id)
    if not self.frames[id] then
        print("|cffff0000[WLV]|r Menu no encontrado:", id)
        return nil
    end

    return self.frames[id]
end

-- =========================
-- PERSISTENCIA
-- =========================

--- Guarda la posición actual de un frame en la base de datos de SavedVariables.
---@param frame table El objeto frame cuya posición se desea guardar.
function WLVX:SaveMenuPosition(frame)
    local name = frame:GetName()
    if not name then return end

    local point, _, relativePoint, xOfs, yOfs = frame:GetPoint()
    WLV_Extends_CHAR_DB = WLV_Extends_CHAR_DB or {}
    WLV_Extends_CHAR_DB.positions = WLV_Extends_CHAR_DB.positions or {}
    WLV_Extends_CHAR_DB.positions[name] = { point = point, relativePoint = relativePoint, x = xOfs, y = yOfs }
end

-- =========================
-- TOGGLE MENU
-- =========================

function WLVX:ToggleMenu(id)
    local frame = self.frames[id]

    if not frame then
        print("|cffff0000[WLV]|r Menu no encontrado:", id)
        return
    end

    if frame.alwaysVisible then return end

    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

-- =========================
-- COMANDOS
-- =========================

function WLVX:RegisterCommand(command, callback)
    SlashCmdList[command] = callback
    _G["SLASH_" .. command .. "1"] = "/" .. string.lower(command)

    self.commands[command] = callback
end

-- =========================
-- BOTÓN EN PANTALLA
-- =========================

function WLVX:CreateScreenButton(text, x, y, frameId)
    local btn = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
    btn:SetSize(120, 40)
    btn:SetPoint("CENTER", x or 0, y or 0)
    btn:SetText(text)

    btn:SetScript("OnClick", function()
        if frameId then
            WLVX:ToggleMenu(frameId)
        end
    end)

    return btn
end

-- =========================
-- BOTÓN MINIMAPA
-- =========================
--- Crea un botón en el minimapa.
---@param iconName string Nombre del icono.
---@param sizeX number|nil Ancho (por defecto 32).
---@param sizeY number|nil Alto (por defecto 32).
---@param frameId string ID del menú que debe abrir/cerrar.
---@param callback function|nil Función que recibe el botón creado para inicializarlo.
function WLVX:CreateMinimapButton(iconName, frameId, callback)
    if not frameId then return print("|cffff0000[WLVX]|r ID del menú no proporcionado para el botón de minimapa.") end
    local name = "WLVX_MinimapButton" .. frameId
    local button = CreateFrame("Button", name, Minimap)

    -- Configuración básica del botón
    button:SetSize(32, 32)
    button:SetFrameStrata("MEDIUM")
    button:SetMovable(true)
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")

    -- Icono del botón del minimapa
    local iconTex = button:CreateTexture(nil, "BACKGROUND")

    iconTex:SetTexture(WLVX:setPathForIconName(iconName))
    iconTex:SetSize(18, 18)
    iconTex:SetPoint("CENTER", 0, 0)
    button.icon = iconTex

    -- Highlight del botón del minimapa
    local highlight = button:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    highlight:SetBlendMode("ADD")
    highlight:SetSize(56, 56)
    highlight:SetPoint("CENTER")

    -- Borde del botón del minimapa
    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    border:SetSize(54, 54)
    border:SetPoint("TOPLEFT")

    -- Función interna para actualizar posición circular
    local function UpdatePosition(self)
        local angle = self.angle or 220
        local radians = math.rad(angle)
        local radius = 80 -- Definición de radius añadida aquí
        self:ClearAllPoints()
        self:SetPoint("CENTER", Minimap, "CENTER", math.cos(radians) * radius, math.sin(radians) * radius)
    end

    local function LoadPosition(self)
        WLV_Extends_CHAR_DB = WLV_Extends_CHAR_DB or {}
        WLV_Extends_CHAR_DB.minimap = WLV_Extends_CHAR_DB.minimap or {}

        self.angle = WLV_Extends_CHAR_DB.minimap[name] or 220

       UpdatePosition(self)
    end

    if IsLoggedIn() then
        LoadPosition(button)
    else
         button:RegisterEvent("PLAYER_LOGIN")
        button:RegisterEvent("PLAYER_LOGIN")
        button:SetScript("OnEvent", function(self)
            LoadPosition(self)
        end)
    end

    -- Lógica de arrastre (Drag)
    button:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()

            local mx, my = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            local px, py = Minimap:GetCenter()
            local angle = math.deg(math.atan2((my / scale) - py, (mx / scale) - px))
            self.angle = angle
            UpdatePosition(self)
        end)
    end)

    button:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
        WLV_Extends_CHAR_DB = WLV_Extends_CHAR_DB or {}
        WLV_Extends_CHAR_DB.minimap = WLV_Extends_CHAR_DB.minimap or {}
        WLV_Extends_CHAR_DB.minimap[name] = self.angle

    end)


    button:SetScript("OnClick", function()
        if frameId then
            WLVX:ToggleMenu(frameId)
        end
    end)

    if type(callback) == "function" then
        callback(button)
    end


    WLVX.frames[name] = button
    print("WLVX: Botón de minimapa creado correctamente:", name)
    return button
end

print("|cff00ff00[WLV_Atoms]|r cargado correctamente.")