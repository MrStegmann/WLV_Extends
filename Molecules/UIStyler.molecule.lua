local addonName, WLVX = ...

-- ========================================================
-- UI STYLER MOLECULE
-- Funciones para personalizar la estética de los frames.
-- ========================================================
--- Alinea un frame o contenedor respecto a su padre basado en una etiqueta.
---@param frame table El objeto frame a alinear.
---@param alignTag string "Top" | "Bottom" | "Left" | "Right" | "Center"
function WLVX:Align(frame, alignTag)
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

--- Cambia el color de fondo de un frame.
---@param frame table El objeto frame a estilizar.
---@param r number Valor de rojo (0-1).
---@param g number Valor de verde (0-1).
---@param b number Valor de azul (0-1).
---@param a number Valor de alfa (0-1).
function WLVX:SetBackgroundColor(frame, r, g, b, a)
    if not frame or not frame.SetBackdropColor then return end
    frame:SetBackdropColor(r or 0, g or 0, b or 0, a or 1)
end

--- Cambia el color del borde de un frame.
---@param frame table El objeto frame a estilizar.
---@param r number Valor de rojo (0-1).
---@param g number Valor de verde (0-1).
---@param b number Valor de azul (0-1).
---@param a number Valor de alfa (0-1).
function WLVX:SetBorderColor(frame, r, g, b, a)
    if not frame or not frame.SetBackdropBorderColor then return end
    frame:SetBackdropBorderColor(r or 1, g or 1, b or 1, a or 1)
end

--- Cambia la estructura del fondo (Backdrop) de un frame.
---@param frame table El objeto frame a estilizar.
---@param backdrop table Tabla con la configuración del Backdrop (bgFile, edgeFile, etc).
function WLVX:SetFrameBackdrop(frame, backdrop)
    if not frame or not frame.SetBackdrop then return end
    frame:SetBackdrop(backdrop)
end

--- Aplica un estilo predefinido al frame.
---@param frame table El objeto frame a estilizar.
---@param styleName string Nombre del estilo: "Glass", "Solid", "Neon", "Paper".
function WLVX:ApplyPresetStyle(frame, styleName)
    if not frame then return end

    local styles = {
        ["Glass"] = {
            bg = {0, 0, 0, 0.4},
            border = {0.5, 0.5, 0.5, 0.8},
            backdrop = {
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true, tileSize = 16, edgeSize = 12,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            }
        },
        ["Neon"] = {
            bg = {0.05, 0.05, 0.05, 0.9},
            border = {0, 1, 0.8, 1}, -- Cian neón
            backdrop = {
                bgFile = "Interface/Buttons/WHITE8X8",
                edgeFile = "Interface/Buttons/WHITE8X8",
                tile = false, tileSize = 0, edgeSize = 2,
                insets = { left = 0, right = 0, top = 0, bottom = 0 }
            }
        },
        ["SoftNeonBlue"] = {
            bg = {0.02, 0.04, 0.08, 0.85},
            border = {0.25, 0.65, 1.0, 0.9},
            backdrop = {
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true,
                tileSize = 16,
                edgeSize = 14,
                insets = {
                    left = 3,
                    right = 3,
                    top = 3,
                    bottom = 3
                }
            }
        },
        ["ArcaneNeon"] = {
            bg = {0.03, 0.02, 0.08, 0.88},
            border = {0.45, 0.75, 1.0, 1.0},
            backdrop = {
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true,
                tileSize = 16,
                edgeSize = 16,
                insets = {
                    left = 4,
                    right = 4,
                    top = 4,
                    bottom = 4
                }
            }
        },
        ["Paper"] = {
            bg = {0.9, 0.85, 0.7, 0.95},
            border = {0.6, 0.5, 0.3, 1},
            backdrop = {
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true, tileSize = 16, edgeSize = 12,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            }
        },
        ["CyberBlue"] = {
            bg = {0.01, 0.03, 0.06, 0.92},
            border = {0.00, 0.80, 1.00, 1.00},
            backdrop = {
                bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
                tile = true,
                tileSize = 16,
                edgeSize = 14,
                insets = {
                    left = 2,
                    right = 2,
                    top = 2,
                    bottom = 2
                }
            }
        },
        ["Solid"] = {
            bg = {0.1, 0.1, 0.1, 1},
            border = {0, 0, 0, 1},
            backdrop = {
                bgFile = "Interface/Buttons/WHITE8X8",
                edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                tile = true, tileSize = 16, edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 }
            }
        }
    }

    local style = styles[styleName]
    if style then
        self:SetFrameBackdrop(frame, style.backdrop)
        self:SetBackgroundColor(frame, unpack(style.bg))
        self:SetBorderColor(frame, unpack(style.border))
    end
end

--- Permite cambiar la opacidad de todo el frame.
---@param frame table El objeto frame.
---@param alpha number Valor entre 0 y 1.
function WLVX:SetFrameOpacity(frame, alpha)
    if not frame then return end
    frame:SetAlpha(alpha or 1)
end

--- Define los márgenes (espacio exterior) de un frame.
---@param frame table El objeto frame.
---@param p1 number|nil 1 parám: todos. 2 paráms: X. 4 paráms: Arriba.
---@param p2 number|nil 2 paráms: Y. 4 paráms: Izquierda.
---@param p3 number|nil 4 paráms: Abajo.
---@param p4 number|nil 4 paráms: Derecha.
function WLVX:SetMargin(frame, p1, p2, p3, p4)
    if not frame then return end
    local m = {}
    if p1 ~= nil and p2 ~= nil and p3 ~= nil and p4 ~= nil then
        m.top, m.left, m.bottom, m.right = p1, p2, p3, p4
    elseif p1 ~= nil and p2 ~= nil and p3 ~= nil then
        error("WLVX:SetMargin recibió 3 parámetros. Se requieren 1, 2 o 4.")
    elseif p1 ~= nil and p2 ~= nil then
        m.left, m.right, m.top, m.bottom = p1, p1, p2, p2
    elseif p1 ~= nil then
        m.top, m.left, m.bottom, m.right = p1, p1, p1, p1
    end
    frame.margin = m

    -- Aplicar el margen inmediatamente ajustando la posición actual
    local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
    if point then
        frame:SetPoint(point, relativeTo, relativePoint, xOfs + (m.left or 0), yOfs - (m.top or 0))
    end

    -- Notificar al padre para que el siguiente elemento apilado respete este espacio
    local parent = frame:GetParent()
    if parent and parent.nextY ~= nil then
        parent.nextY = parent.nextY - (m.top or 0) - (m.bottom or 0)
    end
end

--- Define el padding (espacio interior) de un frame.
---@param frame table El objeto frame.
---@param p1 number|nil 1 parám: todos. 2 paráms: X. 4 paráms: Arriba.
---@param p2 number|nil 2 paráms: Y. 4 paráms: Izquierda.
---@param p3 number|nil 4 paráms: Abajo.
---@param p4 number|nil 4 paráms: Derecha.
function WLVX:SetPadding(frame, p1, p2, p3, p4)
    if not frame then return end
    local p = {}
    if p1 ~= nil and p2 ~= nil and p3 ~= nil and p4 ~= nil then
        p.top, p.left, p.bottom, p.right = p1, p2, p3, p4
    elseif p1 ~= nil and p2 ~= nil and p3 ~= nil then
        error("WLVX:SetPadding recibió 3 parámetros. Se requieren 1, 2 o 4.")
    elseif p1 ~= nil and p2 ~= nil then
        p.left, p.right, p.top, p.bottom = p1, p1, p2, p2
    elseif p1 ~= nil then
        p.top, p.left, p.bottom, p.right = p1, p1, p1, p1
    end
    frame.padding = p

    -- El padding ajusta el punto de inicio para los elementos que se añadan después
    frame.nextX = (frame.nextX or 0) + (p.left or 0)
    frame.nextY = (frame.nextY or 0) - (p.top or 0)
end

print("|cff00ff00[WLV_Molecule]|r UIStyler cargado correctamente.")