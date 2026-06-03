local addonName, WLVX = ...

function WLVX:Container(id, parent, size, styles, callback)
    if not parent then return end

    -- Resolución de dimensiones con prevención de desbordamiento
    local res = WLVX:resolveDimensions(size.width or 100, size.height or 100, parent)
    local pW = parent:GetWidth() or 0
    local pH = parent:GetHeight() or 0
    local offX = 0
    local offY = 0
    local marginRight = (parent.styles and parent.styles.margin and parent.styles.margin.right) or 0
    local marginBottom = (parent.styles and parent.styles.margin and parent.styles.margin.bottom) or 0
    local w = math.max(1, res.x)
    local h = math.max(1, res.y)
    -- Prevenir desbordamiento horizontal considerando el margin del padre
    if pW > 0 and (offX + w) > (pW - marginRight) then
        w = math.max(1, pW - marginRight - offX)
    end
    -- Prevenir desbordamiento vertical considerando el margin del padre
    if pH > 0 and (math.abs(offY) + h) > (pH - marginBottom) then
        h = math.max(1, pH - marginBottom - math.abs(offY))
    end


    local container = CreateFrame("Frame", id, parent, "BackdropTemplate")
    container:SetSize(w, h)
    container.size = { width = w, height = h }
    container.styles = styles or { margin = { top = 0, right = 0, bottom = 0, left = 0 } }

    -- Configuración de dirección de apilado basada en estilos
    if styles.display == "row" then container.isHorizontal = true end
    if styles.display == "column" then container.isHorizontal = false end

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
    -- Registramos el contenedor para que WLVX:GetMenu(id) pueda encontrarlo
    self.frames[id] = container
    parent:addChild(id, container)
    
    if type(callback) == "function" then
        callback(container)
    end
    return container
end