local addonName, WLVX = ...

--- Crea un contenedor genérico (Frame) dentro de otro. Se registra para poder ser usado como frameId.
---@param parent table El objeto frame padre.
---@param containerId string ID único para el nuevo contenedor (servirá como frameId para otros elementos).
function WLVX:AddContainer(parent, containerId, width, height, x, y)
    if not parent then return end
    print(width)
    print(height)
    local pW = parent:GetWidth() or 0
    local pH = parent:GetHeight() or 0
    local offX = x or 0
    local offY = y or 0

    local marginRight = (parent.styles and parent.styles.margin and parent.styles.margin.right) or 0
    local marginBottom = (parent.styles and parent.styles.margin and parent.styles.margin.bottom) or 0

    local w = math.max(1, width)
    local h = math.max(1, height)

    -- Prevenir desbordamiento horizontal considerando el margin del padre
    if pW > 0 and (offX + w) > (pW - marginRight) then
        w = math.max(1, pW - marginRight - offX)
    end

    -- Prevenir desbordamiento vertical considerando el margin del padre
    if pH > 0 and (math.abs(offY) + h) > (pH - marginBottom) then
        h = math.max(1, marginBottom - math.abs(offY))
    end

    local container = CreateFrame("Frame", containerId, parent, "BackdropTemplate")
    container:SetSize(w, h)
    container.size = { width = w, height = h }
    container.styles = { margin = { top = 0, right = 0, bottom = 0, left = 0 } }
    container:SetPoint("TOPLEFT", parent, "TOPLEFT", offX, offY)

    -- Establecemos un fondo base transparente para permitir que SetBackgroundColor funcione
    container:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        tile = true, tileSize = 16, edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    container:SetBackdropColor(0, 0, 0, 0)

    container.childrens = {}

    container.getChilds = WLVX.GetChilds
    container.getChildById = WLVX.GetChildById
    container.addChild = WLVX.AddChild
    container.removeChild = WLVX.RemoveChild

    -- Registramos el contenedor para que WLVX:GetMenu(containerId) pueda encontrarlo
    self.frames[containerId] = container

    parent:addChild(containerId, container)

    return container
end