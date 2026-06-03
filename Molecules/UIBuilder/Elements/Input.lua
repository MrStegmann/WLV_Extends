
local addonName, WLVX = ...

--- Creates an input. Supported types: text, number, checkbox, range, color, keybind.
---@param parent table
---@param id string
---@param props table { type, label, value, checked, min, max, step, onChange, onInput, onCommit }
function WLVX:Input(parent, id, props)
    if not parent then return end

    props = WLVX:htmlNormalizeProps(props)
    props.tag = "input"

    local inputType = props.type or "text"

    if inputType == "checkbox" then
        local checkbox = WLVX:AddCheckbox(parent, id, props.label or props.text or "", props.checked or props.value or false, props.width or props.w, props.height or props.h, props.onChange or props.callback)
        WLVX:htmlApplyBoxProps(checkbox, props)
        return checkbox
    end

    if inputType == "range" then
        local slider = WLVX:AddSlider(parent, id, props.label or props.text or "", props.min or 0, props.max or 100, props.step or 1, props.value or props.defaultValue or props.min or 0, props.width or props.w, props.height or props.h, props.onChange or props.callback)
        WLVX:htmlApplyBoxProps(slider, props)
        return slider
    end

    if inputType == "color" then
        local value = props.value or {}
        local color = WLVX:AddColorPicker(parent, id, props.label or props.text or "Color", props.r or value.r or value[1], props.g or value.g or value[2], props.b or value.b or value[3], props.a or value.a or value[4], props.width or props.w, props.height or props.h, props.onChange or props.callback)
        WLVX:htmlApplyBoxProps(color, props)
        return color
    end

    if inputType == "keybind" then
        local keybind = WLVX:AddKeybind(parent, id, props.label or props.text or "", props.value or props.currentKey, props.width or props.w, props.height or props.h, props.onChange or props.callback)
        WLVX:htmlApplyBoxProps(keybind, props)
        return keybind
    end

    local width = props.width or props.w or 200
    local height = props.height or props.h or 20
    local res = WLVX:resolveDimensions(width, height, parent)
    local input = CreateFrame("EditBox", id, parent, "InputBoxTemplate")
    input:SetSize(res.x, res.y)
    input.size = { width = res.x, height = res.y }
    input.htmlTag = "input"
    input.htmlProps = props

    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    input:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    input:SetAutoFocus(props.autoFocus or false)
    input:SetNumeric(inputType == "number")
    input:SetMaxLetters(props.maxLength or props.maxLetters or 255)
    input:SetText(tostring(props.value or props.defaultValue or ""))

    input:SetScript("OnTextChanged", function(self, userInput)
        if userInput and type(props.onInput) == "function" then
            props.onInput(self:GetText(), self)
        end
    end)
    input:SetScript("OnEnterPressed", function(self)
        if type(props.onCommit) == "function" then props.onCommit(self:GetText(), self) end
        if type(props.onChange) == "function" then props.onChange(self:GetText(), self) end
        self:ClearFocus()
    end)
    input:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    input:SetScript("OnEditFocusLost", function(self)
        if type(props.onBlur) == "function" then props.onBlur(self:GetText(), self) end
    end)

    WLVX:htmlApplyBoxProps(input, props)
    WLVX:htmlRegisterChild(parent, id, input)
    return input
end