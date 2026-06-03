local addonName, WLVX = ...

--- Creates a generic container, equivalent to an HTML div.
---@param parent table
---@param id string
---@param props table|function|nil { width, height, x, y, direction, margin, gap, background, border }
---@param callback function|nil Receives the created container.
function WLVX:Div(parent, id, props, callback)
    if not parent then return end

    props, callback = WLVX:htmlNormalizeProps(props, callback)
    props.tag = props.tag or "div"

    local width = props.width or props.w or "100%"
    local height = props.height or props.h or props.size or 40
    local res = WLVX:resolveDimensions(width, height, parent)
    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    local div = WLVX:AddContainer(parent, id, width, height, x, y)

    local direction = props.direction or props.flexDirection or props.display
    if direction == "row" or direction == "horizontal" or direction == "flex" then
        div.isHorizontal = true
    elseif direction == "column" or direction == "vertical" then
        div.isHorizontal = false
    end

    WLVX:htmlApplyBoxProps(div, props)

    if type(callback) == "function" then
        callback(div)
    end

    return div
end


local function htmlSemanticContainer(tag)
    return function(self, parent, id, props, callback)
        props, callback = WLVX:htmlNormalizeProps(props, callback)
        props.tag = tag
        return self:Div(parent, id, props, callback)
    end
end

WLVX.Section = htmlSemanticContainer("section")
WLVX.Header = htmlSemanticContainer("header")
WLVX.Main = htmlSemanticContainer("main")
WLVX.Footer = htmlSemanticContainer("footer")
WLVX.Nav = htmlSemanticContainer("nav")
WLVX.Aside = htmlSemanticContainer("aside")
WLVX.Article = htmlSemanticContainer("article")
WLVX.Form = htmlSemanticContainer("form")