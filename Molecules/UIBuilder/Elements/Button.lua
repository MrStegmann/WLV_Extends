local addonName, WLVX = ...

--- Creates a button, equivalent to an HTML button.
---@param parent table
---@param id string
---@param props table|string { text, width, height, onClick, callback }
function WLVX:Button(parent, id, props)
    props = WLVX:htmlNormalizeProps(props)
    local button = WLVX:AddButton(parent, id, props.text or props.children or id, props.width or props.w, props.height or props.h, props.onClick, props.callback)
    WLVX:htmlApplyBoxProps(button, props)
    return button
end