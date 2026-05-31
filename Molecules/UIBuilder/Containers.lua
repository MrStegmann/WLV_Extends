local addonName, WLVX = ...

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

    local paddingRight = (parent.padding and parent.padding.right) or 0
    local paddingBottom = (parent.padding and parent.padding.bottom) or 0

    local w = math.max(1, res.x)
    local h = math.max(1, res.y)

    -- Prevenir desbordamiento horizontal considerando el padding del padre
    if pW > 0 and (offX + w) > (pW - paddingRight) then
        w = math.max(1, pW - paddingRight - offX)
    end

    -- Prevenir desbordamiento vertical considerando el padding del padre
    if pH > 0 and (math.abs(offY) + h) > (pH - paddingBottom) then
        h = math.max(1, pH - paddingBottom - math.abs(offY))
    end

    local container = CreateFrame("Frame", containerId, parent, "BackdropTemplate")
    container:SetSize(w, h)
    container.size = { width = w, height = h }
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
    local w, h = res.x, res.y
    local x, y = self:GetNextOffset(parent, w, h, 5)
    -- Colocamos la fila en la posición vertical actual del padre
    local row = self:AddContainer(parent, rowId, w, h, x, y)
    row.isHorizontal = true

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
    local x, y = self:GetNextOffset(parent, w, h, 5)

    -- Colocamos la columna según el puntero horizontal del padre
    local col = self:AddContainer(parent, colId, w, h, x, y)
    col.isHorizontal = false

    if type(callback) == "function" then
        callback(col)
    end

    return col
end