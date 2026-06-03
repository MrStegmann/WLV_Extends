local addonName, WLVX = ...

function WLVX:htmlNormalizeProps(props, callback)
    if type(props) == "function" then
        return {}, props
    end

    if type(props) == "string" or type(props) == "number" then
        return { text = tostring(props) }, callback
    end

    if type(props) == "table" then
        return props, callback
    end

    return {}, callback
end


function WLVX:htmlRegisterChild(parent, id, child)
    if parent and id and child and type(parent.addChild) == "function" then
        parent:addChild(id, child)
    end
end



function WLVX:htmlSetBackdrop(frame)
    if not frame or not frame.SetBackdrop then return end

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = true,
        tileSize = 16,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
end

function WLVX:htmlApplyBoxProps(frame, props)
    if not frame then return end

    frame.htmlTag = props.tag or frame.htmlTag
    frame.htmlProps = props

    if props.hidden then frame:Hide() end
    if props.alpha then frame:SetAlpha(props.alpha) end
    if props.enableMouse ~= nil then frame:EnableMouse(props.enableMouse) end

    if props.background or props.bg then
        local c = props.background or props.bg
        WLVX:htmlSetBackdrop(frame)
        frame:SetBackdropColor(c.r or c[1] or 0, c.g or c[2] or 0, c.b or c[3] or 0, c.a or c[4] or 1)
    end

    if props.border then
        local c = props.border
        WLVX:htmlSetBackdrop(frame)
        if frame.SetBackdropBorderColor then
            frame:SetBackdropBorderColor(c.r or c[1] or 1, c.g or c[2] or 1, c.b or c[3] or 1, c.a or c[4] or 1)
        end
    end

    if props.margin then
        local m = props.margin
        if type(m) == "number" then
            WLVX:SetMargin(frame, m)
        else
            WLVX:SetMargin(frame, m.top or 0, m.left or 0, m.bottom or 0, m.right or 0)
        end
    end

    if props.gap then WLVX:SetGap(frame, props.gap) end
    if props.align then WLVX:Align(frame, props.align) end

    if props.tooltip then
        local tooltip = props.tooltip
        if type(tooltip) == "string" then
            WLVX:CreateTooltip(frame, tooltip)
        else
            WLVX:CreateTooltip(frame, tooltip.title, tooltip.lines)
        end
    end

    if type(props.onEnter) == "function" then frame:SetScript("OnEnter", props.onEnter) end
    if type(props.onLeave) == "function" then frame:SetScript("OnLeave", props.onLeave) end
    if type(props.onShow) == "function" then frame:SetScript("OnShow", props.onShow) end
    if type(props.onHide) == "function" then frame:SetScript("OnHide", props.onHide) end
end

function WLVX:htmlGetFlowPoint(parent, w, h, props)
    if props.x ~= nil or props.y ~= nil then
        return props.x or 0, props.y or 0
    end

    return WLVX:GetNextOffset(parent, w, h)
end

function WLVX:htmlCreateText(parent, id, tag, props, defaults)
    if not parent then return end

    props = WLVX:htmlNormalizeProps(props)
    props.tag = tag

    local width = props.width or props.w or defaults.width or "100%"
    local height = props.height or props.h or defaults.height or 20
    local res = WLVX:resolveDimensions(width, height, parent)
    local font = props.font or defaults.font or "GameFontNormal"
    local text = parent:CreateFontString(id, "OVERLAY", font)
    text:SetSize(res.x, res.y)
    text.size = { width = res.x, height = res.y }
    text.htmlTag = tag
    text.htmlProps = props

    local x, y = WLVX:htmlGetFlowPoint(parent, res.x, res.y, props)
    text:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    text:SetText(props.text or props.children or "")

    if props.color or defaults.color then
        local c = props.color or defaults.color
        text:SetTextColor(c.r or c[1] or 1, c.g or c[2] or 1, c.b or c[3] or 1, c.a or c[4] or 1)
    end

    if props.justifyH then text:SetJustifyH(props.justifyH) end
    if props.justifyV then text:SetJustifyV(props.justifyV) end
    if props.scale then text:SetScale(props.scale) end

    WLVX:htmlRegisterChild(parent, id, text)
    return text
end