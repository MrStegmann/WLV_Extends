local addonName, WLVX = ...

--- Creates a dropdown, equivalent to an HTML select.
---@param parent table
---@param id string
---@param props table { label, options, value, width, height, onChange }
function WLVX:Select(parent, id, props)
    props = WLVX:htmlNormalizeProps(props)
    props.tag = "select"
    local select = WLVX:AddDropdown(parent, id, props.label or props.text or "", props.options or props.items or {}, props.value or props.defaultValue, props.width or props.w, props.height or props.h, props.onChange or props.callback)
    WLVX:htmlApplyBoxProps(select, props)
    return select
end

--- Creates an option descriptor for Select.
---@param text string|table
---@param value any
function WLVX:Option(text, value)
    if type(text) == "table" then
        return { text = text.text or text.label, value = text.value }
    end

    return { text = text, value = value or text }
end