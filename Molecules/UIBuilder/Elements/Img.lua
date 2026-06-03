local addonName, WLVX = ...

--- Creates an image frame, equivalent to an HTML img.
---@param parent table
---@param id string
---@param props table { src, icon, width, height }
function WLVX:Img(parent, id, props)
    if not parent then return end

    props = WLVX:htmlNormalizeProps(props)
    props.tag = "img"

    local width = props.width or props.w or 32
    local height = props.height or props.h or 32
    local res = WLVX:resolveDimensions(width, height, parent)
    local img = CreateFrame("Frame", id, parent)
    img:SetSize(res.x, res.y)
    img.size = { width = res.x, height = res.y }
    img.htmlTag = "img"
    img.htmlProps = props

    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    img:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    img.texture = img:CreateTexture(nil, "ARTWORK")
    img.texture:SetAllPoints(img)
    img.texture:SetTexture(props.src or (props.icon and WLVX:setPathForIconName(props.icon)))

    WLVX:htmlApplyBoxProps(img, props)
    WLVX:htmlRegisterChild(parent, id, img)
    return img
end