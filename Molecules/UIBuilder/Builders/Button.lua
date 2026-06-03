local addonName, WLVX = ...

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

function WLVX:AddButtons(buttonList)
    if type(buttonList) ~= "table" then return end
    
    for _, btnData in ipairs(buttonList) do
        if btnData.menu and btnData.id and btnData.text then
            self:AddButton(btnData.menu, btnData.id, btnData.text, btnData.width, btnData.height, btnData.onClick, btnData.callback)
        end
    end
end