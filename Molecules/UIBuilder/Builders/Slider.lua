local addonName, WLVX = ...


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