local addonName, WLVX = ...

--- Creates a horizontal divider, equivalent to an HTML hr.
---@param parent table
---@param id string
---@param props table|nil { width, height, color }
function WLVX:Hr(parent, id, props)
    if not parent then return end

    props = WLVX:htmlNormalizeProps(props)
    props.tag = "hr"

    local width = props.width or props.w or "100%"
    local height = props.height or props.h or 1
    local res = WLVX:resolveDimensions(width, height, parent)
    local hr = CreateFrame("Frame", id, parent, "BackdropTemplate")
    hr:SetSize(res.x, res.y)
    hr.size = { width = res.x, height = res.y }
    hr.htmlTag = "hr"
    hr.htmlProps = props

    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    hr:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    WLVX:htmlSetBackdrop(hr)

    local c = props.color or { 1, 1, 1, 0.25 }
    hr:SetBackdropColor(c.r or c[1] or 1, c.g or c[2] or 1, c.b or c[3] or 1, c.a or c[4] or 0.25)

    WLVX:htmlRegisterChild(parent, id, hr)
    return hr
end