local addonName, WLVX = ...

--- Creates a label, equivalent to an HTML label.
---@param parent table
---@param id string
---@param props table|string { text, forId, width, height }
function WLVX:Label(parent, id, props)
    props = WLVX:htmlNormalizeProps(props)
    props.tag = "label"
    local label = WLVX:htmlCreateText(parent, id, "label", props, { height = 18, font = "GameFontNormalSmall" })
    label.forId = props.forId
    return label
end