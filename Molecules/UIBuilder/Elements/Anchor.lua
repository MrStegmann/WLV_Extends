local addonName, WLVX = ...

--- Creates a clickable text element, equivalent to an HTML anchor.
---@param id string
---@param parent table
---@param props table|string { text, href, onClick, width, height }
function WLVX:A(id, parent, props)
    if not parent then return end

    props = WLVX:htmlNormalizeProps(props)
    props.tag = "a"

    local width = props.width or props.w or "100%"
    local height = props.height or props.h or 20
    local res = WLVX:resolveDimensions(width, height, parent)
    local anchor = CreateFrame("Button", id, parent)
    anchor:SetSize(res.x, res.y)
    anchor.size = { width = res.x, height = res.y }
    anchor.htmlTag = "a"
    anchor.htmlProps = props

    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    anchor:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    anchor.text = anchor:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    anchor.text:SetAllPoints(anchor)
    anchor.text:SetJustifyH(props.justifyH or "LEFT")
    anchor.text:SetText(props.text or props.href or id)
    anchor.text:SetTextColor(0.35, 0.65, 1, 1)

    anchor:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
    anchor:SetScript("OnClick", function()
        if type(props.onClick) == "function" then
            props.onClick(props.href)
        end
    end)

    WLVX:htmlApplyBoxProps(anchor, props)
    WLVX:htmlRegisterChild(parent, id, anchor)
    return anchor
end